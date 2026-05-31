//===================================================  
// Module: template  
// Description: 4 separate inputs are mapped
//              onto 4 output LEDs array
//===================================================  
module template(
    output wire [3:0]out1,
    input wire [3:0]in1, [3:0]in2,
    input wire X
    );

    //-------------- Logic Implementation --------------
    assign out1 = X ? in1 : in2;
    
endmodule
