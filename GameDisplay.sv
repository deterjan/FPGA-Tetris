`timescale 1ns / 1ps

module GameDisplay(
  input wire dclk,		//pixel clock: 25MHz
  input wire clr,			//asynchronous reset
  output wire hsync,		//horizontal sync out
  output wire vsync,		//vertical sync out
  output reg [3:0] red,	//red vga output
  output reg [3:0] green, //green vga output
  output reg [3:0] blue,	//blue vga output

  input logic [11:0] inputGrid [23:0],
  input wire [9:0] posX1,
  input wire [9:0] posY1,
  input wire [9:0] posX2,
  input wire [9:0] posY2,
  input wire [9:0] posX3,
  input wire [9:0] posY3,
  input wire [9:0] posX4,
  input wire [9:0] posY4,
  input wire gameOver
);

  // video structure constants
  parameter hpixels = 800;// horizontal pixels per line
  parameter vlines = 521; // vertical lines per frame
  parameter hpulse = 96; 	// hsync pulse length
  parameter vpulse = 2; 	// vsync pulse length
  parameter hbp = 144; 	// end of horizontal back porch
  parameter hfp = 784; 	// beginning of horizontal front porch
  parameter vbp = 31; 	// end of vertical back porch
  parameter vfp = 511; 	// beginning of vertical front porch
  // active horizontal video is therefore: 784 - 144 = 640
  // active vertical video is therefore: 511 - 31 = 480

  // registers for storing the horizontal & vertical counters
  reg [9:0] hc;
  reg [9:0] vc;

  logic [11:0] grid [23:0];
  logic [11:0] overGrid [23:0];
  
  always @(posedge dclk or posedge clr)
  begin
    // reset condition
    if (clr == 1) begin
        for ( integer i = 0; i < 24; i = i + 1)
          for ( integer j = 0; j < 12; j = j + 1)
            overGrid[i][j] = 1;
        
        overGrid[6][4] = 0;
        overGrid[7][4] = 0;
        overGrid[8][4] = 0;
        overGrid[9][4] = 0;
        
        overGrid[6][7] = 0;
        overGrid[7][7] = 0;
        overGrid[8][7] = 0;
        overGrid[9][7] = 0;
        
        overGrid[14][2] = 0;
        overGrid[15][2] = 0;
        
        overGrid[14][9] = 0;
        overGrid[15][9] = 0;
        
        overGrid[13][3] = 0;
        overGrid[13][8] = 0;
        
        overGrid[12][4] = 0;
        overGrid[12][5] = 0;
        overGrid[12][6] = 0;
        overGrid[12][7] = 0;

        grid <= inputGrid;
      end else begin
        if ( gameOver)
            grid <= overGrid;
        else
            grid <= inputGrid;
      end
  end

  always @(posedge dclk or posedge clr)
    begin
      // reset condition
      if (clr == 1)
        begin
          hc <= 0;
          vc <= 0;
        end
      else begin
        if (hc < hpixels - 1)
          hc <= hc + 1;
        else begin
          hc <= 0;
          if (vc < vlines - 1)
            vc <= vc + 1;
          else begin
            vc <= 0;
          end
        end
      end
    end

  assign hsync = (hc < hpulse) ? 0:1;
  assign vsync = (vc < vpulse) ? 0:1;

  always @(*) begin
    // first check if we're within vertical active video range
    if (vc >= vbp + 5 && vc < 292) begin // vbp + 5 and vfp - 20 becuase display glitch
      // GENERATED CODE BEGINS HERE

      if (vc > 60 &&  vc <= 70) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 2 && posX1 == 1) || ( posY2 == 2 && posX2 == 1) || ( posY3 == 2 && posX3 == 1) || ( posY4 == 2 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[2][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 2 && posX1 == 2) || ( posY2 == 2 && posX2 == 2) || ( posY3 == 2 && posX3 == 2) || ( posY4 == 2 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[2][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 2 && posX1 == 3) || ( posY2 == 2 && posX2 == 3) || ( posY3 == 2 && posX3 == 3) || ( posY4 == 2 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[2][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 2 && posX1 == 4) || ( posY2 == 2 && posX2 == 4) || ( posY3 == 2 && posX3 == 4) || ( posY4 == 2 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[2][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 2 && posX1 == 5) || ( posY2 == 2 && posX2 == 5) || ( posY3 == 2 && posX3 == 5) || ( posY4 == 2 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[2][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 2 && posX1 == 6) || ( posY2 == 2 && posX2 == 6) || ( posY3 == 2 && posX3 == 6) || ( posY4 == 2 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[2][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 2 && posX1 == 7) || ( posY2 == 2 && posX2 == 7) || ( posY3 == 2 && posX3 == 7) || ( posY4 == 2 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[2][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 2 && posX1 == 8) || ( posY2 == 2 && posX2 == 8) || ( posY3 == 2 && posX3 == 8) || ( posY4 == 2 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[2][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 2 && posX1 == 9) || ( posY2 == 2 && posX2 == 9) || ( posY3 == 2 && posX3 == 9) || ( posY4 == 2 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[2][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 2 && posX1 == 10) || ( posY2 == 2 && posX2 == 10) || ( posY3 == 2 && posX3 == 10) || ( posY4 == 2 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[2][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 71 &&  vc <= 81) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 3 && posX1 == 1) || ( posY2 == 3 && posX2 == 1) || ( posY3 == 3 && posX3 == 1) || ( posY4 == 3 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[3][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 3 && posX1 == 2) || ( posY2 == 3 && posX2 == 2) || ( posY3 == 3 && posX3 == 2) || ( posY4 == 3 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[3][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 3 && posX1 == 3) || ( posY2 == 3 && posX2 == 3) || ( posY3 == 3 && posX3 == 3) || ( posY4 == 3 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[3][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 3 && posX1 == 4) || ( posY2 == 3 && posX2 == 4) || ( posY3 == 3 && posX3 == 4) || ( posY4 == 3 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[3][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 3 && posX1 == 5) || ( posY2 == 3 && posX2 == 5) || ( posY3 == 3 && posX3 == 5) || ( posY4 == 3 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[3][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 3 && posX1 == 6) || ( posY2 == 3 && posX2 == 6) || ( posY3 == 3 && posX3 == 6) || ( posY4 == 3 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[3][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 3 && posX1 == 7) || ( posY2 == 3 && posX2 == 7) || ( posY3 == 3 && posX3 == 7) || ( posY4 == 3 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[3][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 3 && posX1 == 8) || ( posY2 == 3 && posX2 == 8) || ( posY3 == 3 && posX3 == 8) || ( posY4 == 3 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[3][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 3 && posX1 == 9) || ( posY2 == 3 && posX2 == 9) || ( posY3 == 3 && posX3 == 9) || ( posY4 == 3 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[3][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 3 && posX1 == 10) || ( posY2 == 3 && posX2 == 10) || ( posY3 == 3 && posX3 == 10) || ( posY4 == 3 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[3][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 82 &&  vc <= 92) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 4 && posX1 == 1) || ( posY2 == 4 && posX2 == 1) || ( posY3 == 4 && posX3 == 1) || ( posY4 == 4 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[4][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 4 && posX1 == 2) || ( posY2 == 4 && posX2 == 2) || ( posY3 == 4 && posX3 == 2) || ( posY4 == 4 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[4][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 4 && posX1 == 3) || ( posY2 == 4 && posX2 == 3) || ( posY3 == 4 && posX3 == 3) || ( posY4 == 4 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[4][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 4 && posX1 == 4) || ( posY2 == 4 && posX2 == 4) || ( posY3 == 4 && posX3 == 4) || ( posY4 == 4 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[4][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 4 && posX1 == 5) || ( posY2 == 4 && posX2 == 5) || ( posY3 == 4 && posX3 == 5) || ( posY4 == 4 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[4][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 4 && posX1 == 6) || ( posY2 == 4 && posX2 == 6) || ( posY3 == 4 && posX3 == 6) || ( posY4 == 4 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[4][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 4 && posX1 == 7) || ( posY2 == 4 && posX2 == 7) || ( posY3 == 4 && posX3 == 7) || ( posY4 == 4 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[4][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 4 && posX1 == 8) || ( posY2 == 4 && posX2 == 8) || ( posY3 == 4 && posX3 == 8) || ( posY4 == 4 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[4][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 4 && posX1 == 9) || ( posY2 == 4 && posX2 == 9) || ( posY3 == 4 && posX3 == 9) || ( posY4 == 4 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[4][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 4 && posX1 == 10) || ( posY2 == 4 && posX2 == 10) || ( posY3 == 4 && posX3 == 10) || ( posY4 == 4 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[4][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 93 &&  vc <= 103) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 5 && posX1 == 1) || ( posY2 == 5 && posX2 == 1) || ( posY3 == 5 && posX3 == 1) || ( posY4 == 5 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[5][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 5 && posX1 == 2) || ( posY2 == 5 && posX2 == 2) || ( posY3 == 5 && posX3 == 2) || ( posY4 == 5 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[5][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 5 && posX1 == 3) || ( posY2 == 5 && posX2 == 3) || ( posY3 == 5 && posX3 == 3) || ( posY4 == 5 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[5][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 5 && posX1 == 4) || ( posY2 == 5 && posX2 == 4) || ( posY3 == 5 && posX3 == 4) || ( posY4 == 5 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[5][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 5 && posX1 == 5) || ( posY2 == 5 && posX2 == 5) || ( posY3 == 5 && posX3 == 5) || ( posY4 == 5 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[5][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 5 && posX1 == 6) || ( posY2 == 5 && posX2 == 6) || ( posY3 == 5 && posX3 == 6) || ( posY4 == 5 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[5][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 5 && posX1 == 7) || ( posY2 == 5 && posX2 == 7) || ( posY3 == 5 && posX3 == 7) || ( posY4 == 5 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[5][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 5 && posX1 == 8) || ( posY2 == 5 && posX2 == 8) || ( posY3 == 5 && posX3 == 8) || ( posY4 == 5 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[5][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 5 && posX1 == 9) || ( posY2 == 5 && posX2 == 9) || ( posY3 == 5 && posX3 == 9) || ( posY4 == 5 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[5][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 5 && posX1 == 10) || ( posY2 == 5 && posX2 == 10) || ( posY3 == 5 && posX3 == 10) || ( posY4 == 5 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[5][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 104 &&  vc <= 114) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 6 && posX1 == 1) || ( posY2 == 6 && posX2 == 1) || ( posY3 == 6 && posX3 == 1) || ( posY4 == 6 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[6][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 6 && posX1 == 2) || ( posY2 == 6 && posX2 == 2) || ( posY3 == 6 && posX3 == 2) || ( posY4 == 6 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[6][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 6 && posX1 == 3) || ( posY2 == 6 && posX2 == 3) || ( posY3 == 6 && posX3 == 3) || ( posY4 == 6 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[6][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 6 && posX1 == 4) || ( posY2 == 6 && posX2 == 4) || ( posY3 == 6 && posX3 == 4) || ( posY4 == 6 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[6][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 6 && posX1 == 5) || ( posY2 == 6 && posX2 == 5) || ( posY3 == 6 && posX3 == 5) || ( posY4 == 6 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[6][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 6 && posX1 == 6) || ( posY2 == 6 && posX2 == 6) || ( posY3 == 6 && posX3 == 6) || ( posY4 == 6 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[6][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 6 && posX1 == 7) || ( posY2 == 6 && posX2 == 7) || ( posY3 == 6 && posX3 == 7) || ( posY4 == 6 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[6][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 6 && posX1 == 8) || ( posY2 == 6 && posX2 == 8) || ( posY3 == 6 && posX3 == 8) || ( posY4 == 6 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[6][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 6 && posX1 == 9) || ( posY2 == 6 && posX2 == 9) || ( posY3 == 6 && posX3 == 9) || ( posY4 == 6 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[6][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 6 && posX1 == 10) || ( posY2 == 6 && posX2 == 10) || ( posY3 == 6 && posX3 == 10) || ( posY4 == 6 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[6][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 115 &&  vc <= 125) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 7 && posX1 == 1) || ( posY2 == 7 && posX2 == 1) || ( posY3 == 7 && posX3 == 1) || ( posY4 == 7 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[7][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 7 && posX1 == 2) || ( posY2 == 7 && posX2 == 2) || ( posY3 == 7 && posX3 == 2) || ( posY4 == 7 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[7][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 7 && posX1 == 3) || ( posY2 == 7 && posX2 == 3) || ( posY3 == 7 && posX3 == 3) || ( posY4 == 7 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[7][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 7 && posX1 == 4) || ( posY2 == 7 && posX2 == 4) || ( posY3 == 7 && posX3 == 4) || ( posY4 == 7 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[7][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 7 && posX1 == 5) || ( posY2 == 7 && posX2 == 5) || ( posY3 == 7 && posX3 == 5) || ( posY4 == 7 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[7][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 7 && posX1 == 6) || ( posY2 == 7 && posX2 == 6) || ( posY3 == 7 && posX3 == 6) || ( posY4 == 7 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[7][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 7 && posX1 == 7) || ( posY2 == 7 && posX2 == 7) || ( posY3 == 7 && posX3 == 7) || ( posY4 == 7 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[7][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 7 && posX1 == 8) || ( posY2 == 7 && posX2 == 8) || ( posY3 == 7 && posX3 == 8) || ( posY4 == 7 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[7][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 7 && posX1 == 9) || ( posY2 == 7 && posX2 == 9) || ( posY3 == 7 && posX3 == 9) || ( posY4 == 7 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[7][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 7 && posX1 == 10) || ( posY2 == 7 && posX2 == 10) || ( posY3 == 7 && posX3 == 10) || ( posY4 == 7 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[7][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 126 &&  vc <= 136) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 8 && posX1 == 1) || ( posY2 == 8 && posX2 == 1) || ( posY3 == 8 && posX3 == 1) || ( posY4 == 8 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[8][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 8 && posX1 == 2) || ( posY2 == 8 && posX2 == 2) || ( posY3 == 8 && posX3 == 2) || ( posY4 == 8 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[8][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 8 && posX1 == 3) || ( posY2 == 8 && posX2 == 3) || ( posY3 == 8 && posX3 == 3) || ( posY4 == 8 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[8][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 8 && posX1 == 4) || ( posY2 == 8 && posX2 == 4) || ( posY3 == 8 && posX3 == 4) || ( posY4 == 8 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[8][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 8 && posX1 == 5) || ( posY2 == 8 && posX2 == 5) || ( posY3 == 8 && posX3 == 5) || ( posY4 == 8 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[8][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 8 && posX1 == 6) || ( posY2 == 8 && posX2 == 6) || ( posY3 == 8 && posX3 == 6) || ( posY4 == 8 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[8][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 8 && posX1 == 7) || ( posY2 == 8 && posX2 == 7) || ( posY3 == 8 && posX3 == 7) || ( posY4 == 8 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[8][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 8 && posX1 == 8) || ( posY2 == 8 && posX2 == 8) || ( posY3 == 8 && posX3 == 8) || ( posY4 == 8 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[8][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 8 && posX1 == 9) || ( posY2 == 8 && posX2 == 9) || ( posY3 == 8 && posX3 == 9) || ( posY4 == 8 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[8][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 8 && posX1 == 10) || ( posY2 == 8 && posX2 == 10) || ( posY3 == 8 && posX3 == 10) || ( posY4 == 8 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[8][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 137 &&  vc <= 147) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 9 && posX1 == 1) || ( posY2 == 9 && posX2 == 1) || ( posY3 == 9 && posX3 == 1) || ( posY4 == 9 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[9][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 9 && posX1 == 2) || ( posY2 == 9 && posX2 == 2) || ( posY3 == 9 && posX3 == 2) || ( posY4 == 9 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[9][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 9 && posX1 == 3) || ( posY2 == 9 && posX2 == 3) || ( posY3 == 9 && posX3 == 3) || ( posY4 == 9 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[9][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 9 && posX1 == 4) || ( posY2 == 9 && posX2 == 4) || ( posY3 == 9 && posX3 == 4) || ( posY4 == 9 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[9][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 9 && posX1 == 5) || ( posY2 == 9 && posX2 == 5) || ( posY3 == 9 && posX3 == 5) || ( posY4 == 9 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[9][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 9 && posX1 == 6) || ( posY2 == 9 && posX2 == 6) || ( posY3 == 9 && posX3 == 6) || ( posY4 == 9 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[9][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 9 && posX1 == 7) || ( posY2 == 9 && posX2 == 7) || ( posY3 == 9 && posX3 == 7) || ( posY4 == 9 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[9][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 9 && posX1 == 8) || ( posY2 == 9 && posX2 == 8) || ( posY3 == 9 && posX3 == 8) || ( posY4 == 9 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[9][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 9 && posX1 == 9) || ( posY2 == 9 && posX2 == 9) || ( posY3 == 9 && posX3 == 9) || ( posY4 == 9 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[9][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 9 && posX1 == 10) || ( posY2 == 9 && posX2 == 10) || ( posY3 == 9 && posX3 == 10) || ( posY4 == 9 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[9][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 148 &&  vc <= 158) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 10 && posX1 == 1) || ( posY2 == 10 && posX2 == 1) || ( posY3 == 10 && posX3 == 1) || ( posY4 == 10 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[10][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 10 && posX1 == 2) || ( posY2 == 10 && posX2 == 2) || ( posY3 == 10 && posX3 == 2) || ( posY4 == 10 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[10][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 10 && posX1 == 3) || ( posY2 == 10 && posX2 == 3) || ( posY3 == 10 && posX3 == 3) || ( posY4 == 10 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[10][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 10 && posX1 == 4) || ( posY2 == 10 && posX2 == 4) || ( posY3 == 10 && posX3 == 4) || ( posY4 == 10 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[10][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 10 && posX1 == 5) || ( posY2 == 10 && posX2 == 5) || ( posY3 == 10 && posX3 == 5) || ( posY4 == 10 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[10][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 10 && posX1 == 6) || ( posY2 == 10 && posX2 == 6) || ( posY3 == 10 && posX3 == 6) || ( posY4 == 10 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[10][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 10 && posX1 == 7) || ( posY2 == 10 && posX2 == 7) || ( posY3 == 10 && posX3 == 7) || ( posY4 == 10 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[10][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 10 && posX1 == 8) || ( posY2 == 10 && posX2 == 8) || ( posY3 == 10 && posX3 == 8) || ( posY4 == 10 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[10][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 10 && posX1 == 9) || ( posY2 == 10 && posX2 == 9) || ( posY3 == 10 && posX3 == 9) || ( posY4 == 10 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[10][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 10 && posX1 == 10) || ( posY2 == 10 && posX2 == 10) || ( posY3 == 10 && posX3 == 10) || ( posY4 == 10 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[10][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 159 &&  vc <= 169) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 11 && posX1 == 1) || ( posY2 == 11 && posX2 == 1) || ( posY3 == 11 && posX3 == 1) || ( posY4 == 11 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[11][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 11 && posX1 == 2) || ( posY2 == 11 && posX2 == 2) || ( posY3 == 11 && posX3 == 2) || ( posY4 == 11 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[11][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 11 && posX1 == 3) || ( posY2 == 11 && posX2 == 3) || ( posY3 == 11 && posX3 == 3) || ( posY4 == 11 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[11][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 11 && posX1 == 4) || ( posY2 == 11 && posX2 == 4) || ( posY3 == 11 && posX3 == 4) || ( posY4 == 11 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[11][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 11 && posX1 == 5) || ( posY2 == 11 && posX2 == 5) || ( posY3 == 11 && posX3 == 5) || ( posY4 == 11 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[11][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 11 && posX1 == 6) || ( posY2 == 11 && posX2 == 6) || ( posY3 == 11 && posX3 == 6) || ( posY4 == 11 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[11][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 11 && posX1 == 7) || ( posY2 == 11 && posX2 == 7) || ( posY3 == 11 && posX3 == 7) || ( posY4 == 11 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[11][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 11 && posX1 == 8) || ( posY2 == 11 && posX2 == 8) || ( posY3 == 11 && posX3 == 8) || ( posY4 == 11 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[11][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 11 && posX1 == 9) || ( posY2 == 11 && posX2 == 9) || ( posY3 == 11 && posX3 == 9) || ( posY4 == 11 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[11][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 11 && posX1 == 10) || ( posY2 == 11 && posX2 == 10) || ( posY3 == 11 && posX3 == 10) || ( posY4 == 11 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[11][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 170 &&  vc <= 180) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 12 && posX1 == 1) || ( posY2 == 12 && posX2 == 1) || ( posY3 == 12 && posX3 == 1) || ( posY4 == 12 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[12][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 12 && posX1 == 2) || ( posY2 == 12 && posX2 == 2) || ( posY3 == 12 && posX3 == 2) || ( posY4 == 12 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[12][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 12 && posX1 == 3) || ( posY2 == 12 && posX2 == 3) || ( posY3 == 12 && posX3 == 3) || ( posY4 == 12 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[12][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 12 && posX1 == 4) || ( posY2 == 12 && posX2 == 4) || ( posY3 == 12 && posX3 == 4) || ( posY4 == 12 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[12][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 12 && posX1 == 5) || ( posY2 == 12 && posX2 == 5) || ( posY3 == 12 && posX3 == 5) || ( posY4 == 12 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[12][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 12 && posX1 == 6) || ( posY2 == 12 && posX2 == 6) || ( posY3 == 12 && posX3 == 6) || ( posY4 == 12 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[12][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 12 && posX1 == 7) || ( posY2 == 12 && posX2 == 7) || ( posY3 == 12 && posX3 == 7) || ( posY4 == 12 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[12][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 12 && posX1 == 8) || ( posY2 == 12 && posX2 == 8) || ( posY3 == 12 && posX3 == 8) || ( posY4 == 12 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[12][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 12 && posX1 == 9) || ( posY2 == 12 && posX2 == 9) || ( posY3 == 12 && posX3 == 9) || ( posY4 == 12 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[12][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 12 && posX1 == 10) || ( posY2 == 12 && posX2 == 10) || ( posY3 == 12 && posX3 == 10) || ( posY4 == 12 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[12][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 181 &&  vc <= 191) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 13 && posX1 == 1) || ( posY2 == 13 && posX2 == 1) || ( posY3 == 13 && posX3 == 1) || ( posY4 == 13 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[13][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 13 && posX1 == 2) || ( posY2 == 13 && posX2 == 2) || ( posY3 == 13 && posX3 == 2) || ( posY4 == 13 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[13][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 13 && posX1 == 3) || ( posY2 == 13 && posX2 == 3) || ( posY3 == 13 && posX3 == 3) || ( posY4 == 13 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[13][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 13 && posX1 == 4) || ( posY2 == 13 && posX2 == 4) || ( posY3 == 13 && posX3 == 4) || ( posY4 == 13 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[13][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 13 && posX1 == 5) || ( posY2 == 13 && posX2 == 5) || ( posY3 == 13 && posX3 == 5) || ( posY4 == 13 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[13][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 13 && posX1 == 6) || ( posY2 == 13 && posX2 == 6) || ( posY3 == 13 && posX3 == 6) || ( posY4 == 13 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[13][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 13 && posX1 == 7) || ( posY2 == 13 && posX2 == 7) || ( posY3 == 13 && posX3 == 7) || ( posY4 == 13 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[13][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 13 && posX1 == 8) || ( posY2 == 13 && posX2 == 8) || ( posY3 == 13 && posX3 == 8) || ( posY4 == 13 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[13][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 13 && posX1 == 9) || ( posY2 == 13 && posX2 == 9) || ( posY3 == 13 && posX3 == 9) || ( posY4 == 13 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[13][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 13 && posX1 == 10) || ( posY2 == 13 && posX2 == 10) || ( posY3 == 13 && posX3 == 10) || ( posY4 == 13 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[13][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 192 &&  vc <= 202) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 14 && posX1 == 1) || ( posY2 == 14 && posX2 == 1) || ( posY3 == 14 && posX3 == 1) || ( posY4 == 14 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[14][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 14 && posX1 == 2) || ( posY2 == 14 && posX2 == 2) || ( posY3 == 14 && posX3 == 2) || ( posY4 == 14 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[14][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 14 && posX1 == 3) || ( posY2 == 14 && posX2 == 3) || ( posY3 == 14 && posX3 == 3) || ( posY4 == 14 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[14][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 14 && posX1 == 4) || ( posY2 == 14 && posX2 == 4) || ( posY3 == 14 && posX3 == 4) || ( posY4 == 14 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[14][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 14 && posX1 == 5) || ( posY2 == 14 && posX2 == 5) || ( posY3 == 14 && posX3 == 5) || ( posY4 == 14 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[14][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 14 && posX1 == 6) || ( posY2 == 14 && posX2 == 6) || ( posY3 == 14 && posX3 == 6) || ( posY4 == 14 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[14][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 14 && posX1 == 7) || ( posY2 == 14 && posX2 == 7) || ( posY3 == 14 && posX3 == 7) || ( posY4 == 14 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[14][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 14 && posX1 == 8) || ( posY2 == 14 && posX2 == 8) || ( posY3 == 14 && posX3 == 8) || ( posY4 == 14 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[14][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 14 && posX1 == 9) || ( posY2 == 14 && posX2 == 9) || ( posY3 == 14 && posX3 == 9) || ( posY4 == 14 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[14][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 14 && posX1 == 10) || ( posY2 == 14 && posX2 == 10) || ( posY3 == 14 && posX3 == 10) || ( posY4 == 14 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[14][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 203 &&  vc <= 213) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 15 && posX1 == 1) || ( posY2 == 15 && posX2 == 1) || ( posY3 == 15 && posX3 == 1) || ( posY4 == 15 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[15][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 15 && posX1 == 2) || ( posY2 == 15 && posX2 == 2) || ( posY3 == 15 && posX3 == 2) || ( posY4 == 15 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[15][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 15 && posX1 == 3) || ( posY2 == 15 && posX2 == 3) || ( posY3 == 15 && posX3 == 3) || ( posY4 == 15 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[15][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 15 && posX1 == 4) || ( posY2 == 15 && posX2 == 4) || ( posY3 == 15 && posX3 == 4) || ( posY4 == 15 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[15][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 15 && posX1 == 5) || ( posY2 == 15 && posX2 == 5) || ( posY3 == 15 && posX3 == 5) || ( posY4 == 15 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[15][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 15 && posX1 == 6) || ( posY2 == 15 && posX2 == 6) || ( posY3 == 15 && posX3 == 6) || ( posY4 == 15 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[15][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 15 && posX1 == 7) || ( posY2 == 15 && posX2 == 7) || ( posY3 == 15 && posX3 == 7) || ( posY4 == 15 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[15][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 15 && posX1 == 8) || ( posY2 == 15 && posX2 == 8) || ( posY3 == 15 && posX3 == 8) || ( posY4 == 15 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[15][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 15 && posX1 == 9) || ( posY2 == 15 && posX2 == 9) || ( posY3 == 15 && posX3 == 9) || ( posY4 == 15 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[15][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 15 && posX1 == 10) || ( posY2 == 15 && posX2 == 10) || ( posY3 == 15 && posX3 == 10) || ( posY4 == 15 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[15][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 214 &&  vc <= 224) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 16 && posX1 == 1) || ( posY2 == 16 && posX2 == 1) || ( posY3 == 16 && posX3 == 1) || ( posY4 == 16 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[16][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 16 && posX1 == 2) || ( posY2 == 16 && posX2 == 2) || ( posY3 == 16 && posX3 == 2) || ( posY4 == 16 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[16][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 16 && posX1 == 3) || ( posY2 == 16 && posX2 == 3) || ( posY3 == 16 && posX3 == 3) || ( posY4 == 16 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[16][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 16 && posX1 == 4) || ( posY2 == 16 && posX2 == 4) || ( posY3 == 16 && posX3 == 4) || ( posY4 == 16 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[16][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 16 && posX1 == 5) || ( posY2 == 16 && posX2 == 5) || ( posY3 == 16 && posX3 == 5) || ( posY4 == 16 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[16][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 16 && posX1 == 6) || ( posY2 == 16 && posX2 == 6) || ( posY3 == 16 && posX3 == 6) || ( posY4 == 16 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[16][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 16 && posX1 == 7) || ( posY2 == 16 && posX2 == 7) || ( posY3 == 16 && posX3 == 7) || ( posY4 == 16 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[16][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 16 && posX1 == 8) || ( posY2 == 16 && posX2 == 8) || ( posY3 == 16 && posX3 == 8) || ( posY4 == 16 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[16][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 16 && posX1 == 9) || ( posY2 == 16 && posX2 == 9) || ( posY3 == 16 && posX3 == 9) || ( posY4 == 16 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[16][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 16 && posX1 == 10) || ( posY2 == 16 && posX2 == 10) || ( posY3 == 16 && posX3 == 10) || ( posY4 == 16 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[16][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 225 &&  vc <= 235) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 17 && posX1 == 1) || ( posY2 == 17 && posX2 == 1) || ( posY3 == 17 && posX3 == 1) || ( posY4 == 17 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[17][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 17 && posX1 == 2) || ( posY2 == 17 && posX2 == 2) || ( posY3 == 17 && posX3 == 2) || ( posY4 == 17 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[17][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 17 && posX1 == 3) || ( posY2 == 17 && posX2 == 3) || ( posY3 == 17 && posX3 == 3) || ( posY4 == 17 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[17][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 17 && posX1 == 4) || ( posY2 == 17 && posX2 == 4) || ( posY3 == 17 && posX3 == 4) || ( posY4 == 17 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[17][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 17 && posX1 == 5) || ( posY2 == 17 && posX2 == 5) || ( posY3 == 17 && posX3 == 5) || ( posY4 == 17 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[17][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 17 && posX1 == 6) || ( posY2 == 17 && posX2 == 6) || ( posY3 == 17 && posX3 == 6) || ( posY4 == 17 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[17][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 17 && posX1 == 7) || ( posY2 == 17 && posX2 == 7) || ( posY3 == 17 && posX3 == 7) || ( posY4 == 17 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[17][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 17 && posX1 == 8) || ( posY2 == 17 && posX2 == 8) || ( posY3 == 17 && posX3 == 8) || ( posY4 == 17 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[17][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 17 && posX1 == 9) || ( posY2 == 17 && posX2 == 9) || ( posY3 == 17 && posX3 == 9) || ( posY4 == 17 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[17][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 17 && posX1 == 10) || ( posY2 == 17 && posX2 == 10) || ( posY3 == 17 && posX3 == 10) || ( posY4 == 17 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[17][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 236 &&  vc <= 246) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 18 && posX1 == 1) || ( posY2 == 18 && posX2 == 1) || ( posY3 == 18 && posX3 == 1) || ( posY4 == 18 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[18][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 18 && posX1 == 2) || ( posY2 == 18 && posX2 == 2) || ( posY3 == 18 && posX3 == 2) || ( posY4 == 18 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[18][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 18 && posX1 == 3) || ( posY2 == 18 && posX2 == 3) || ( posY3 == 18 && posX3 == 3) || ( posY4 == 18 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[18][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 18 && posX1 == 4) || ( posY2 == 18 && posX2 == 4) || ( posY3 == 18 && posX3 == 4) || ( posY4 == 18 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[18][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 18 && posX1 == 5) || ( posY2 == 18 && posX2 == 5) || ( posY3 == 18 && posX3 == 5) || ( posY4 == 18 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[18][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 18 && posX1 == 6) || ( posY2 == 18 && posX2 == 6) || ( posY3 == 18 && posX3 == 6) || ( posY4 == 18 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[18][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 18 && posX1 == 7) || ( posY2 == 18 && posX2 == 7) || ( posY3 == 18 && posX3 == 7) || ( posY4 == 18 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[18][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 18 && posX1 == 8) || ( posY2 == 18 && posX2 == 8) || ( posY3 == 18 && posX3 == 8) || ( posY4 == 18 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[18][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 18 && posX1 == 9) || ( posY2 == 18 && posX2 == 9) || ( posY3 == 18 && posX3 == 9) || ( posY4 == 18 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[18][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 18 && posX1 == 10) || ( posY2 == 18 && posX2 == 10) || ( posY3 == 18 && posX3 == 10) || ( posY4 == 18 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[18][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 247 &&  vc <= 257) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 19 && posX1 == 1) || ( posY2 == 19 && posX2 == 1) || ( posY3 == 19 && posX3 == 1) || ( posY4 == 19 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[19][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 19 && posX1 == 2) || ( posY2 == 19 && posX2 == 2) || ( posY3 == 19 && posX3 == 2) || ( posY4 == 19 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[19][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 19 && posX1 == 3) || ( posY2 == 19 && posX2 == 3) || ( posY3 == 19 && posX3 == 3) || ( posY4 == 19 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[19][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 19 && posX1 == 4) || ( posY2 == 19 && posX2 == 4) || ( posY3 == 19 && posX3 == 4) || ( posY4 == 19 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[19][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 19 && posX1 == 5) || ( posY2 == 19 && posX2 == 5) || ( posY3 == 19 && posX3 == 5) || ( posY4 == 19 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[19][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 19 && posX1 == 6) || ( posY2 == 19 && posX2 == 6) || ( posY3 == 19 && posX3 == 6) || ( posY4 == 19 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[19][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 19 && posX1 == 7) || ( posY2 == 19 && posX2 == 7) || ( posY3 == 19 && posX3 == 7) || ( posY4 == 19 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[19][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 19 && posX1 == 8) || ( posY2 == 19 && posX2 == 8) || ( posY3 == 19 && posX3 == 8) || ( posY4 == 19 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[19][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 19 && posX1 == 9) || ( posY2 == 19 && posX2 == 9) || ( posY3 == 19 && posX3 == 9) || ( posY4 == 19 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[19][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 19 && posX1 == 10) || ( posY2 == 19 && posX2 == 10) || ( posY3 == 19 && posX3 == 10) || ( posY4 == 19 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[19][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 258 &&  vc <= 268) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 20 && posX1 == 1) || ( posY2 == 20 && posX2 == 1) || ( posY3 == 20 && posX3 == 1) || ( posY4 == 20 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[20][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 20 && posX1 == 2) || ( posY2 == 20 && posX2 == 2) || ( posY3 == 20 && posX3 == 2) || ( posY4 == 20 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[20][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 20 && posX1 == 3) || ( posY2 == 20 && posX2 == 3) || ( posY3 == 20 && posX3 == 3) || ( posY4 == 20 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[20][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 20 && posX1 == 4) || ( posY2 == 20 && posX2 == 4) || ( posY3 == 20 && posX3 == 4) || ( posY4 == 20 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[20][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 20 && posX1 == 5) || ( posY2 == 20 && posX2 == 5) || ( posY3 == 20 && posX3 == 5) || ( posY4 == 20 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[20][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 20 && posX1 == 6) || ( posY2 == 20 && posX2 == 6) || ( posY3 == 20 && posX3 == 6) || ( posY4 == 20 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[20][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 20 && posX1 == 7) || ( posY2 == 20 && posX2 == 7) || ( posY3 == 20 && posX3 == 7) || ( posY4 == 20 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[20][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 20 && posX1 == 8) || ( posY2 == 20 && posX2 == 8) || ( posY3 == 20 && posX3 == 8) || ( posY4 == 20 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[20][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 20 && posX1 == 9) || ( posY2 == 20 && posX2 == 9) || ( posY3 == 20 && posX3 == 9) || ( posY4 == 20 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[20][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 20 && posX1 == 10) || ( posY2 == 20 && posX2 == 10) || ( posY3 == 20 && posX3 == 10) || ( posY4 == 20 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[20][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 269 &&  vc <= 279) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 21 && posX1 == 1) || ( posY2 == 21 && posX2 == 1) || ( posY3 == 21 && posX3 == 1) || ( posY4 == 21 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[21][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 21 && posX1 == 2) || ( posY2 == 21 && posX2 == 2) || ( posY3 == 21 && posX3 == 2) || ( posY4 == 21 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[21][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 21 && posX1 == 3) || ( posY2 == 21 && posX2 == 3) || ( posY3 == 21 && posX3 == 3) || ( posY4 == 21 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[21][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 21 && posX1 == 4) || ( posY2 == 21 && posX2 == 4) || ( posY3 == 21 && posX3 == 4) || ( posY4 == 21 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[21][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 21 && posX1 == 5) || ( posY2 == 21 && posX2 == 5) || ( posY3 == 21 && posX3 == 5) || ( posY4 == 21 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[21][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 21 && posX1 == 6) || ( posY2 == 21 && posX2 == 6) || ( posY3 == 21 && posX3 == 6) || ( posY4 == 21 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[21][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 21 && posX1 == 7) || ( posY2 == 21 && posX2 == 7) || ( posY3 == 21 && posX3 == 7) || ( posY4 == 21 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[21][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 21 && posX1 == 8) || ( posY2 == 21 && posX2 == 8) || ( posY3 == 21 && posX3 == 8) || ( posY4 == 21 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[21][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 21 && posX1 == 9) || ( posY2 == 21 && posX2 == 9) || ( posY3 == 21 && posX3 == 9) || ( posY4 == 21 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[21][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 21 && posX1 == 10) || ( posY2 == 21 && posX2 == 10) || ( posY3 == 21 && posX3 == 10) || ( posY4 == 21 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[21][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end
      else if (vc > 280 &&  vc <= 290) begin
        if (hc >160 &&  hc <=170) begin
          if ( ( posY1 == 22 && posX1 == 1) || ( posY2 == 22 && posX2 == 1) || ( posY3 == 22 && posX3 == 1) || ( posY4 == 22 && posX4 == 1)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[22][1]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >171 &&  hc <=181) begin
          if ( ( posY1 == 22 && posX1 == 2) || ( posY2 == 22 && posX2 == 2) || ( posY3 == 22 && posX3 == 2) || ( posY4 == 22 && posX4 == 2)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[22][2]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >182 &&  hc <=192) begin
          if ( ( posY1 == 22 && posX1 == 3) || ( posY2 == 22 && posX2 == 3) || ( posY3 == 22 && posX3 == 3) || ( posY4 == 22 && posX4 == 3)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[22][3]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >193 &&  hc <=203) begin
          if ( ( posY1 == 22 && posX1 == 4) || ( posY2 == 22 && posX2 == 4) || ( posY3 == 22 && posX3 == 4) || ( posY4 == 22 && posX4 == 4)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[22][4]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >204 &&  hc <=214) begin
          if ( ( posY1 == 22 && posX1 == 5) || ( posY2 == 22 && posX2 == 5) || ( posY3 == 22 && posX3 == 5) || ( posY4 == 22 && posX4 == 5)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[22][5]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >215 &&  hc <=225) begin
          if ( ( posY1 == 22 && posX1 == 6) || ( posY2 == 22 && posX2 == 6) || ( posY3 == 22 && posX3 == 6) || ( posY4 == 22 && posX4 == 6)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[22][6]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >226 &&  hc <=236) begin
          if ( ( posY1 == 22 && posX1 == 7) || ( posY2 == 22 && posX2 == 7) || ( posY3 == 22 && posX3 == 7) || ( posY4 == 22 && posX4 == 7)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[22][7]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >237 &&  hc <=247) begin
          if ( ( posY1 == 22 && posX1 == 8) || ( posY2 == 22 && posX2 == 8) || ( posY3 == 22 && posX3 == 8) || ( posY4 == 22 && posX4 == 8)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[22][8]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >248 &&  hc <=258) begin
          if ( ( posY1 == 22 && posX1 == 9) || ( posY2 == 22 && posX2 == 9) || ( posY3 == 22 && posX3 == 9) || ( posY4 == 22 && posX4 == 9)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[22][9]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else     if (hc >259 &&  hc <=269) begin
          if ( ( posY1 == 22 && posX1 == 10) || ( posY2 == 22 && posX2 == 10) || ( posY3 == 22 && posX3 == 10) || ( posY4 == 22 && posX4 == 10)) begin
            red = 4'b1111;
            green = 4'b0000;
            blue = 4'b0000;
          end
          else if ( grid[22][10]) begin
            red = 4'b0000;
            green = 4'b1111;
            blue = 4'b0000;
          end
          else begin
            red = 4'b1111;
            green = 4'b1111;
            blue = 4'b1111;
          end
        end
        else begin
          red = 4'b0000;
          green = 4'b0000;
          blue = 4'b0000;
        end
      end


      // GENERATED CODE ENDS HERE
      // black lines between squares
      else begin
        red = 4'b0000;
        green = 4'b0000;
        blue = 4'b0000;
      end
    end

    // we're outside active vertical range so display black
    else begin
      red = 4'b0000;
      green = 4'b0000;
      blue = 4'b0000;
    end
  end

endmodule