`timescale 1ns / 1ps
module ALU_System_Top_tb();
    // Inputs
    reg clk;
    reg reset;
    reg [3:0] A;
    reg [3:0] B;
    reg [2:0] op_sel;
    
    // Outputs
    wire [6:0] seg;
    wire [3:0] an;
    wire dp;
    wire [7:0] alu_result; // For debugging
    
    // Instantiate the Unit Under Test (UUT)
    ALU_System_Top uut ( clk, reset, A, B, op_sel, seg, an, dp );
    
    // Connect alu_result for monitoring
    assign alu_result = uut.alu_result;
    
    // Clock generation (100 MHz, 10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns period
    end
    
    // Test procedure
    initial begin
        // Initialize inputs
        reset = 1;
        A = 4'b0000;
        B = 4'b0000;
        op_sel = 3'b000;
        
        // Release reset
        #100;
        reset = 0;
        
        // Test all operations with A=5, B=3
        A = 4'b0101; // 5
        B = 4'b0011; // 3
        
        // ADD (5 + 3 = 8)
        op_sel = 3'b000;
        #2000000; // Wait 2 ms for display refresh
        
        // SUB (5 - 3 = 2)
        op_sel = 3'b001;
        #2000000;
        
        // INC (5 + 1 = 6)
        op_sel = 3'b010;
        #2000000;
        
        // DEC (5 - 1 = 4)
        op_sel = 3'b011;
        #2000000;
        
        // AND (5 & 3 = 1)
        op_sel = 3'b100;
        #2000000;
        
        // OR (5 | 3 = 7)
        op_sel = 3'b101;
        #2000000;
        
        // XOR (5 ^ 3 = 6)
        op_sel = 3'b110;
        #2000000;
        
        // NOT (~5 = 10, 4-bit: 1010)
        op_sel = 3'b111;
        #2000000;
        
        // Test reset
        reset = 1;
        #100;
        reset = 0;
        
        // Test edge case: ADD with overflow (15 + 1 = 16)
        A = 4'b1111; // 15
        B = 4'b0001; // 1
        op_sel = 3'b000;
        #2000000;
        
        $finish;
    end
    
    // Monitor outputs
    initial begin
        $monitor("Time=%t, A=%b, B=%b, op_sel=%b, alu_result=%h, seg=%b, an=%b, dp=%b",
                 $time, A, B, op_sel, alu_result, seg, an, dp);
    end
endmodule