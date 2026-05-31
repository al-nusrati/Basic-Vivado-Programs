//===================================================  
// Module: myNOT  
// Description: A Simple NOT Gate
//              1 input 1 output
//===================================================  
module myNOT(
    output wire out1,
    input wire in1
    );
    
    //-------------- Logic Implementation --------------
    not not_1(out1, in1);

endmodule
