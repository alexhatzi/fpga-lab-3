

module kbd_top (
     input clk
    ,input kbd_clk
    ,input raw_kbd_data
    ,output logic [3:0] anode
    ,output logic [7:0] cathode
    ,output logic [2:0] debugLED
    ,output logic [3:0] bit_loc
    ,output logic kbd_clk_debug
    ,output logic       dvld
    );



//                       ┌────────────────┐         ┌──────────────────┐            ┌──────────────────┐                       
//                       │                │         │                  │            │                  │   ┌──────────────────┐
// Keyboard  ─────────►  │   PS2 Input    │ ──────► │    PS2 Decoder   │ ─────────► │    7 Segment     ├──►│  7 Seg Display   │
//                       │                │         │                  │            │     Decoder      │   │                  │
//                       │                │         │                  │            │                  │   └──────────────────┘
//                       └────────────────┘         └──────────────────┘            └──────────────────┘                    


    logic [7:0] key_buffer  ; 
    logic [1:0] err         ;
    logic [3:0] digit       ;
    logic       display_clk ;

    
    always@(posedge kbd_clk) begin
        kbd_clk_debug <= ~kbd_clk_debug ; 
    end


    ps2input u_ps2input 
    (   .clk          (clk         )   // Logic clk in 
    ,   .kbd_clk      (kbd_clk     )   // Kbd clk in
    ,   .kbd_data     (raw_kbd_data)   // KBD data in (1 bit at a time)
    ,   .key          (key_buffer  )   // Filled buffer (8 bits) out
    ,   .dvld         (dvld        )   // Dvld if parity matches
    ,   .error_detect (err         )   // Error state : 1 if parity does not match, 2 if stop condition not detected
    ,   .state_detect (debugLED    )
    ,   .bit_loc      (bit_loc     )
    ) ; 


    ps2decoder u_ps2decoder            // Translate buffer values to numeral representaiton (binary/decimal)
    (   .clk           (clk       )
    ,   .key           (key_buffer)
    ,   .dvld          (  dvld    )
    ,   .digit         (digit     )
    ) ; 


    seg_decoder u_seg_decoder           // Translate binary/decimal values to 7 segment display signals
    (   .clk           (display_clk )
    ,   .digit         (digit       )
    ,   .cathode       (cathode     )
    ,   .anode         (anode       )
    ) ; 


    clk_divider #(.CLK_COUNT(200000))   // Clk divier for 7 segment display 
    u_display_clk
    (    .clk       (    clk    )
    ,    .sample_clk(display_clk)
    ) ; 



    



endmodule 