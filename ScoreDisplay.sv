`timescale 1ns / 1ps

module ScoreDisplay( input logic[7:0] score, input logic clk, input logic reset, output logic [3:0] an, output logic [6:0] seg, output logic dp);
    
    
    logic[11:0] decimal;
    
    BinaryToDecimal bdc( .bin(score), .bcd(decimal));
    SevSeg( .clk(clk), .in0(decimal[3:0]), .in1(decimal[7:4]), .in2(decimal[11:8]), .in3(0), .a(seg[0]), .b(seg[1]), .c(seg[2]), .d(seg[3]), .e(seg[4]), .f(seg[5]), .g(seg[6]), .dp(dp), .an(an));
    
endmodule
