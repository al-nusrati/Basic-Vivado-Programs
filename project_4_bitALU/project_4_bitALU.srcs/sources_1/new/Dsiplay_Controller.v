// Seven-segment display controller for Basys-3
module Display_Controller(
    input clk,                  // 100 MHz clock
    input reset,                // Reset
    input [7:0] value_to_display, // Value to display (8-bit)
    input blank_leading_zeros,  // Enable blanking of leading zeros
    output reg [3:0] an,        // Anode signals for 4 digits
    output reg [6:0] seg,       // Segment signals (a-g)
    output reg dp               // Decimal point
);
    // Clock divider for ~1 kHz refresh rate
    reg [16:0] refresh_counter;
    wire refresh_tick;
    parameter REFRESH_PERIOD = 17'd100000; // 1 ms at 100 MHz

    // Digit selection
    reg [1:0] digit_select;
    reg [3:0] current_digit;
    reg [6:0] seg_patterns [0:15];

    // Initialize segment patterns for 0-15 (hexadecimal)
    initial begin
        seg_patterns[0] = 7'b1000000;  // 0
        seg_patterns[1] = 7'b1111001;  // 1
        seg_patterns[2] = 7'b0100100;  // 2
        seg_patterns[3] = 7'b0110000;  // 3
        seg_patterns[4] = 7'b0011001;  // 4
        seg_patterns[5] = 7'b0010010;  // 5
        seg_patterns[6] = 7'b0000010;  // 6
        seg_patterns[7] = 7'b1111000;  // 7
        seg_patterns[8] = 7'b0000000;  // 8
        seg_patterns[9] = 7'b0010000;  // 9
        seg_patterns[10] = 7'b0001000; // A
        seg_patterns[11] = 7'b0000011; // B
        seg_patterns[12] = 7'b1000110; // C
        seg_patterns[13] = 7'b0100001; // D
        seg_patterns[14] = 7'b0000110; // E
        seg_patterns[15] = 7'b0001110; // F
    end

    // Refresh counter
    always @(posedge clk or posedge reset) begin
        if (reset)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end
    assign refresh_tick = (refresh_counter == REFRESH_PERIOD);

    // Digit selection and display
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            digit_select <= 0;
            an <= 4'b1111; // All digits off
            seg <= 7'b1111111; // All segments off
            dp <= 1; // Decimal point off
        end
        else if (refresh_tick) begin
            digit_select <= digit_select + 1;
            case (digit_select)
                2'b00: begin
                    an <= 4'b1110; // Digit 0 (rightmost)
                    current_digit <= value_to_display[3:0]; // Lower 4 bits
                    if (blank_leading_zeros && value_to_display[7:4] == 4'h0 && value_to_display[3:0] == 4'h0)
                        seg <= 7'b1111111; // Blank if leading zero
                    else
                        seg <= seg_patterns[current_digit];
                    dp <= 1;
                end
                2'b01: begin
                    an <= 4'b1101; // Digit 1
                    current_digit <= value_to_display[7:4]; // Upper 4 bits
                    if (blank_leading_zeros && value_to_display[7:4] == 4'h0)
                        seg <= 7'b1111111; // Blank if leading zero
                    else
                        seg <= seg_patterns[current_digit];
                    dp <= 1;
                end
                2'b10: begin
                    an <= 4'b1011; // Digit 2
                    seg <= 7'b1111111; // Unused (blank)
                    dp <= 1;
                end
                2'b11: begin
                    an <= 4'b0111; // Digit 3
                    seg <= 7'b1111111; // Unused (blank)
                    dp <= 1;
                end
            endcase
        end
    end
endmodule