
module PS2_Demo (
	// Inputs
	input clock, input [3:0] key,

	// Bidirectionals
	inout PS2_CLK,	PS2_DAT,
	
	// Outputs
	output [6:0] hex0, hex1,
	output reg	[7:0]	last_data_received
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/

// Inputs

// Bidirectionals


// Outputs



/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************
 ************************/

// Internal Wires
	
wire	ps2_key_pressed;

// Internal Registers
wire	[7:0]	ps2_key_data;

// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/

always @(posedge clock)
begin
	if (key[0] == 1'b0)
		last_data_received <= 8'h00;
	else if (ps2_key_pressed == 1'b1)
		last_data_received <= ps2_key_data;
end

/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

PS2_Controller PS2 (
	// Inputs
	.CLOCK_50				(clock),
	.reset				(~key[0]),
	
	// Bidirectionals
	.PS2_CLK			(PS2_CLK),
 	.PS2_DAT			(PS2_DAT),

	// Outputs
	.received_data		(ps2_key_data),
	.received_data_en	(ps2_key_pressed)
);

Hexadecimal_To_Seven_Segment Segment0 (
	// Inputs
	.hex_number			(last_data_received[3:0]),

	// Bidirectional

	// Outputs
	.seven_seg_display	(hex0)
);

Hexadecimal_To_Seven_Segment Segment1 (
	// Inputs
	.hex_number			(last_data_received[7:4]),

	// Bidirectional

	// Outputs
	.seven_seg_display	(hex1)
);


endmodule
