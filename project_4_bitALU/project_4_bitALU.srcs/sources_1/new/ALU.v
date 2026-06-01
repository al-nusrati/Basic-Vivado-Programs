// 4-bit ALU module
module ALU(
    input [3:0] A,           // First operand (4-bit)
    input [3:0] B,           // Second operand (4-bit)
    input [2:0] Op_sel,      // Operation selector
    output reg [7:0] Result  // 8-bit result to accommodate overflow
);
    always @(*) begin
        case (Op_sel)
            3'b000: Result = A + B;                     // ADD
            3'b001: Result = (A >= B) ? A - B : 8'h00;  // SUB (floor at 0)
            3'b010: Result = A + 1'b1;                  // INC
            3'b011: Result = (A > 0) ? A - 1'b1 : 8'h00;// DEC (floor at 0)
            3'b100: Result = A & B;                     // AND
            3'b101: Result = A | B;                     // OR
            3'b110: Result = A ^ B;                     // XOR
            3'b111: Result = ~(A & B);                  // NAND 
            default: Result = 8'h00;                    // Default
        endcase
    end
endmodule