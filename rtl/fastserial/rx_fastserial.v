

module rx_fastserial(input wire  i_clk, 		//FPGA Clock, atleast 100Mhz
                     input wire i_fsdo, 		//No faster then 50Mhz
		     		 input wire i_fsclk,		// IF TX is busy
                     output wire [7:0] o_data, 	// Data to RX
                     output wire o_ready);  	// RX byte

localparam [3:0]   WAIT_FOR_START_BIT	= 4'h0,
	                BIT_ZERO	    		= 4'h1,
	                BIT_ONE		    		= 4'h2,
	                BIT_TWO	        		= 4'h3,
	                BIT_THREE	    		= 4'h4,
                   	BIT_FOUR       			= 4'h5,
	                BIT_FIVE	    		= 4'h6,
	                BIT_SIX		    		= 4'h7,
	                BIT_SEVEN	    		= 4'h8,
	                BIT_DEST	    		= 4'h9,
                   	DONE           			= 4'hA,
				   	CLEAN_UP				= 4'hB,
	                IDLE		    		= 4'hf;

reg [3:0] state;
reg [7:0] rx_data;
reg [9:0] debug_data;
reg rx_ready;
reg[1:0] q_fsdo, d_fsdo;
reg   		wait_clk;

initial begin 
	state = WAIT_FOR_START_BIT;
	rx_ready = 0;
	q_fsdo = 1;
	d_fsdo =1;
	wait_clk = 0;
end

always @(*) begin
	d_fsdo[0] = i_fsdo;
	d_fsdo[1] = q_fsdo[0];
end



always @(posedge i_clk) begin
		//dual FF 
	q_fsdo <= d_fsdo;

	if (~i_fsclk && wait_clk)
    	wait_clk <=0;

	case (state)
		WAIT_FOR_START_BIT: begin
			if ((q_fsdo[1] == 0) & i_fsclk & ~wait_clk) begin
				state <= BIT_ZERO;
				wait_clk <= 1;
				debug_data <= 10'b0;
			end
		end
			
		BIT_DEST: begin
			if (i_fsclk & ~wait_clk) begin
				state <= state + 1'b1;
				wait_clk <= 1;
				debug_data <= {debug_data[8:0], 1'b1};
			end
		end

		DONE: begin
			state <= state +1;
			rx_ready <= 1;
		end

		CLEAN_UP: begin
			state <= WAIT_FOR_START_BIT;
			rx_ready <= 0;
			rx_data <= 0;
			
		end

		default: begin
			if ((state >= BIT_ZERO && state <= BIT_SEVEN) & i_fsclk & ~wait_clk) begin
				state <= state + 1'b1;
				{rx_data}<= {q_fsdo[1] , rx_data[7:1]};
				wait_clk <= 1;
				debug_data <= {debug_data[8:0], 1'b1};
			end
		end
			
	endcase

end

assign o_ready = rx_ready;
assign o_data = rx_data;


endmodule
//eof
