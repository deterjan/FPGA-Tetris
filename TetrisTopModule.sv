`timescale 1ns / 1ps
// Connect arduino pins 11, 12, 13 to basys JA 2, 3, 4
// JC 2 3 4 !7! up down left right
module TetrisTopModule(
  input wire clk,			//master clock = 100MHz
  input wire clr,			//center pushbutton for reset
  output wire [6:0] seg,	//7-segment display LEDs
  output wire [3:0] an,	//7-segment display anode enable
  output wire dp,			//7-segment display decimal point
  output wire [3:0] red,	//red vga output - 3 bits
  output wire [3:0] green,//green vga output - 3 bits
  output wire [3:0] blue,	//blue vga output - 2 bits
  output wire hsync,		//horizontal sync out
  output wire vsync,		//vertical sync out

  // buttons and switches
  input wire btnU,	
  input wire btnD,
  input wire btnL,
  input wire btnR,
  
  input wire gamePadU,	
  input wire gamePadD,
  input wire gamePadL,
  input wire gamePadR,
  
  input wire stop,
  input wire [2:0] SwitchSelect,
  input wire [2:0] RandomIn,
  
  output reg speaker,
  output reg speaker2
);


  wire dclk;                            // VGA display clock interconnect
  wire logicclk;                        // Game logic clock interconnect
  wire up, down, left, right;

  // Game data interconnect wires
  logic [11:0] grid [23:0];
  wire [9:0] posX1;
  wire [9:0] posY1;
  wire [9:0] posX2;
  wire [9:0] posY2;
  wire [9:0] posX3;
  wire [9:0] posY3;
  wire [9:0] posX4;
  wire [9:0] posY4;
  
  wire [7:0] score;
  wire gameOver;
    
  // use clk wizard ip, out1 30 mhz, out2 25.175mhz
  clk_wiz_0 wiz
  (
    .clk_in1(clk), 
    .clk_out1(logicclk),
    .clk_out2(dclk),       
    .reset(clr)      
  );
  
  ButtonModule buttons( btnU, btnD, btnL, btnR, gamePadU, gamePadD, gamePadL, gamePadR, up, down, left, right, logicclk);

  GameLogicV2 gl(
    .clk(logicclk),
    .reset(clr),
    .outGrid(grid),
    .x1(posX1),
    .y1(posY1),
    .x2(posX2),
    .y2(posY2),
    .x3(posX3),
    .y3(posY3),
    .x4(posX4),
    .y4(posY4),
    .right(right),
    .left(left),
    .down(down),
    .up(up),
    .stop(stop),
    .nextBlockRand( RandomIn),
    .nextBlockSwitch( SwitchSelect),
    .gameOver( gameOver),
    .score( score)
  );

  // VGA controller
  GameDisplay display(
    .dclk(dclk),
    .clr(clr),
    .hsync(hsync),
    .vsync(vsync),
    .red(red),
    .green(green),
    .blue(blue),
    .inputGrid(grid),
    .posX1(posX1),
    .posY1(posY1),
    .posX2(posX2),
    .posY2(posY2),
    .posX3(posX3),
    .posY3(posY3),
    .posX4(posX4),
    .posY4(posY4),
    .gameOver( gameOver) 
  );
  
  TetrisTheme music(
      .clk( clk),
      .reset( clr),
      .speaker( speaker),
      .speaker2( speaker2)
  );
  
  ScoreDisplay scoressd( .score( score), .clk(logicclk), .reset(clr), .an(an), .seg(seg), .dp(dp));

endmodule
