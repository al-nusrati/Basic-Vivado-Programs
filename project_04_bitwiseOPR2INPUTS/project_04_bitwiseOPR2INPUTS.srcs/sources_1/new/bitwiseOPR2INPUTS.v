//===================================================  
// Module: bitwiseOPR2INPUTS  
// Description: 4 separate inputs are mapped
//              onto 4 output LEDs array
//===================================================  
module bitwiseOPR2INPUTS(
    output wire [4:0]LED,
    input wire a, b
    );

    //-------------- Logic Implementation --------------
    assign LED[0] = a & b;
    assign LED[1] = ~(a & b);
    assign LED[2] = a | b;
    assign LED[3] = ~(a | b);
    assign LED[4] = a ^ b;
    
    
    

endmodule