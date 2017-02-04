
module tetrisTheme(
	input clk,
	input reset,
	output reg speaker,
	output reg speaker2
);

logic [5:0] q;

always @ ( posedge clk, posedge reset) begin
    if ( reset)
        q <= 0;
    else
        q <= q + 1;
end

reg [30:0] tone;
always @(posedge q[1]) tone <= tone+31'd1;

wire [7:0] fullnote;
wire [7:0] fullnote2;
music_ROM get_fullnote(.clk(clk), .address(tone[29:22]), .note(fullnote));
music_ROM2 get_fullnote2(.clk(clk), .address2(tone[29:22]), .note2(fullnote2));

wire [2:0] octave;
wire [2:0] octave2;
wire [3:0] note;
wire [3:0] note2;
divide_by12 get_octave_and_note(.numerator(fullnote[5:0]), .quotient(octave), .remainder(note));
divide_by12 get_octave_and_note2(.numerator(fullnote2[5:0]), .quotient(octave2), .remainder(note2));

reg [8:0] clkdivider;
reg [8:0] clkdivider2;

always @*
case(note)
	 0: clkdivider = 9'd511;//A
	 1: clkdivider = 9'd482;// A#/Bb
	 2: clkdivider = 9'd455;//B
	 3: clkdivider = 9'd430;//C
	 4: clkdivider = 9'd405;// C#/Db
	 5: clkdivider = 9'd383;//D
	 6: clkdivider = 9'd361;// D#/Eb
	 7: clkdivider = 9'd341;//E
	 8: clkdivider = 9'd322;//F
	 9: clkdivider = 9'd303;// F#/Gb
	10: clkdivider = 9'd286;//G
	11: clkdivider = 9'd270;// G#/Ab
	default: clkdivider = 9'd0;
endcase
always @*
case(note2)
	 0: clkdivider2 = 9'd511;//A
	 1: clkdivider2 = 9'd482;// A#/Bb
	 2: clkdivider2 = 9'd455;//B
	 3: clkdivider2 = 9'd430;//C
	 4: clkdivider2 = 9'd405;// C#/Db
	 5: clkdivider2 = 9'd383;//D
	 6: clkdivider2 = 9'd361;// D#/Eb
	 7: clkdivider2 = 9'd341;//E
	 8: clkdivider2 = 9'd322;//F
	 9: clkdivider2 = 9'd303;// F#/Gb
	10: clkdivider2 = 9'd286;//G
	11: clkdivider2 = 9'd270;// G#/Ab
	default: clkdivider2 = 9'd0;
endcase

reg [8:0] counter_note;
reg [7:0] counter_octave;
reg [8:0] counter_note2;
reg [7:0] counter_octave2;
always @(posedge clk) counter_note <= counter_note==0 ? clkdivider : counter_note-9'd1;
always @(posedge clk) if(counter_note==0) counter_octave <= counter_octave==0 ? 8'd255 >> octave : counter_octave-8'd1;
always @(posedge clk) if(counter_note==0 && counter_octave==0 && fullnote!=0 && tone[21:18]!=0) speaker <= ~speaker;

always @(posedge clk) counter_note2 <= counter_note2==0 ? clkdivider2 : counter_note2-9'd1;
always @(posedge clk) if(counter_note2==0) counter_octave2 <= counter_octave2==0 ? 8'd255 >> octave2 : counter_octave2-8'd1;
always @(posedge clk) if(counter_note2==0 && counter_octave2==0 && fullnote2!=0 && tone[21:18]!=0) speaker2 <= ~speaker2;


endmodule


/////////////////////////////////////////////////////
module divide_by12(
	input [5:0] numerator,  // value to be divided by 12
	output reg [2:0] quotient, 
	output [3:0] remainder
);

reg [1:0] remainder3to2;

