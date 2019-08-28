module fill
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
		SW,
		KEY,	
      HEX0,
      HEX1,
      LEDR,	// On Board Keys
		PS2_CLK,
	   PS2_DAT,
		// The ports below are for the VGA output.  Do not change.
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
	input	[3:0]	KEY;	
   input [9:0] SW;
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [4:0] LEDR;
	
	inout	PS2_CLK;
   inout	PS2_DAT;
	
	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	
	wire resetn;
	assign resetn = !KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.

	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
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
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.
	
	//FSM	
   FSM F(.Clock(CLOCK_50), .Start(SW[0]) , .End_Game(!KEY[0]), .GoDraw(SW[2]), .GoEasy(SW[3]), .GoDifficult(SW[4]),
         .Plot(data_received), .clr(colour), .enable(writeEn), .X(x), .Y(y), .Go(SW[9]),
			.page(LEDR[0]), .smatrix(LEDR[1]), .lmatrix(LEDR[2]), .plot_signal(LEDR[3]), .chk(LEDR[4])); //data_received needs to enter here

	//KEYBOARD
	wire [7:0] data_received;
   PS2_Demo KEYBOARD( .clock(CLOCK_50), .key(KEY[3:0]),	.PS2_CLK(PS2_CLK), .PS2_DAT(PS2_DAT), 
	 .hex0(HEX0[6:0]), .hex1(HEX1[6:0]), .last_data_received(data_received));

endmodule
