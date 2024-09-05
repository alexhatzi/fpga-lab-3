//////////////////////////////////////////////////////////////////////////////////
// Company: UCF EEL5722C with Dr. Lin
// Engineer: Alexander Hatzilias
// 
// Create Date: 09/01/2024 02:09:29 PM
// Design Name: Basys 3 Keyboard Input Driver 
// Module Name: seg_decoder
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





module seg_decoder(
    input clk 
    ,input  [3:0] digit
    ,output logic [7:0] cathode
    ,output logic [3:0] anode
    );


    assign  anode = 4'b1110 ;

  // Convert binary to decimal 7 segment display 
  always @ (posedge clk) begin
    case(digit)
         4'd0   : cathode = 8'b00000011;
         4'd1   : cathode = 8'b10011111; 
         4'd2   : cathode = 8'b00100101;
         4'd3   : cathode = 8'b00001101; 
         4'd4   : cathode = 8'b10011001; 
         4'd5   : cathode = 8'b01001001;
         4'd6   : cathode = 8'b11000001; 
         4'd7   : cathode = 8'b00011111;
         4'd8   : cathode = 8'b00000001;     
         4'd9   : cathode = 8'b00011001;
         4'd10  : cathode = 8'b01100001; // Error (display's E)
        default : cathode = 8'b00000000; // Turn on everything 
    endcase
   end
endmodule

