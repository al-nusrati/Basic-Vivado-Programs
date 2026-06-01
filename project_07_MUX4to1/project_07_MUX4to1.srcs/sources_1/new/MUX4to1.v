//===================================================  
// Module: template  
// Description: 4 separate inputs are mapped
//              onto 4 output LEDs array
//===================================================  
module MUX4to1(
    output wire [3:0]out,
    input wire [3:0]a, [3:0]b, [3:0]c, [3:0]d,  
    input wire [1:0]X
    );

    //-------------- Logic Implementation --------------

    assign out = X[1] ? (X[0] ? a : b) 
                      : (X[0] ? c : d);

endmodule