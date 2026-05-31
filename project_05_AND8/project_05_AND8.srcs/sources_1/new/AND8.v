//===================================================  
// Module: AND8 
// Description: AND8
//              8 input Array & 1 output
//===================================================  
module AND8(
    output wire out1,
    input wire [7:0]inp
    );

    //-------------- Logic Implementation --------------
    assign out1 = &inp;
    
endmodule
