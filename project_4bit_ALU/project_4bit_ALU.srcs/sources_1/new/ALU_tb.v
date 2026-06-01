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
    wire [7:0] led;
    
    // Instantiate the Unit Under Test (UUT)
    ALU_System_Top uut (
        .clk(clk),
        .reset(reset),
        .A(A),
        .B(B),
        .op_sel(op_sel),
        .seg(seg),
        .an(an),
        .dp(dp),
        .led(led)
    );
    
    // Clock generation (100 MHz, 10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
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
        #100;
        
        // SUB (5 - 3 = 2)
        op_sel = 3'b001;
        #100;
        
        // INC (5 + 1 = 6)
        op_sel = 3'b010;
        #100;
        
        // DEC (5 - 1 = 4)
        op_sel = 3'b011;
        #100;
        
        // AND (5 & 3 = 1)
        op_sel = 3'b100;
        #100;
        
        // OR (5 | 3 = 7)
        op_sel = 3'b101;
        #100;
        
        // XOR (5 ^ 3 = 6)
        op_sel = 3'b110;
        #100;
        
        // NOT (~5 = 10, 4-bit: 1010)
        op_sel = 3'b111;
        #100;
        
        // Test edge case: ADD with overflow (15 + 1 = 16)
        A = 4'b1111; // 15
        B = 4'b0001; // 1
        op_sel = 3'b000;
        #100;
        
        // Test reset
        reset = 1;
        #100;
        reset = 0;
        
        #1000;
        $finish;
    end
    
    // Monitor outputs
    initial begin
        $monitor("Time=%t, A=%b(%d), B=%b(%d), op_sel=%b, result=%b(%d), an=%b, seg=%b",
                 $time, A, A, B, B, op_sel, led, led, an, seg);
    end
endmodule