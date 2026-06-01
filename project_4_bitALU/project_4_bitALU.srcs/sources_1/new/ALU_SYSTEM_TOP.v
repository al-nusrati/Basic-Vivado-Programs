module ALU_System_Top(
    input clk,                  // 100 MHz system clock
    input reset,                // Reset button
    input [3:0] A,              // 4-bit input A (switches)
    input [3:0] B,              // 4-bit input B (switches)
    input [2:0] op_sel,         // Operation selector (switches)
    output [6:0] seg,           // Seven-segment display segments
    output [3:0] an,            // Seven-segment display anodes
    output dp                   // Decimal point (unused)
);
    wire [7:0] alu_result;      // ALU output (8-bit to handle overflow)

    // ALU instance
    ALU alu_inst ( A, B, op_sel, alu_result );
    // Display controller instance
    Display_Controller display_ctrl ( clk, reset, alu_result, 1'b1, an, seg, dp );

endmodule