always @(numerator[5:2])
case(numerator[5:2])
	 0: begin quotient=0; remainder3to2=0; end
	 1: begin quotient=0; remainder3to2=1; end
	 2: begin quotient=0; remainder3to2=2; end
	 3: begin quotient=1; remainder3to2=0; end
	 4: begin quotient=1; remainder3to2=1; end
	 5: begin quotient=1; remainder3to2=2; end
	 6: begin quotient=2; remainder3to2=0; end
	 7: begin quotient=2; remainder3to2=1; end
	 8: begin quotient=2; remainder3to2=2; end
	 9: begin quotient=3; remainder3to2=0; end
	10: begin quotient=3; remainder3to2=1; end
	11: begin quotient=3; remainder3to2=2; end
	12: begin quotient=4; remainder3to2=0; end
	13: begin quotient=4; remainder3to2=1; end
	14: begin quotient=4; remainder3to2=2; end
	15: begin quotient=5; remainder3to2=0; end
endcase

assign remainder[1:0] = numerator[1:0];  // the first 2 bits are copied through
assign remainder[3:2] = remainder3to2;  // and the last 2 bits come from the case statement
endmodule
/////////////////////////////////////////////////////

module music_ROM2(
	input clk,
	input [7:0] address2,
	output reg [7:0] note2
	);
