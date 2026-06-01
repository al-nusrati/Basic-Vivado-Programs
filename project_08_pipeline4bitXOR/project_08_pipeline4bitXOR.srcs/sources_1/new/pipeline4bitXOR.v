//===================================================  
// Module: pipelined_4bitXOR  
// Description: 2-Stage Pipelined XOR using 8 Switches and 4 LEDs  
//===================================================  

module pipeline4bitXOR (
    input wire CLK,          // 100MHz system clock (Basys 3)
    input wire [7:0] SW,     // Standard switches SW[7:0]
    output reg [3:0] LED     // Standard LEDs LED[3:0]
);

    //-------------- Pipeline Registers --------------  
    reg [3:0] stage1_a;  // Pipeline Stage 1: First 4 bits
    reg [3:0] stage1_b;  // Pipeline Stage 1: Second 4 bits
    reg [3:0] stage2_out; // Pipeline Stage 2: XOR result

    //-------------- Stage 1: Register Inputs --------------  
    always @(posedge CLK) begin
        stage1_a <= SW[3:0];  // Store lower 4 bits
        stage1_b <= SW[7:4];  // Store upper 4 bits
    end

    //-------------- Stage 2: XOR Computation --------------  
    always @(posedge CLK) begin
        stage2_out <= stage1_a ^ stage1_b;  // XOR operation
    end

    //-------------- Output Assignment --------------  
    always @(posedge CLK) begin
        LED <= stage2_out;  // Assign the final XOR result to LEDs
    end

endmodule // pipelined_4bitXOR

//============================================================  
// Explanation:  
// - *Uses 2 pipeline stages*:  
//   - *Stage 1: Registers **SW[3:0]* and *SW[7:4]*  
//   - *Stage 2*: XORs the stored values and outputs result  
// - *Pipeline effect*:  
//   - New values propagate through registers in each clock cycle  
//   - Reduces combinational delay, making design efficient  
//===================================================