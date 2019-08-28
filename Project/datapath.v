module datapath(input clock, ld_page, ld_S_matrix, ld_L_matrix, ld_plot, go, end_game,
                input [1:0] ld_move, input [3:0] ld_number,
					 output reg [2:0] colour, output Check, output reg [7:0] x_temp,
					 output reg [6:0] y_temp);

	 //check will check the validity
    assign Check = 1'b0;				
	
	
	 //Choose colour
	 wire [2:0] c1, c2, c3; //colour for page, s_matrix, l_matrix
	 wire [2:0] col1, col2, col3, col4, col5, col6, col7, col8, col9; //colour for numbers
    
	 always@(posedge clock)
	  begin
	      case(ld_number[3:0])
			
			4'b0000: colour = col1; //1
			4'b0001: colour = col2; //2 
			4'b0010: colour = col3; //3
			4'b0011: colour = col4; //4
         4'b0100: colour = col5; //5
         4'b0101: colour = col6; //6
			4'b0110: colour = col7; //7
			4'b0111: colour = col8; //8
			4'b1000: colour = col9; //9
			4'b1001: colour = c1;   //page
			4'b1010: colour = c2;   //s_matrix
			4'b1011: colour = c3;   //l_matrix
			default: colour = c1;

			endcase
		end
		
	  //fullscreen
	  reg[7:0] x_page, x_s, x_l, count_x;
     reg [6:0] y_page, y_s, y_l, count_y;
	  reg prep_done, done, donel, doneN;
	  wire [15:0] address_page, address_s, address_l;

	  initial prep_done = 0;
	  initial done = 0;
	  initial donel = 0;
	  initial doneN = 0;
	  
	  initial x_page = 8'd0;
	  initial y_page = 7'd0;
	  initial x_s = 8'd0;
	  initial y_s = 7'd0;
	  initial x_l = 8'd0;
	  initial y_l = 7'd0;
     initial count_x = 8'd0;
	  initial count_y = 7'd0;
	  
	  //numbers
	  reg [7:0] x_number;
	  reg [6:0] y_number;
	  initial x_number = 8'd0;
	  initial y_number = 7'd0;
							 
	always@(posedge clock)
	  begin 
	  if(end_game == 1'b1)
	   begin
		  prep_done <= 0;
	     done <= 0;
	     donel <= 0;
		  doneN <= 0;
	     x_page <= 0;
	     y_page <= 0;
	     x_s <= 0;
	     y_s <= 0;
	     x_l <= 0;
	     y_l <= 0;
		  count_x <= 0;
		  count_y <= 0;
		  x_number <= 0;
		  y_number <= 0;
		end

		else
		 begin
				 if(ld_page == 1'b1)
					 begin
						if(prep_done == 0)
						  begin
						       if((x_page == 8'd159) && (y_page == 7'd119))
									begin 
									 prep_done <= 1'b1;
									end
								 else if(x_page == 8'd159) //160
									begin 
										y_page <= y_page + 1;
										x_page <= 0;
									end
								 else
									begin
										x_page <= x_page + 1;
									end
								 x_temp <= x_page;
								 y_temp <= y_page;
						  end  
					 end
			 
			    if(ld_S_matrix == 1'b1)
					begin
						if(done == 0)
						  begin
						       if((x_s == 8'd159) && (y_s == 7'd119))
									begin 
									 done <= 1'b1;
									end
								 else if(x_s == 8'd159) //160
									begin 
										y_s <= y_s + 1;
										x_s <= 0;
									end
								 else
									begin
										x_s <= x_s + 1;
									end
								 x_temp <= x_s;
								 y_temp <= y_s;
						  end
						  x_number <= 8'd30;
	                 y_number <= 7'd10;
					 end
				 
			  if(ld_L_matrix == 1'b1)
				 begin
						if(donel == 0)
						  begin
						       if((x_l == 8'd159) && (y_l == 7'd119))
									begin 
									 donel <= 1'b1;
									end
								 else if(x_l == 8'd159) //160
									begin 
										y_l <= y_l + 1;
										x_l <= 0;
									end
								 else
									begin
										x_l <= x_l + 1;
									end
								 x_temp <= x_l;
								 y_temp <= y_l;
								 
						  end
						  x_number <= 8'd30;
	                 y_number <= 7'd10;
				 end
				 
		   if(ld_plot == 1'b1 && ld_move == 2'b00 && go == 1'b0) //DOWN
			  begin
				 count_y <= 7'd0;
				 count_x <= 8'd0;
				 x_number <= x_number; //new position
				 y_number <= y_number + 7'd11;
			  end
			if(ld_plot == 1'b1 && ld_move == 2'b01 && go == 1'b0) //UP
		     begin 
				 count_y <= 7'd0;
				 count_x <= 8'd0;
				 x_number <= x_number; //new position
				 y_number <= y_number - 7'd11;
			  end  
			if(ld_plot == 1'b1 && ld_move == 2'b10 && go == 1'b0) //LEFT
			  begin 
				 count_y <= 7'd0;
				 count_x <= 8'd0;
				 x_number <= x_number - 8'd11; //new position
				 y_number <= y_number;
			  end
			if(ld_plot == 1'b1 && ld_move == 2'b11 && go == 1'b0) //RIGHT
			  begin
				 count_y <= 7'd0;
				 count_x <= 8'd0;
				 x_number <= x_number + 8'd11; //new position
				 y_number <= y_number;
			  end
			  
			  
		  if(ld_plot == 1'b1 && go == 1'b1)
		   begin
			  if(doneN == 0)
				  begin
				       if(count_x == 8'd10 && count_y == 7'd10)
						   begin
							   doneN <= 1;
							end
						 else if(count_x == 8'd10) //8'11 
							begin 
								count_y <= count_y + 1;
								count_x <= 0;
							end
						 else
   						begin
							   count_x <= count_x + 1;
							end
						 x_temp <= x_number + count_x; // position + count for the screen
						 y_temp <= y_number + count_y; 
						 
					 end
			end  

		 end
		 
     end
	  
	  
      
		wire [14:0] title;
		vga_address_translator t1(.x(x_page), .y(y_page), .mem_address(title));
	   titleMemory T(.address(title), .clock(clock), .data(3'b0), .wren(1'b0), .q(c1));
		
		
		wire [14:0] easy_m;
		vga_address_translator t2(.x(x_s), .y(y_s), .mem_address(easy_m));
      easy_grid EG(.address(easy_m), .clock(clock), .data(3'b0), .wren(1'b0), .q(c2));
		
		
		wire [14:0] hard_m;
		vga_address_translator t3(.x(x_l), .y(y_l), .mem_address(hard_m));
      hard_grid HG(.address(hard_m), .clock(clock), .data(3'b0), .wren(1'b0), .q(c3));
	  
	  
endmodule			


	  

