`timescale 1ns / 1ps

module GameLogicV2(
  input logic reset,
  input logic clk,
  output logic [11:0] outGrid [23:0],

  output wire [9:0] x1,
  output wire [9:0] y1,
  output wire [9:0] x2,
  output wire [9:0] y2,
  output wire [9:0] x3,
  output wire [9:0] y3,
  output wire [9:0] x4,
  output wire [9:0] y4,

  input wire right,
  input wire left,
  input wire down,
  input wire up,
  input wire stop,

  input logic [2:0] nextBlockRand,
  input logic [2:0] nextBlockSwitch,
  output logic gameOver,
  output logic [7:0] score
);

  // Game grid
  logic [11:0] grid [23:0];

  // Registers for block type
  logic [2:0] currentBlock;
  logic [2:0] nextBlock;
  always @(posedge clk or posedge reset)
  begin
    // reset condition
    if ( reset)
        nextBlock <= nextBlockRand;
    else if ( nextBlockSwitch == 3'b000)
      nextBlock <= nextBlockRand;
    else
      nextBlock <= nextBlockSwitch;
  end
  
  // STATES
  logic [6:0] state;
  parameter INIT = 1;
  parameter GENERATE = 2;
  parameter WAIT = 3;
  parameter TRYMOVELEFT = 4;
  parameter TRYMOVERIGHT = 5;
  parameter TRYROTATE = 6;
  parameter TRYFALLDOWN = 7;
  
  parameter CLEARLINES1  = 8;
  parameter CLEARLINES12 = 9;
  parameter CLEARLINES13 = 10;
  parameter CLEARLINES14 = 11;
  parameter CLEARLINES15 = 12;
  parameter CLEARLINES16 = 13;
  parameter CLEARLINES17 = 14;
  parameter CLEARLINES18 = 15;
  
  parameter CLEARLINES2 = 16;
  parameter CLEARLINES22 = 17;
  parameter CLEARLINES23 = 18;
  parameter CLEARLINES24 = 19;
  parameter CLEARLINES25 = 20;
  parameter CLEARLINES26 = 21;
  parameter CLEARLINES27 = 22;
  parameter CLEARLINES28 = 23;
  
  parameter CLEARLINES3 = 24;
  parameter CLEARLINES32 = 25;
  parameter CLEARLINES33 = 26;
  parameter CLEARLINES34 = 27;
  parameter CLEARLINES35 = 28;
  parameter CLEARLINES36 = 29;
  parameter CLEARLINES37 = 30;
  parameter CLEARLINES38 = 31;
  
  parameter CLEARLINES4 = 32;
  parameter CLEARLINES42 = 33;
  parameter CLEARLINES43 = 34;
  parameter CLEARLINES44 = 35;
  parameter CLEARLINES45 = 36;
  parameter CLEARLINES46 = 37;
  parameter CLEARLINES47 = 38;
  parameter CLEARLINES48 = 39;
  
  parameter GAMEOVER = 40;

  // BLOCK CODES
  parameter T = 3'b001;
  parameter S = 3'b010;
  parameter O = 3'b011;
  parameter J = 3'b100; 
  parameter L = 3'b101;
  parameter Z = 3'b110;  
  parameter I = 3'b111;

  // Registers for rotation state
  logic rotState1Bit;
  logic [1:0] rotState2Bit;

  // Registers for moving blocks
  logic [9:0] x1reg;
  logic [9:0] y1reg;
  logic [9:0] x2reg;
  logic [9:0] y2reg;
  logic [9:0] x3reg;
  logic [9:0] y3reg;
  logic [9:0] x4reg;
  logic [9:0] y4reg;

  // Registers for collision check
  logic [9:0] x1try;
  logic [9:0] y1try;
  logic [9:0] x2try;
  logic [9:0] y2try;
  logic [9:0] x3try;
  logic [9:0] y3try;
  logic [9:0] x4try;
  logic [9:0] y4try;

  // Timer for block fall
  logic [23:0] downTimer;

  // Game loop
  always @(posedge clk or posedge reset)
    begin
      // reset condition
      if (reset == 1) begin
        state <= INIT;
      end
      else begin
        case ( state)
            INIT: begin
                // Initilize grid
                for ( integer i = 0; i < 24; i = i + 1)
                  for ( integer j = 0; j < 12; j = j + 1)
                    grid[i][j] = 0;
        
                // Initialize borders
                for ( integer i = 0; i < 24; i = i + 1)
                  grid[i][0] = 1;
        
                for ( integer i = 0; i < 24; i = i + 1)
                  grid[i][11] = 1;
        
                for ( integer i = 1; i < 11; i = i + 1)
                  grid[23][i] = 1;
                
                score <= 0;
                downTimer <= 0;
                gameOver <= 0;
                state <= GENERATE;
            end
            
            GENERATE: begin
                case (nextBlock)
                      I : begin
                        x1reg <= 4;
                        y1reg <= 1;
                        x2reg <= 5;
                        y2reg <= 1;
                        x3reg <= 6;
                        y3reg <= 1;
                        x4reg <= 7;
                        y4reg <= 1;
                        currentBlock <= I;
                      end
        
                      J : begin
                        x1reg <= 4;
                        y1reg <= 0;
                        x2reg <= 4;
                        y2reg <= 1;
                        x3reg <= 5;
                        y3reg <= 1;
                        x4reg <= 6;
                        y4reg <= 1;
                        currentBlock <= J;
                      end
        
                      L : begin
                        x1reg <= 6;
                        y1reg <= 0;
                        x2reg <= 4;
                        y2reg <= 1;
                        x3reg <= 5;
                        y3reg <= 1;
                        x4reg <= 6;
                        y4reg <= 1;
                        currentBlock <= L;
                      end
        
                      S : begin
                        x1reg <= 4;
                        y1reg <= 1;
                        x2reg <= 5;
                        y2reg <= 0;
                        x3reg <= 5;
                        y3reg <= 1;
                        x4reg <= 6;
                        y4reg <= 0;
                        currentBlock <= S;
                      end
        
                      T : begin
                        x1reg <= 4;
                        y1reg <= 1;
                        x2reg <= 5;
                        y2reg <= 0;
                        x3reg <= 5;
                        y3reg <= 1;
                        x4reg <= 6;
                        y4reg <= 1;
                        currentBlock <= T;
                      end
        
                      Z : begin
                        x1reg <= 4;
                        y1reg <= 0;
                        x2reg <= 5;
                        y2reg <= 0;
                        x3reg <= 5;
                        y3reg <= 1;
                        x4reg <= 6;
                        y4reg <= 1;
                        currentBlock <= Z;
                      end
        
                      O : begin
                        x1reg <= 5;
                        y1reg <= 0;
                        x2reg <= 6;
                        y2reg <= 0;
                        x3reg <= 5;
                        y3reg <= 1;
                        x4reg <= 6;
                        y4reg <= 1;
                        currentBlock <= O;
                      end    
        
                      default : begin // O
                        x1reg <= 5;
                        y1reg <= 0;
                        x2reg <= 6;
                        y2reg <= 0;
                        x3reg <= 5;
                        y3reg <= 1;
                        x4reg <= 6;
                        y4reg <= 1;
                        currentBlock <= O;
                      end
                   endcase
                    
                    rotState1Bit <= 1'b0;
                    rotState2Bit <= 2'b00;
                    state <= WAIT;
                end
                
                WAIT: begin
                    downTimer <= downTimer + 1;
                    if ( (!stop && &downTimer) || down) state <= TRYFALLDOWN;
                    else if ( left) state <= TRYMOVELEFT;
                    else if ( right) state <= TRYMOVERIGHT;
                    else if ( up) state <= TRYROTATE;
                    else state <= WAIT;
                end
                
                TRYFALLDOWN: begin
                      x1try = x1reg;
                      y1try = y1reg + 1;
                      x2try = x2reg;
                      y2try = y2reg + 1;
                      x3try = x3reg;
                      y3try = y3reg + 1;
                      x4try = x4reg;
                      y4try = y4reg + 1;
                                      
                      if ( grid[y1try][x1try] || grid[y2try][x2try] || grid[y3try][x3try] || grid[y4try][x4try]) begin
                          grid[y1reg][x1reg] = 1;
                          grid[y2reg][x2reg] = 1;
                          grid[y3reg][x3reg] = 1;
                          grid[y4reg][x4reg] = 1;
                          
                          if ( grid[0] != 12'b100000000001 || grid[1] != 12'b100000000001) begin 
                            gameOver <= 1; state <= GAMEOVER;
                            x1reg <= 0;
                            y1reg <= 0;
                            x2reg <= 0;
                            y2reg <= 0;
                            x3reg <= 0;
                            y3reg <= 0;
                            x4reg <= 0;
                            y4reg <= 0;
                          end
                          else if (grid[y1reg] == 12'b111111111111) state <= CLEARLINES1;
                          else if (grid[y2reg] == 12'b111111111111) state <= CLEARLINES2;
                          else if (grid[y3reg] == 12'b111111111111) state <= CLEARLINES3;
                          else if (grid[y4reg] == 12'b111111111111) state <= CLEARLINES4;
                          else state <= GENERATE;
                      end else begin
                          x1reg = x1try;
                          y1reg = y1try;
                          x2reg = x2try;
                          y2reg = y2try;
                          x3reg = x3try;
                          y3reg = y3try;
                          x4reg = x4try;
                          y4reg = y4try;
                          
                          state <= WAIT;
                      end
                end
                
                GAMEOVER: state <= GAMEOVER;
                
                CLEARLINES1: begin
                  grid[y1reg] = 12'b100000000001;
                  if ( 21 < y1reg) grid[22] = grid[21];
                  if ( 20 < y1reg) grid[21] = grid[20];
                  if ( 19 < y1reg) grid[20] = grid[19];
                  state <= CLEARLINES12;
                end
                
                CLEARLINES12: begin
                  if ( 18 < y1reg) grid[19] = grid[18];
                  if ( 17 < y1reg) grid[18] = grid[17];
                  if ( 16 < y1reg) grid[17] = grid[16];
                  state <= CLEARLINES13;
                end
                
                CLEARLINES13: begin
                  if ( 15 < y1reg) grid[16] = grid[15];
                  if ( 14 < y1reg) grid[15] = grid[14];
                  if ( 13 < y1reg) grid[14] = grid[13];
                  state <= CLEARLINES14;
                end
               
                CLEARLINES14: begin
                  if ( 12 < y1reg) grid[13] = grid[12];
                  if ( 11 < y1reg) grid[12] = grid[11];
                  if ( 10 < y1reg) grid[11] = grid[10];
                  state <= CLEARLINES15;
                end
                
                CLEARLINES15: begin
                  if ( 9  < y1reg) grid[10] =  grid[9];
                  if ( 8  < y1reg) grid[9]  =  grid[8];
                  if ( 7  < y1reg) grid[8]  =  grid[7];
                  state <= CLEARLINES16;
                end
                
                CLEARLINES16: begin
                  if ( 6  < y1reg) grid[7]  =  grid[6];
                  if ( 5  < y1reg) grid[6]  =  grid[5];
                  if ( 4  < y1reg) grid[5]  =  grid[4];
                  state <= CLEARLINES17;
                end
                
                CLEARLINES17: begin
                  if ( 3  < y1reg) grid[4]  =  grid[3];
                  if ( 2  < y1reg) grid[3]  =  grid[2];
                  if ( 1  < y1reg) grid[2]  =  grid[1];
                  if ( 0  < y1reg) grid[1]  =  grid[0];
                  state <= CLEARLINES18;
                end
                 
                CLEARLINES18: begin
                  // Clear line
                  grid[0] = 12'b100000000001;
                  score <= score + 1;
                  
                  if (grid[y2reg] == 12'b111111111111) state <= CLEARLINES2;
                  else if (grid[y3reg] == 12'b111111111111) state <= CLEARLINES3;
                  else if (grid[y4reg] == 12'b111111111111) state <= CLEARLINES4;
                  else state <= GENERATE;
                end
                
                CLEARLINES2: begin
                  grid[y2reg] = 12'b100000000001;
                  if ( 21 < y2reg) grid[22] = grid[21];
                  if ( 20 < y2reg) grid[21] = grid[20];
                  if ( 19 < y2reg) grid[20] = grid[19];
                  state <= CLEARLINES22;
                end
                
                CLEARLINES22: begin
                  if ( 18 < y2reg) grid[19] = grid[18];
                  if ( 17 < y2reg) grid[18] = grid[17];
                  if ( 16 < y2reg) grid[17] = grid[16];
                  state <= CLEARLINES23;
                end
                
                CLEARLINES23: begin
                  if ( 15 < y2reg) grid[16] = grid[15];
                  if ( 14 < y2reg) grid[15] = grid[14];
                  if ( 13 < y2reg) grid[14] = grid[13];
                  state <= CLEARLINES24;
                end
               
                CLEARLINES24: begin
                  if ( 12 < y2reg) grid[13] = grid[12];
                  if ( 11 < y2reg) grid[12] = grid[11];
                  if ( 10 < y2reg) grid[11] = grid[10];
                  state <= CLEARLINES25;
                end
                
                CLEARLINES25: begin
                  if ( 9  < y2reg) grid[10] =  grid[9];
                  if ( 8  < y2reg) grid[9]  =  grid[8];
                  if ( 7  < y2reg) grid[8]  =  grid[7];
                  state <= CLEARLINES26;
                end
                
                CLEARLINES26: begin
                  if ( 6  < y2reg) grid[7]  =  grid[6];
                  if ( 5  < y2reg) grid[6]  =  grid[5];
                  if ( 4  < y2reg) grid[5]  =  grid[4];
                  state <= CLEARLINES27;
                end
                
                CLEARLINES27: begin
                  if ( 3  < y2reg) grid[4]  =  grid[3];
                  if ( 2  < y2reg) grid[3]  =  grid[2];
                  if ( 1  < y2reg) grid[2]  =  grid[1];
                  if ( 0  < y2reg) grid[1]  =  grid[0];
                  state <= CLEARLINES28;
                end
                 
                CLEARLINES28: begin
                  // Clear line
                  grid[0] = 12'b100000000001;
                  score <= score + 1;
                  
                  if (grid[y3reg] == 12'b111111111111) state <= CLEARLINES3;
                  else if (grid[y4reg] == 12'b111111111111) state <= CLEARLINES4;
                  else state <= GENERATE;
                end
                
                CLEARLINES3: begin
                  grid[y3reg] = 12'b100000000001;
                  if ( 21 < y3reg) grid[22] = grid[21];
                  if ( 20 < y3reg) grid[21] = grid[20];
                  if ( 19 < y3reg) grid[20] = grid[19];
                  state <= CLEARLINES32;
                end
                
                CLEARLINES32: begin
                  if ( 18 < y3reg) grid[19] = grid[18];
                  if ( 17 < y3reg) grid[18] = grid[17];
                  if ( 16 < y3reg) grid[17] = grid[16];
                  state <= CLEARLINES33;
                end
                
                CLEARLINES33: begin
                  if ( 15 < y3reg) grid[16] = grid[15];
                  if ( 14 < y3reg) grid[15] = grid[14];
                  if ( 13 < y3reg) grid[14] = grid[13];
                  state <= CLEARLINES34;
                end
               
                CLEARLINES34: begin
                  if ( 12 < y3reg) grid[13] = grid[12];
                  if ( 11 < y3reg) grid[12] = grid[11];
                  if ( 10 < y3reg) grid[11] = grid[10];
                  state <= CLEARLINES35;
                end
                
                CLEARLINES35: begin
                  if ( 9  < y3reg) grid[10] =  grid[9];
                  if ( 8  < y3reg) grid[9]  =  grid[8];
                  if ( 7  < y3reg) grid[8]  =  grid[7];
                  state <= CLEARLINES36;
                end
                
                CLEARLINES36: begin
                  if ( 6  < y3reg) grid[7]  =  grid[6];
                  if ( 5  < y3reg) grid[6]  =  grid[5];
                  if ( 4  < y3reg) grid[5]  =  grid[4];
                  state <= CLEARLINES37;
                end
                
                CLEARLINES37: begin
                  if ( 3  < y3reg) grid[4]  =  grid[3];
                  if ( 2  < y3reg) grid[3]  =  grid[2];
                  if ( 1  < y3reg) grid[2]  =  grid[1];
                  if ( 0  < y3reg) grid[1]  =  grid[0];
                  state <= CLEARLINES38;
                end
                 
                CLEARLINES38: begin
                  // Clear line
                  grid[0] = 12'b100000000001;
                  score <= score + 1;
                  
                  if (grid[y4reg] == 12'b111111111111) state <= CLEARLINES4;
                  else state <= GENERATE;
                end
                
                CLEARLINES4: begin
                  grid[y4reg] = 12'b100000000001;
                  if ( 21 < y4reg) grid[22] = grid[21];
                  if ( 20 < y4reg) grid[21] = grid[20];
                  if ( 19 < y4reg) grid[20] = grid[19];
                  state <= CLEARLINES42;
                end
                
                CLEARLINES42: begin
                  if ( 18 < y4reg) grid[19] = grid[18];
                  if ( 17 < y4reg) grid[18] = grid[17];
                  if ( 16 < y4reg) grid[17] = grid[16];
                  state <= CLEARLINES43;
                end
                
                CLEARLINES43: begin
                  if ( 15 < y4reg) grid[16] = grid[15];
                  if ( 14 < y4reg) grid[15] = grid[14];
                  if ( 13 < y4reg) grid[14] = grid[13];
                  state <= CLEARLINES44;
                end
               
                CLEARLINES44: begin
                  if ( 12 < y4reg) grid[13] = grid[12];
                  if ( 11 < y4reg) grid[12] = grid[11];
                  if ( 10 < y4reg) grid[11] = grid[10];
                  state <= CLEARLINES45;
                end
                
                CLEARLINES45: begin
                  if ( 9  < y4reg) grid[10] =  grid[9];
                  if ( 8  < y4reg) grid[9]  =  grid[8];
                  if ( 7  < y4reg) grid[8]  =  grid[7];
                  state <= CLEARLINES46;
                end
                
                CLEARLINES46: begin
                  if ( 6  < y4reg) grid[7]  =  grid[6];
                  if ( 5  < y4reg) grid[6]  =  grid[5];
                  if ( 4  < y4reg) grid[5]  =  grid[4];
                  state <= CLEARLINES47;
                end
                
                CLEARLINES47: begin
                  if ( 3  < y4reg) grid[4]  =  grid[3];
                  if ( 2  < y4reg) grid[3]  =  grid[2];
                  if ( 1  < y4reg) grid[2]  =  grid[1];
                  if ( 0  < y4reg) grid[1]  =  grid[0];
                  state <= CLEARLINES48;
                end
                 
                CLEARLINES48: begin
                  // Clear line
                  grid[0] = 12'b100000000001;
                  score <= score + 1;
                  
                  state <= GENERATE;
                end
                
                TRYMOVELEFT: begin
                  x1try = x1reg - 1;
                  y1try = y1reg;
                  x2try = x2reg - 1;
                  y2try = y2reg;
                  x3try = x3reg - 1;
                  y3try = y3reg;
                  x4try = x4reg - 1;
                  y4try = y4reg;
        
                  if ( !grid[y1try][x1try] && !grid[y2try][x2try] && !grid[y3try][x3try] && !grid[y4try][x4try]) begin
                    x1reg = x1try;
                    y1reg = y1try;
                    x2reg = x2try;
                    y2reg = y2try;
                    x3reg = x3try;
                    y3reg = y3try;
                    x4reg = x4try;
                    y4reg = y4try;
                  end
                  state <= WAIT;
                end
                
                TRYMOVERIGHT: begin
                  x1try = x1reg + 1;
                  y1try = y1reg;
                  x2try = x2reg + 1;
                  y2try = y2reg;
                  x3try = x3reg + 1;
                  y3try = y3reg;
                  x4try = x4reg + 1;
                  y4try = y4reg;
        
                  if ( !grid[y1try][x1try] && !grid[y2try][x2try] && !grid[y3try][x3try] && !grid[y4try][x4try]) begin
                    x1reg = x1try;
                    y1reg = y1try;
                    x2reg = x2try;
                    y2reg = y2try;
                    x3reg = x3try;
                    y3reg = y3try;
                    x4reg = x4try;
                    y4reg = y4try;
                   end
                   state <= WAIT;
                end
                
                TRYROTATE: begin
                    case( currentBlock)                                
                        I : case ( rotState1Bit)
                          1'b0 : begin x1try = x1reg + 2;  y1try = y1reg - 2; x2try = x2reg + 1; y2try = y2reg - 1; x3try = x3reg; y3try = y3reg; x4try = x4reg - 1; y4try = y4reg + 1; end
                          1'b1 : begin x1try = x1reg - 2;  y1try = y1reg + 2; x2try = x2reg - 1; y2try = y2reg + 1; x3try = x3reg; y3try = y3reg; x4try = x4reg + 1; y4try = y4reg - 1; end
                        endcase
                        J : case ( rotState2Bit)
                          2'b00: begin x1try = x1reg + 2;  y1try = y1reg; x2try = x2reg + 1; y2try = y2reg - 1; x3try = x3reg; y3try = y3reg; x4try = x4reg - 1; y4try = y4reg + 1; end
                          2'b01: begin x1try = x1reg;  y1try = y1reg + 2; x2try = x2reg + 1; y2try = y2reg + 1; x3try = x3reg; y3try = y3reg; x4try = x4reg - 1; y4try = y4reg - 1; end
                          2'b10: begin x1try = x1reg - 2;  y1try = y1reg; x2try = x2reg - 1; y2try = y2reg + 1; x3try = x3reg; y3try = y3reg; x4try = x4reg + 1; y4try = y4reg - 1; end
                          2'b11: begin x1try = x1reg;  y1try = y1reg - 2; x2try = x2reg - 1; y2try = y2reg - 1; x3try = x3reg; y3try = y3reg; x4try = x4reg + 1; y4try = y4reg + 1; end
                        endcase
                        L : case ( rotState2Bit)
                          2'b00: begin x1try = x1reg;  y1try = y1reg + 2; x2try = x2reg + 1; y2try = y2reg - 1; x3try = x3reg; y3try = y3reg; x4try = x4reg - 1; y4try = y4reg + 1; end
                          2'b01: begin x1try = x1reg - 2;  y1try = y1reg; x2try = x2reg + 1; y2try = y2reg + 1; x3try = x3reg; y3try = y3reg; x4try = x4reg - 1; y4try = y4reg - 1; end
                          2'b10: begin x1try = x1reg;  y1try = y1reg - 2; x2try = x2reg - 1; y2try = y2reg + 1; x3try = x3reg; y3try = y3reg; x4try = x4reg + 1; y4try = y4reg - 1; end
                          2'b11: begin x1try = x1reg + 2;  y1try = y1reg; x2try = x2reg - 1; y2try = y2reg - 1; x3try = x3reg; y3try = y3reg; x4try = x4reg + 1; y4try = y4reg + 1; end
                        endcase
                        S : case ( rotState1Bit)
                          1'b0: begin x1try = x1reg + 1;  y1try = y1reg + 1; x2try = x2reg - 1; y2try = y2reg + 1; x3try = x3reg; y3try = y3reg; x4try = x4reg - 2; y4try = y4reg; end
                          1'b1: begin x1try = x1reg - 1;  y1try = y1reg - 1; x2try = x2reg + 1; y2try = y2reg - 1; x3try = x3reg; y3try = y3reg; x4try = x4reg + 2; y4try = y4reg; end
                        endcase    
                        T : case ( rotState2Bit)
                          2'b00: begin x1try = x1reg + 1;  y1try = y1reg - 1; x2try = x2reg + 1; y2try = y2reg + 1; x3try = x3reg; y3try = y3reg; x4try = x4reg - 1; y4try = y4reg + 1; end
                          2'b01: begin x1try = x1reg + 1;  y1try = y1reg + 1; x2try = x2reg - 1; y2try = y2reg + 1; x3try = x3reg; y3try = y3reg; x4try = x4reg - 1; y4try = y4reg - 1; end
                          2'b10: begin x1try = x1reg - 1;  y1try = y1reg + 1; x2try = x2reg - 1; y2try = y2reg - 1; x3try = x3reg; y3try = y3reg; x4try = x4reg + 1; y4try = y4reg - 1; end
                          2'b11: begin x1try = x1reg - 1;  y1try = y1reg - 1; x2try = x2reg + 1; y2try = y2reg - 1; x3try = x3reg; y3try = y3reg; x4try = x4reg + 1; y4try = y4reg + 1; end
                        endcase
                        Z : case ( rotState1Bit)
                          1'b0: begin x1try = x1reg + 2;  y1try = y1reg; x2try = x2reg + 1; y2try = y2reg + 1; x3try = x3reg; y3try = y3reg; x4try = x4reg - 1; y4try = y4reg + 1; end
                          1'b1: begin x1try = x1reg - 2;  y1try = y1reg; x2try = x2reg - 1; y2try = y2reg - 1; x3try = x3reg; y3try = y3reg; x4try = x4reg + 1; y4try = y4reg - 1; end
                        endcase
                        default: begin end // O
                      endcase
                      
                      if ( !grid[y1try][x1try] && !grid[y2try][x2try] && !grid[y3try][x3try] && !grid[y4try][x4try]) begin
                          x1reg = x1try;
                          y1reg = y1try;
                          x2reg = x2try;
                          y2reg = y2try;
                          x3reg = x3try;
                          y3reg = y3try;
                          x4reg = x4try;
                          y4reg = y4try;
                          
                          rotState1Bit <= rotState1Bit + 1;
                          rotState2Bit <= rotState2Bit + 1;
                         end
                         state <= WAIT;
                end
            endcase
        end
    end

  assign outGrid = grid;

  assign x1 = x1reg;
  assign y1 = y1reg;
  assign x2 = x2reg;
  assign y2 = y2reg;
  assign x3 = x3reg;
  assign y3 = y3reg;
  assign x4 = x4reg;
  assign y4 = y4reg;
endmodule
