

module kbd_top (
     input clk
    ,input kbd_clk
    ,input raw_kbd_data
    ,output logic [3:0] anode
    ,output logic [7:0] cathode
    );



//                       ┌────────────────┐         ┌──────────────────┐            ┌──────────────────┐                       
//                       │                │         │                  │            │                  │   ┌──────────────────┐
// Keyboard  ─────────►  │   PS2 Input    │ ──────► │    PS2 Decoder   │ ─────────► │    7 Segment     ├──►│  7 Seg Display   │
//                       │                │         │                  │            │     Decoder      │   │                  │
//                       │                │         │                  │            │                  │   └──────────────────┘
//                       └────────────────┘         └──────────────────┘            └──────────────────┘                    


    logic [7:0] key_buffer  ; 
//    logic       dvld        ;
    logic [1:0] err         ;
    logic [3:0] digit       ;
    logic       display_clk ;    

    ps2input u_ps2input 
    (   .clk          (clk         )   // Logic clk in 
    ,   .kbd_clk      (kbd_clk     )   // Kbd clk in
    ,   .kbd_data     (raw_kbd_data)   // KBD data in (1 bit at a time)
    ,   .key          (key_buffer  )   // Filled buffer (8 bits) out
   // ,   .dvld         (dvld        )   // Dvld if parity matches
   // ,   .error_detect (err         )   // Error state : 1 if parity does not match, 2 if stop condition not detected
    ) ; 

    ps2decoder u_ps2decoder            // Translate buffer values to numeral representaiton (binary/decimal)
    (   .clk           (clk       )
    ,   .key           (key_buffer)
  //  ,   .dvld          (dvld      )
  //  ,   .error_detect  (err       )
    ,   .digit         (digit     )
    ) ; 


    seg_decoder u_seg_decoder           // Translate binary/decimal values to 7 segment display signals
    (   .clk           (clk       )
    ,   .digit         (digit     )
    ,   .cathode       (cathode      )
    ) ; 


    clk_divider #(.CLK_COUNT(200000))   // Clk divier for 7 segment display 
    u_display_clk
    (    .clk       (    clk    )
    ,    .sample_clk(display_clk)
    ) ; 


   assign anode = 4'b1110 ; // Only and always using the single (rightmost) digit on 7 segment display

    



endmodule 