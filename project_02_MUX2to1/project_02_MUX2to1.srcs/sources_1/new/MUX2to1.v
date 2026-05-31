//===================================================  
// Module: MUX2to1  
// Description: 4 separate inputs are mapped
//              onto 4 output LEDs array
//===================================================  
module MUX2to1(
    output wire out1,
    input wire A, B, X
    );
/*
    //-------------- Internal Signals --------------
    wire not_x;
    wire out_and1, out_and2;

        //-------------- METHOD 1 --------------
    //-------------- Gate level implementation --------------
    not not1(not_x, X);

    and and1(out_and1, A, not_x);
    and and2(out_and2, B, X);
    or or1(out1, out_and1, out_and2);
*/
/*    
        //-------------- METHOD 2 --------------
    //-------------- Dataflow Level Implementation / Bitwise Logic Description --------------
    assign out1 = (B & X) | (A & ~X);
*/

        //-------------- METHOD 3 --------------
/*
    //-------------- Behavioural Level Internal Reg --------------
    reg out_beh;
    
    //-------------- Behavioural Level Implementation --------------
    always@ (*) begin 
    //if (X)
    //  out_beh = A;
    //else 
    //    out_beh = B;
    out_beh = X ? A : B;
    
    end
        
    // connect the behavioural output reg to wire out1
    assign out1 = out_beh;
    
*/   
    assign out1 = X ? A : B;
    
    
    
    
    
    
    
    
    

endmodule