always @(posedge clk)
case(address2)
	  0: note2<= 8'd34;      //1
	  1: note2<= 8'd0;        
	  2: note2<= 8'd29;      //2
	  3: note2<= 8'd30;      //3
	  4: note2<= 8'd32;      //4
	  5: note2<= 8'd0;
	  6: note2<= 8'd30;      //5
	  7: note2<= 8'd29;     //6
	  8: note2<= 8'd27;     //7
	  9: note2<= 8'd0;         
	  10: note2<= 8'd27;    //8
	 11: note2<= 8'd30;     //9
	 12: note2<= 8'd34;     //10
	 13: note2<= 8'd0;
	 14: note2<= 8'd32;  //11
	 15: note2<= 8'd30;  //12
	 16: note2<= 8'd29;  //13
	 17: note2<= 8'd0;
	 18: note2<= 8'd29; //14
	 19: note2<= 8'd30; //15
	 20: note2<= 8'd32; //16
	 21: note2<= 8'd0;
	 22: note2<= 8'd34; //17
	 23: note2<= 8'd0;
	 24: note2<= 8'd30; //18
	 25: note2<= 8'd0;
	 26: note2<= 8'd27; //19
     27: note2<= 8'd0; 
	 28: note2<= 8'd27; //20
	 29: note2<= 8'd0; 
	 30: note2<= 8'd0; 
	 31: note2<= 8'd0; 
	 32: note2<= 8'd0; 
	 33: note2<= 8'd32;//21
	 34: note2<= 8'd0;
	 35: note2<= 8'd35;//22 
	 36: note2<= 8'd39;//23
	 37: note2<= 8'd0;
	 38: note2<= 8'd37;//24
	 39: note2<= 8'd35;//25
	 40: note2<= 8'd34;//26
	 41: note2<= 8'd0;
	 42: note2<= 8'd30; //27   
	 43: note2<= 8'd0; 
	 44: note2<= 8'd34;//28
	 45: note2<= 8'd0;
	 46: note2<= 8'd32;//29
	 47: note2<= 8'd30;//30
	 48: note2<= 8'd29;//31
	 49: note2<= 8'd0;
	 50: note2<= 8'd29;//32
	 51: note2<= 8'd30;//33
	 52: note2<= 8'd32;//34
	 53: note2<= 8'd0;
	 54: note2<= 8'd34;//35
	 55: note2<= 8'd0;
     56: note2<= 8'd30;//36
     57: note2<= 8'd0;
     58: note2<= 8'd27;//37
     59: note2<= 8'd0;
     60: note2<= 8'd27;//38
       
     61: note2<= 8'd0;
     62: note2<= 8'd0;
     63: note2<= 8'd0;
     //64: note<= 8'd0;
     
	  64: note2<= 8'd34;      //1
	  65: note2<= 8'd0;        
	  66: note2<= 8'd29;      //2
	  67: note2<= 8'd30;      //3
	  68: note2<= 8'd32;      //4
	  69: note2<= 8'd0;
	  70: note2<= 8'd30;      //5
	  71: note2<= 8'd29;     //6
	  72: note2<= 8'd27;     //7
	  73: note2<= 8'd0;         
	  74: note2<= 8'd27;    //8
	 75: note2<= 8'd30;     //9
	 76: note2<= 8'd34;     //10
	 77: note2<= 8'd0;
	 78: note2<= 8'd32;  //11
	 79: note2<= 8'd30;  //12
	 80: note2<= 8'd29;  //13
	 81: note2<= 8'd0;
	 82: note2<= 8'd29; //14
	 83: note2<= 8'd30; //15
	 84: note2<= 8'd32; //16
	 85: note2<= 8'd0;
	 86: note2<= 8'd34; //17
	 87: note2<= 8'd0;
	 88: note2<= 8'd30; //18
	 89: note2<= 8'd0;
	 90: note2<= 8'd27; //19
     91: note2<= 8'd0; 
	 92: note2<= 8'd27; //20
	 93: note2<= 8'd0; 
	 94: note2<= 8'd0; 
	 95: note2<= 8'd0; 
	 96: note2<= 8'd0; 
	 97: note2<= 8'd32;//21
	 98: note2<= 8'd0;
	 99: note2<= 8'd35;//22 
	 100: note2<= 8'd39;//23
	 101: note2<= 8'd0;
	 102: note2<= 8'd37;//24
	 103: note2<= 8'd35;//25
	 104: note2<= 8'd34;//26
	 105: note2<= 8'd0;
	 106: note2<= 8'd30;//27
	 107: note2<= 8'd0;
	 108: note2<= 8'd34;//28
	 109: note2<= 8'd0;
	 110: note2<= 8'd32;//29
	 111: note2<= 8'd30;//30
	 112: note2<= 8'd29;//31
	 113: note2<= 8'd0;
	 114: note2<= 8'd29;//32
	 115: note2<= 8'd30;//33
	 116: note2<= 8'd32;//34
	 117: note2<= 8'd0;
	 118: note2<= 8'd34;//35
	 119: note2<= 8'd0;
     120: note2<= 8'd30;//36
     121: note2<= 8'd0;
     122: note2<= 8'd27;//37
     123: note2<= 8'd0;
     124: note2<= 8'd27;//38 
     
     125: note2<= 8'd0;
     126: note2<= 8'd0;
     127: note2<= 8'd0;
     //129: note<= 8'd0;
     
      128: note2<= 8'd34;      //1
      129: note2<= 8'd0;        
      130: note2<= 8'd29;      //2
      131: note2<= 8'd30;      //3
      132: note2<= 8'd32;      //4
      133: note2<= 8'd0;
      134: note2<= 8'd30;      //5
      135: note2<= 8'd29;     //6
      136: note2<= 8'd27;     //7
      137: note2<= 8'd0;         
      138: note2<= 8'd27;    //8
     139: note2<= 8'd30;     //9
     140: note2<= 8'd34;     //10
     141: note2<= 8'd0;
     142: note2<= 8'd32;  //11
     143: note2<= 8'd30;  //12
     144: note2<= 8'd29;  //13
     145: note2<= 8'd0;
     146: note2<= 8'd29; //14
     147: note2<= 8'd30; //15
     148: note2<= 8'd32; //16
     149: note2<= 8'd0;
     150: note2<= 8'd34; //17
     151: note2<= 8'd0;
     152: note2<= 8'd30; //18
     153: note2<= 8'd0;
     154: note2<= 8'd27; //19
     155: note2<= 8'd0; 
     156: note2<= 8'd27; //20
     157: note2<= 8'd0; 
     158: note2<= 8'd0; 
     159: note2<= 8'd0; 
     160: note2<= 8'd0; 
     161: note2<= 8'd32;//21
     162: note2<= 8'd0;
     163: note2<= 8'd35;//22 
     164: note2<= 8'd39;//23
     165: note2<= 8'd0;
     166: note2<= 8'd37;//24
     167: note2<= 8'd35;//25
     168: note2<= 8'd34;//26
     169: note2<= 8'd0;
     170: note2<= 8'd30;//27
     171: note2<= 8'd0;
     172: note2<= 8'd34;//28
     173: note2<= 8'd0;
     174: note2<= 8'd32;//29
     175: note2<= 8'd30;//30
     176: note2<= 8'd29;//31
     177: note2<= 8'd0;
     178: note2<= 8'd29;//32
     179: note2<= 8'd30;//33
     180: note2<= 8'd32;//34
     181: note2<= 8'd0;
     182: note2<= 8'd34;//35
     183: note2<= 8'd0;
     184: note2<= 8'd30;//36
     185: note2<= 8'd0;
     186: note2<= 8'd27;//37
     187: note2<= 8'd0;
     188: note2<= 8'd27;//38 
    
     189: note2<= 8'd0;
     190: note2<= 8'd0;
     191: note2<= 8'd0;
     //192: note<= 8'd0;
     
      192: note2<= 8'd34;      //1
      193: note2<= 8'd0;        
      194: note2<= 8'd29;      //2
      195: note2<= 8'd30;      //3
      196: note2<= 8'd32;      //4
      197: note2<= 8'd0;
      198: note2<= 8'd30;      //5
      199: note2<= 8'd29;     //6
      200: note2<= 8'd27;     //7
      201: note2<= 8'd0;         
      202: note2<= 8'd27;    //8
     203: note2<= 8'd30;     //9
     204: note2<= 8'd34;     //10
     205: note2<= 8'd0;
     206: note2<= 8'd32;  //11
     207: note2<= 8'd30;  //12
     208: note2<= 8'd29;  //13
     209: note2<= 8'd0;
     210: note2<= 8'd29; //14
     211: note2<= 8'd30; //15
     212: note2<= 8'd32; //16
     213: note2<= 8'd0;
     214: note2<= 8'd34; //17
     215: note2<= 8'd0;
     216: note2<= 8'd30; //18
     217: note2<= 8'd0;
     218: note2<= 8'd27; //19
     219: note2<= 8'd0; 
     220: note2<= 8'd27; //20
     221: note2<= 8'd0; 
     222: note2<= 8'd0; 
     223: note2<= 8'd0; 
     224: note2<= 8'd0; 
     225: note2<= 8'd32;//21
     226: note2<= 8'd0;
     227: note2<= 8'd35;//22 
     228: note2<= 8'd39;//23
     229: note2<= 8'd0;
     230: note2<= 8'd37;//24
     231: note2<= 8'd35;//25
     232: note2<= 8'd34;//26
     233: note2<= 8'd0;
     234: note2<= 8'd30;//27
     235: note2<= 8'd0;
     236: note2<= 8'd34;//28
     237: note2<= 8'd0;
     238: note2<= 8'd32;//29
     239: note2<= 8'd30;//30
     240: note2<= 8'd29;//31
     241: note2<= 8'd0;
     242: note2<= 8'd29;//32
     243: note2<= 8'd30;//33
     244: note2<= 8'd32;//34
     245: note2<= 8'd0;
     246: note2<= 8'd34;//35
     247: note2<= 8'd0;
     248: note2<= 8'd30;//36
     249: note2<= 8'd0;
     250: note2<= 8'd27;//37
     251: note2<= 8'd0;
     252: note2<= 8'd27;//38 
     253: note2<= 8'd0;
     254: note2<= 8'd0;//37
     255: note2<= 8'd0;
    default: note2 <= 8'd0;
