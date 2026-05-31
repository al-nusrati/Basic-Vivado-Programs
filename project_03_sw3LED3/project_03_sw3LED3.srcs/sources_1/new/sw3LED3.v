//===================================================  
// Module: sw3LED3  
// Description: 3-bit bus
//              
//===================================================  
module sw3LED3(
    output wire [2:0]LEDs,
    input wire [2:0]SWs
    );

    //-------------- Logic Implementation --------------
    assign LEDs = ~SWs;
    
   
endmodule   // sw3LED3