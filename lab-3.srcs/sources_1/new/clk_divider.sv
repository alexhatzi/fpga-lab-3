`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCF EEL5722C with Dr. Lin
// Engineer: Alexander Hatzilias
// 
// Create Date: 09/01/2024 02:09:29 PM
// Design Name: Basys 3 Keyboard Input Driver 
// Module Name: clk_divider
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




module clk_divider  #(CLK_COUNT = 12500000)
( 
     input clk 
  ,  output logic sample_clk
) ; 


reg [24:0] clkcount ; 

initial clkcount = 0 ; 
initial sample_clk = 0 ; 


always@(posedge clk) begin
    if (clkcount == CLK_COUNT ) begin
      sample_clk = ~sample_clk ; 
        clkcount = '0 ; 
     end else begin
        clkcount = clkcount + 1'b1 ; 
     end
end


endmodule 