endcase
endmodule

module music_ROM(
	input clk,
	input [7:0] address,
	output reg [7:0] note
);
always @(posedge clk)
case(address)
	  0: note<= 8'd10;      //1
	  1: note<= 8'd22;        
	  2: note<= 8'd10;      //2
	  3: note<= 8'd22;      //3
	  4: note<= 8'd10;      //4
	  5: note<= 8'd22;
	  6: note<= 8'd10;      //5
	  7: note<= 8'd22;     //6
	  8: note<= 8'd15;     //7
	  9: note<= 8'd27;         
	  10: note<= 8'd15;    //8
	 11: note<= 8'd27;     //9
	 12: note<= 8'd15;     //10
	 13: note<= 8'd27;
	 14: note<= 8'd15;  //11
	 15: note<= 8'd27;  //12
	 16: note<= 8'd14;  //13
	 17: note<= 8'd26;
	 18: note<= 8'd14; //14
	 19: note<= 8'd26; //15
	 20: note<= 8'd14; //16
	 21: note<= 8'd26;
	 22: note<= 8'd10; //17
	 23: note<= 8'd22;
	 24: note<= 8'd10; //18
	 25: note<= 8'd22;
	 26: note<= 8'd10; //19
     27: note<= 8'd22; 
	 28: note<= 8'd10; //20
	 29: note<= 8'd22; 
	 30: note<= 8'd10; 
	 31: note<= 8'd22; 
	 32: note<= 8'd10; 
	 
	 33: note<= 8'd8;//21
	 34: note<= 8'd20;
	 35: note<= 8'd8;//22 
	 36: note<= 8'd20;//23
	 37: note<= 8'd8;
	 38: note<= 8'd20;//24
	 39: note<= 8'd8;//25
	 40: note<= 8'd20;//26
	 41: note<= 8'd6;
	 42: note<= 8'd18; //27   
	 43: note<= 8'd6; 
	 44: note<= 8'd18;//28
	 45: note<= 8'd6;
	 46: note<= 8'd18;//29
	 47: note<= 8'd6;//30
	 48: note<= 8'd18;//31
	 49: note<= 8'd5;
	 50: note<= 8'd17;//32
	 51: note<= 8'd5;//33
	 52: note<= 8'd17;//34
	 53: note<= 8'd5;
	 54: note<= 8'd17;//35
	 55: note<= 8'd5;
     56: note<= 8'd17;//36
     57: note<= 8'd10;
     58: note<= 8'd22;//37
     59: note<= 8'd10;
     60: note<= 8'd22;//38 
     
     61: note<= 8'd10;
     62: note<= 8'd22;
     63: note<= 8'd10;
     //64: note<= 8'd0;
     
	  64: note<= 8'd10;      //1
     65: note<= 8'd22;        
     66: note<= 8'd10;      //2
     67: note<= 8'd22;      //3
     68: note<= 8'd10;      //4
     69: note<= 8'd22;
     70: note<= 8'd10;      //5
     71: note<= 8'd22;     //6
     72: note<= 8'd15;     //7
     73: note<= 8'd27;         
     74: note<= 8'd15;    //8
    75: note<= 8'd27;     //9
    76: note<= 8'd15;     //10
    77: note<= 8'd27;
    78: note<= 8'd15;  //11
    79: note<= 8'd27;  //12
    80: note<= 8'd14;  //13
    81: note<= 8'd26;
    82: note<= 8'd14; //14
    83: note<= 8'd26; //15
    84: note<= 8'd14; //16
    85: note<= 8'd26;
    86: note<= 8'd10; //17
    87: note<= 8'd22;
    88: note<= 8'd10; //18
    89: note<= 8'd22;
    90: note<= 8'd10; //19
    91: note<= 8'd22; 
    92: note<= 8'd10; //20
    93: note<= 8'd22; 
    94: note<= 8'd10; 
    95: note<= 8'd22; 
    96: note<= 8'd10; 
    
    97: note<= 8'd8;//21
    98: note<= 8'd20;
    99: note<= 8'd8;//22 
    100: note<= 8'd20;//23
    101: note<= 8'd8;
    102: note<= 8'd20;//24
    103: note<= 8'd8;//25
    104: note<= 8'd20;//26
    105: note<= 8'd6;
    106: note<= 8'd18; //27   
    107: note<= 8'd6; 
    108: note<= 8'd18;//28
    109: note<= 8'd6;
    110: note<= 8'd18;//29
    111: note<= 8'd6;//30
    112: note<= 8'd18;//31
    113: note<= 8'd5;
    114: note<= 8'd17;//32
    115: note<= 8'd5;//33
    116: note<= 8'd17;//34
    117: note<= 8'd5;
    118: note<= 8'd17;//35
    119: note<= 8'd5;
    120: note<= 8'd17;//36
    121: note<= 8'd10;
    122: note<= 8'd22;//37
    123: note<= 8'd10;
    124: note<= 8'd22;//38 
    
    125: note<= 8'd10;
    126: note<= 8'd22;
    127: note<= 8'd10;
    //64: note<= 8'd0;
     
      128: note<= 8'd10;      //1
      129: note<= 8'd22;        
      130: note<= 8'd10;      //2
      131: note<= 8'd22;      //3
      132: note<= 8'd10;      //4
      133: note<= 8'd22;
      134: note<= 8'd10;      //5
      135: note<= 8'd22;     //6
      136: note<= 8'd15;     //7
      137: note<= 8'd27;         
      138: note<= 8'd15;    //8
     139: note<= 8'd27;     //9
     140: note<= 8'd15;     //10
     141: note<= 8'd27;
     142: note<= 8'd15;  //11
     143: note<= 8'd27;  //12
     144: note<= 8'd14;  //13
     145: note<= 8'd26;
     146: note<= 8'd14; //14
     147: note<= 8'd26; //15
     148: note<= 8'd14; //16
     149: note<= 8'd26;
     150: note<= 8'd14; //17
     151: note<= 8'd26;
     152: note<= 8'd10; //18
     153: note<= 8'd22;
     154: note<= 8'd10; //19
     155: note<= 8'd22; 
     156: note<= 8'd10; //20
     157: note<= 8'd22; 
     158: note<= 8'd10; 
     159: note<= 8'd22; 
     160: note<= 8'd10; 
     161: note<= 8'd8;//21
     162: note<= 8'd20;
     163: note<= 8'd8;//22 
     164: note<= 8'd20;//23
     165: note<= 8'd8;
     166: note<= 8'd20;//24
     167: note<= 8'd8;//25
     168: note<= 8'd20;//26
     169: note<= 8'd6;
     170: note<= 8'd18;//27
     171: note<= 8'd6;
     172: note<= 8'd18;//28
     173: note<= 8'd6;
     174: note<= 8'd18;//29
     175: note<= 8'd6;//30
     176: note<= 8'd18;//31
     177: note<= 8'd5;
     178: note<= 8'd17;//32
     179: note<= 8'd5;//33
     180: note<= 8'd17;//34
     181: note<= 8'd5;
     182: note<= 8'd17;//35
     183: note<= 8'd5;
     184: note<= 8'd17;//36
     185: note<= 8'd10;
     186: note<= 8'd22;//37
     187: note<= 8'd10;
     188: note<= 8'd22;//38 
    
     189: note<= 8'd10;
     190: note<= 8'd22;
     191: note<= 8'd10;
     //192: note<= 8'd0;
     
      192: note<= 8'd10;      //1
      193: note<= 8'd22;        
      194: note<= 8'd10;      //2
      195: note<= 8'd22;      //3
      196: note<= 8'd10;      //4
      197: note<= 8'd22;
      198: note<= 8'd10;      //5
      199: note<= 8'd22;     //6
      200: note<= 8'd15;     //7
      201: note<= 8'd27;         
      202: note<= 8'd15;    //8
     203: note<= 8'd27;     //9
     204: note<= 8'd15;     //10
     205: note<= 8'd27;
     206: note<= 8'd15;  //11
     207: note<= 8'd27;  //12
     208: note<= 8'd14;  //13
     209: note<= 8'd26;
     210: note<= 8'd14; //14
     211: note<= 8'd26; //15
     212: note<= 8'd14; //16
     213: note<= 8'd26;
     214: note<= 8'd14; //17
     215: note<= 8'd10;
     216: note<= 8'd22; //18
     217: note<= 8'd10;
     218: note<= 8'd22; //19
     219: note<= 8'd10; 
     220: note<= 8'd22; //20
     221: note<= 8'd10; 
     222: note<= 8'd22; 
     223: note<= 8'd10; 
     224: note<= 8'd22; 
     225: note<= 8'd8;//21
     226: note<= 8'd20;
     227: note<= 8'd8;//22 
     228: note<= 8'd20;//23
     229: note<= 8'd8;
     230: note<= 8'd20;//24
     231: note<= 8'd8;//25
     232: note<= 8'd20;//26
     233: note<= 8'd6;
     234: note<= 8'd18;//27
     235: note<= 8'd6;
     236: note<= 8'd18;//28
     237: note<= 8'd6;
     238: note<= 8'd18;//29
     239: note<= 8'd6;//30
     240: note<= 8'd18;//31
     241: note<= 8'd5;
     242: note<= 8'd17;//32
     243: note<= 8'd5;//33
     244: note<= 8'd17;//34
     245: note<= 8'd5;
     246: note<= 8'd17;//35
     247: note<= 8'd5;
     248: note<= 8'd17;//36
     249: note<= 8'd10;
     250: note<= 8'd22;//37
     251: note<= 8'd10;
     252: note<= 8'd22;//38 
     253: note<= 8'd10;
     254: note<= 8'd22;//37
     255: note<= 8'd10;
    default: note <= 8'd0;
endcase
endmodule

