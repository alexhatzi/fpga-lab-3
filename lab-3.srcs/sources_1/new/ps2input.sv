//////////////////////////////////////////////////////////////////////////////////
// Company: UCF EEL5722C with Dr. Lin
// Engineer: Alexander Hatzilias
// 
// Create Date: 09/01/2024 02:09:29 PM
// Design Name: Basys 3 Keyboard Input Driver 
// Module Name: ps2input
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


module ps2input( 
     input clk   
    ,input kbd_clk
    ,input kbd_data
    ,output logic [7:0] key // 8 bit keyboard input (partiy bit stripped)
    ,output logic dvld      // If parity bit matches, dvld is high
    ,output logic [1:0] error_detect
    );

    logic [8:0] kbd_buffer ; 
    logic       kbd_clk_d  ;
    logic [3:0] bit_loc    ;       // Used to index through key data buffer

    typedef enum  {IDLE,ACTIVE,STOP} kbd_state_t ;   
    kbd_state_t KBD_STATE ;




    always@(negedge clk) begin
        kbd_clk_d <= kbd_clk ; 
     case(KBD_STATE)

        IDLE :  begin
                bit_loc       <= '0   ; 
                error_detect  <= '0   ; 
                key           <= '0   ; 
                if(kbd_data == '0) begin
                 if(kbd_clk_d & (~kbd_clk)) begin // negedge of kbd_clk
                     KBD_STATE <= ACTIVE ; 
                 end
                end
                end

      ACTIVE :  begin
                if(kbd_clk_d & (~kbd_clk)) begin // Negative edge of kbd_clk
                 if ( (bit_loc == 4'd9) && (kbd_data == '1)) begin  // 10th negedge after start is the stop conidition
                     KBD_STATE  <= STOP ; 
                 end
                 else if (bit_loc == 4'd9) begin // Major error, buffer filled without stop condition (10th negedge of clk but data is still high)
                    error_detect <= 2'd2 ; 
                 end
                 else begin
                 kbd_buffer [bit_loc] = kbd_data ; 
                 bit_loc       = bit_loc + 1'b1  ; 
                 end
                end
                end

        STOP :  begin
                bit_loc <= '0 ; 
                if ( (^(kbd_buffer[7:0]))  == kbd_buffer[8]  ) begin // If parity matches
                    dvld         <= 1'b1 ; 
                    error_detect <= 1'b0 ; 
                end else begin
                    dvld         <= 1'b0 ; 
                    error_detect <= 1'b1 ; 
                end
                key [7:0]   = kbd_buffer[7:0] ; // Send buffer out
                kbd_buffer  = '0              ; // Clear buffer
                KBD_STATE   = IDLE            ; // Wait for new input
                end

      default : begin
                dvld          = '0   ;  
                error_detect  = '0   ; 
                key           = '0   ; 
                KBD_STATE     = IDLE ; 
                end

        endcase
    end

endmodule
