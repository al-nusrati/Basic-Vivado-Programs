module Seven_Segment_Display(
    input clk,                  // 100 MHz clock
    input reset,                // Reset
    input [7:0] value,          // Value to display (8-bit)
    output reg [6:0] seg,       // Segment signals (a-g)
    output reg [3:0] an,        // Anode signals for 4 digits
    output reg dp               // Decimal point
);
    // Clock divider for display refresh
    reg [16:0] refresh_counter;
    reg [1:0] active_digit;
    
    // Seven-segment digit patterns (0-F)
    // Format: 7'bGFEDCBA (active low)
    reg [6:0] digit_patterns [0:15];
    initial begin
        digit_patterns[0] = 7'b1000000;  // 0
        digit_patterns[1] = 7'b1111001;  // 1
        digit_patterns[2] = 7'b0100100;  // 2
        digit_patterns[3] = 7'b0110000;  // 3
        digit_patterns[4] = 7'b0011001;  // 4
        digit_patterns[5] = 7'b0010010;  // 5
        digit_patterns[6] = 7'b0000010;  // 6
        digit_patterns[7] = 7'b1111000;  // 7
        digit_patterns[8] = 7'b0000000;  // 8
        digit_patterns[9] = 7'b0010000;  // 9
        digit_patterns[10] = 7'b0001000; // A
        digit_patterns[11] = 7'b0000011; // B
        digit_patterns[12] = 7'b1000110; // C
        digit_patterns[13] = 7'b0100001; // D
        digit_patterns[14] = 7'b0000110; // E
        digit_patterns[15] = 7'b0001110; // F
    end
    
    // Clock divider for display refresh
    always @(posedge clk or posedge reset) begin
        if (reset)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end
    
    // Digit selection logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            active_digit <= 0;
            an <= 4'b1111;      // All digits off
            seg <= 7'b1111111;  // All segments off
            dp <= 1;            // DP off
        end else if (refresh_counter == 0) begin
            // Update active digit on counter overflow
            active_digit <= active_digit + 1;
            
            case (active_digit)
                2'b00: begin
                    an <= 4'b1110;  // Rightmost digit active
                    seg <= digit_patterns[value[3:0]];
                end
                2'b01: begin
                    an <= 4'b1101;  // Second digit from right
                    seg <= digit_patterns[value[7:4]];
                end
                2'b10: begin
                    an <= 4'b1011;  // Third digit from right
                    seg <= 7'b1111111;  // Blank
                end
                2'b11: begin
                    an <= 4'b0111;  // Leftmost digit
                    seg <= 7'b1111111;  // Blank
                end
            endcase
            
            dp <= 1;  // DP always off
        end
    end
endmodule