`timescale 1ns / 1ps
//===================================================  
// Testbench: tb_LEDArray  
// Description: Simple testbench to verify the behavior of  
//              4x inputs to LEDs, 2 of which are inverterd
//===================================================

module tb_LEDArray();

    //-------------- Testbench Signals --------------
    // Outputs are always defined as wire in testbench
    // Inputs are always defined as reg in testbench
    
    //-------------- Instantiate Modules (CUT : Circuit Under Test) --------------
		template CUT ();
						// *Positional Port Mapping*
						// Alternative Style (Named Port Mapping)     (.LED(LED), .SW(SW));

    //-------------- Stimulus Generation --------------
    initial begin
    end

endmodule