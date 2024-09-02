`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCF EEL5722C with Dr. Lin
// Engineer: Alexander Hatzilias
// 
// Create Date: 09/01/2024 08:07:12 PM
// Design Name: Basys 3 Keyboard Input Driver 
// Module Name: Top Level Testbench
// Project Name: 
// Target Devices: Digilent Basys 3 (Artix 7) 
// Tool Versions: Vivado 2024
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_tb(   );

    logic clk ; 
    logic kbd_clk ; 
    logic kbd_data ; 
    logic [3:0] anode ; 
    logic [7:0] cathode ; 


kbd_top uut 
( .clk (clk)
, .kbd_clk (kbd_clk)
, .raw_kbd_data (kbd_data)
, .anode    (anode)
, .cathode  (cathode)
) ; 


always #1 clk = ~clk ; 


initial begin
    kbd_data = '1 ; 
    #100
    kbd_data = '0 ;         // start condition
    #10 
    kbd_data = '0 ;         // 0010
    #10 
    kbd_data = '0 ; 
    #10 
    kbd_data = '1 ; 
    #10 
    kbd_data = '0 ; 
    #10 
    kbd_data = '0 ;         // 0101
    #10
    kbd_data = '1 ; 
    #10 
    kbd_data = '0 ; 
    #10 
    kbd_data = '1 ; 
end


initial begin
    #100
    kbd_clk = '1 ; 
    #5
    kbd_clk = '0 ; 
    #5
    kbd_clk = '1 ; 
    #5
    kbd_clk = '0 ; 
    #5
    kbd_clk = '1 ; 
    #5
    kbd_clk = '0 ; 
    #5
    kbd_clk = '1 ; 
    #5
    kbd_clk = '0 ; 
    #5
    kbd_clk = '1 ; 
    #5
    kbd_clk = '0 ; 
    #5
    kbd_clk = '1 ; 
    #5
    kbd_clk = '0 ; 
    #5
    kbd_clk = '1 ; 
    #5
    kbd_clk = '0 ; 
    #5
    kbd_clk = '1 ; 
    #5
    kbd_clk = '0 ; 
    #5
    kbd_clk = '1 ; 
    #5
    kbd_clk = '0 ; 
    #5
    kbd_clk = '1 ; 
    #5
    kbd_clk = '0 ; 
    #5
    kbd_clk = '1 ; 
    #5
    kbd_clk = '0 ; 
    #5
    kbd_clk = '1 ; 


end



initial clk = 0 ; 
initial kbd_clk = '1 ; 



endmodule
