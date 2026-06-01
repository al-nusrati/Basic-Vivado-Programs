//===================================================  
// Module: SWLED  
// Description: Simple NOT gate implementation  
//              LED output is the inverted value of SW input  
//===================================================  

module swLED(
    output wire L1,         // **Output**: LED (Inverted state of SW)  
    input  wire S1           // **Input**: Switch (SW) signal  
    );  

    //-------------- Logic Implementation --------------  
        assign L1 = ~(~(~S1));
  
endmodule // SWLED