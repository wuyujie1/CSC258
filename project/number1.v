module numberFSM(CLOCK_50, SW, KEY,
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input   [9:0]   SW;
	input [0:0] KEY;

	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	reg [7:0] x;
	reg [6:0] y;
	reg [2:0] c;
	reg [3:0] g;
	reg [3:0] s;
	reg [3:0] b;
	reg [3:0] ten;
	reg [6:0] hundred;
	reg [3:0] count;
	reg [1:0] index;
	reg [27:0] myclock;
	wire [7:0] xg;
	wire [6:0] yg;
	wire [2:0] cg;
	wire [7:0] xs;
	wire [6:0] ys;
	wire [2:0] cs;
	wire [7:0] xb;
	wire [6:0] yb;
	wire [2:0] cb;
	
	vga_adapter VGA(
			.resetn(KEY[0]),
			.clock(CLOCK_50),
			.colour(c),
			.x(x),
			.y(y),
			.plot(1),
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
	/*	
	always @(posedge CLOCK_50)
		begin
		if (SW[8] == 1'b1)
			myclock <= 0;
		else
			begin
				if (myclock == 28'b0001011111010111100000111111)
					myclock <= 0;
				else
					myclock <= myclock + 1'b1;
			end
		end
					
	always @(posedge CLOCK_50)
		begin
			if (SW[8] == 1'b1)
				g <= 0;
			else if (myclock == 28'b0001011111010111100000111111)
				begin
					if (g == 4'b1001)
						g <= 0;
					else
						g <= g + 1'b1;
				end
		end
		
	always @(posedge CLOCK_50)
		begin
			if (SW[8] == 1'b1)
				ten <= 0;
			else if (myclock == 28'b0001011111010111100000111111 & g == 4'b1001)
				begin
					if (ten == 4'b1001)
						ten <= 0;
					else
						ten <= ten + 1'b1;
				end
		end
		
	always @(posedge CLOCK_50)
		begin
			if (SW[8] == 1'b1)
				hundred <= 0;
			else if (myclock == 28'b0001011111010111100000111111 & ten == 4'b1001)
				begin
					if (hundred == 7'b1100011)
						hundred <= 0;
					else
						hundred <= hundred + 1'b1;
				end
		end
		
	always @(posedge CLOCK_50)
		begin
			if (SW[8] == 1'b1)
				s <= 0;
			else if (g == 4'b0000)
				begin
					if (s == 4'b1001)
						s <= 0;
					else
						s <= s + 1'b1;
				end
		end
		
	always @(posedge CLOCK_50)
		begin
			if (SW[8] == 1'b1)
				b <= 0;
			else if (s == 4'b0000)
				begin
					if (b == 4'b1001)
						b <= 0;
					else
						b <= b + 1'b1;
				end
		end
		*/
		score1 s1(CLOCK_50, resetn, SW[0], x, y, c);
endmodule

module score1(clock, reset_n, scoreReset, xout, yout, cout);
	input clock, reset_n, scoreReset;
	reg [3:0] count;
	reg [1:0] index;
	reg [7:0] x;
	reg [6:0] y;
	reg [2:0] c;
	wire [7:0] xg;
	wire [6:0] yg;
	wire [2:0] cg;
	wire [7:0] xs;
	wire [6:0] ys;
	wire [2:0] cs;
	wire [7:0] xb;
	wire [6:0] yb;
	wire [2:0] cb;
	output reg [7:0] xout;
	output reg [6:0] yout;
	output reg [2:0] cout;
	
	always @(posedge clock)
		begin
			if (scoreReset == 1'b1)
				count <= 0;
			else
				begin
					if (count == 4'b1111)
						count <= 0;
					else
						count <= count + 1'b1;
				end
		end

	always @(posedge clock)
		begin
			if (scoreReset == 1'b1)
				index <= 0;
			else if(count == 4'b1111)
				begin
					if (index == 2'b10)
						index <= 0;
					else
						index <= index + 1'b1;
				end
		end		

	number1 n0(
				.xout(xb), 
				.yout(yb), 
				.cout(cb), 
				.num(3'd3), 
				.xin(7'b0001111), 
				.yin(7'b0001111), 
				.cin(3'b111), 
				.clk(clock), 
				.reset_n(scoreReset)
				);
				
	number1 n1(
				.xout(xs), 
				.yout(ys), 
				.cout(cs), 
				.num(3'd3), 
				.xin(7'b0010011), 
				.yin(7'b0001111), 
				.cin(3'b111), 
				.clk(clock), 
				.reset_n(scoreReset)
				);
				
	number1 n2(
				.xout(xg), 
				.yout(yg), 
				.cout(cg), 
				.num(3'd3), 
				.xin(7'b0010111), 
				.yin(7'b0001111), 
				.cin(3'b111), 
				.clk(clock), 
				.reset_n(scoreReset)
				);
				
			
	always @(*)
		begin
		xout = 0;
		yout = 0;
		cout = 0;
			case(index)
				0: begin
					xout = xb;
					yout = yb;
					cout = cb;
					end
				1: begin
					xout = xs;
					yout = ys;
					cout = cs;
					end
				2: begin
					xout = xg;
					yout = yg;
					cout = cg;
					end
			endcase
		end
endmodule


module number1(xout, yout, cout, num, xin, yin, cin, clk, reset_n);
	input [6:0] xin, yin;
	input [2:0] cin;
	input [3:0] num;
	input clk, reset_n;
	output [7:0] xout;
	output [6:0] yout;
	output [2:0] cout;
	wire [14:0] list;
	
	hex1 h0(
			.list(list), 
			.num(num)
			);
			
	single1 s0(
				.xout(xout), 
				.yout(yout), 
				.cout(cout), 
				.xin(xin), 
				.yin(yin), 
				.cin(cin), 
				.clk(clk), 
				.reset_n(reset_n), 
				.list(list)
				);
endmodule


module hex1(list, num);
	input [3:0] num;
	output reg [14:0] list;
	
	always @(*)
		begin
			case(num)
				0: list <= 15'b111101101101111;
				1: list <= 15'b010010010010010;
				2: list <= 15'b111001111100111;
				3: list <= 15'b111001111001111;
				4: list <= 15'b101101111001001;
				5: list <= 15'b111100111001111;
				6: list <= 15'b111100111101111;
				7: list <= 15'b111001001001001;
				8: list <= 15'b111101111101111;
				9: list <= 15'b111101111001111;
				default: list <= 15'b000000000000000;
			endcase
		end
endmodule
	
module single1(xout, yout, cout, xin, yin, cin, clk, reset_n, list);
	input [6:0] xin, yin;
	input [2:0] cin;
	input [0:14] list;
	input clk, reset_n;
	output [7:0] xout;
	output [6:0] yout;
	output reg [2:0] cout;
	wire [7:0] xtemp;
	wire enable_y;
	reg [1:0] xindex;
	reg [2:0] yindex;
	reg [3:0] counter;
	
	always @(posedge clk)
		begin
			if (reset_n == 1'b1)
				counter <= 0;
			else
				begin
					if (counter == 4'b1110)
						counter <= 0;
					else
						counter <= counter + 1'b1;
				end
		end
	
	assign xtemp = {1'b0, xin};
	always @(posedge clk)
		begin
			if (reset_n == 1'b1)
				xindex <= 0;
			else
				begin
					if (xindex == 2'b10)
						xindex <= 0;
					else
						xindex <= xindex + 1'b1;
				end
		end
	assign xout = xtemp + xindex;
	
	assign enable_y = (xindex == 2'b10) ? 1'b1 : 1'b0;
	
	always @(posedge clk)
		begin
			if (reset_n == 1'b1)
				yindex <= 0;
			else if (enable_y == 1'b1)
				begin
					if (yindex == 3'b100)
						yindex <= 0;
					else
						yindex <= yindex + 1'b1;
				end
		end
	assign yout = yin + yindex;
	
	always @(*)
		begin
			if (reset_n == 1'b1 | list[counter] == 1'b0)
				cout[2:0] = 3'b000;
			else
				cout[2:0] = cin;
		end
endmodule