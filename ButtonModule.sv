`timescale 1ns / 1ps

module ButtonModule( input wire btnU,
                     input wire btnD,
                     input wire btnL,
                     input wire btnR,
                     input wire gamePadU,
                     input wire gamePadD,
                     input wire gamePadL,
                     input wire gamePadR,
                     output wire up,
                     output wire down,
                     output wire left,
                     output wire right,
                     input logic clk );
                     
                     wire btnLdown, btnRdown, btnUdown, btnDdown;
                     wire gamePadLdown, gamePadRdown, gamePadDdown, gamePadUdown;
                     
                       // Debouncers
                     Debouncer debBL(
                       .clk( clk),
                       .PB( btnL),
                       .PB_down( btnLdown)
                     );
                   
                     Debouncer debBR(
                       .clk( clk),
                       .PB( btnR),
                       .PB_down( btnRdown)
                     );
                   
                     Debouncer debBD(
                       .clk( clk),
                       .PB( btnD),
                       .PB_down( btnDdown)
                     );
                   
                     Debouncer debBU(
                       .clk( clk),
                       .PB( btnU),
                       .PB_down( btnUdown)
                     );
                     
                     Debouncer debGPL(
                        .clk( clk),
                        .PB( gamePadL),
                        .PB_down( gamePadLdown)
                      );
                    
                      Debouncer debGPR(
                        .clk( clk),
                        .PB( gamePadR),
                        .PB_down( gamePadRdown)
                      );
                    
                      Debouncer debGPD(
                        .clk( clk),
                        .PB( gamePadD),
                        .PB_down( gamePadDdown)
                      );
                    
                      Debouncer debGPU(
                        .clk( clk),
                        .PB( gamePadU),
                        .PB_down( gamePadUdown)
                      );
                      
                      assign up = btnUdown | gamePadUdown;
                      assign down = btnDdown | gamePadDdown;
                      assign left = btnLdown | gamePadLdown;
                      assign right = btnRdown | gamePadRdown;
                     
endmodule
