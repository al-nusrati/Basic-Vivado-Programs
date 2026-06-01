// Top module with ALU and display
module ALU_System_Top(
    input clk,              // 100 MHz clock from Basys-3
    input reset,            // Reset button
    input [3:0] A,          // 4-bit input A (switches)
    input [3:0] B,          // 4-bit input B (switches)
    input [2:0] op_sel,     // Operation selector (switches)
    output [6:0] seg,       // Seven-segment display segments
    output [3:0] an,        // Seven-segment display anodes
    output dp,              // Decimal point
    output [7:0] led        // LEDs for debugging
);
    wire [7:0] alu_result;
    
    // ALU instance
    ALU alu_inst (
        .A(A),
        .B(B),
        .Op_sel(op_sel),
        .Result(alu_result)
    );
    
    // Output alu_result to LEDs for debugging
    assign led = alu_result;
    
    // Seven-segment display controller
    Seven_Segment_Display display_inst (
        .clk(clk),
        .reset(reset),
        .value(alu_result),
        .seg(seg),
        .an(an),
        .dp(dp)
    );
endmodule
