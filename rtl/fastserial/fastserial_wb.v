
`default_nettype none
module fastserial_wb(
	    /* wishbone bus interface */
	    input wire          i_clk,
	    input  wire [31:0]  i_wb_addr,
	    input wire [31:0]   i_wb_dat,
	    input wire 	        i_wb_we,
	    input wire 	        i_wb_cyc,
	    output reg [31:0]   o_wb_dat,
	    output reg          o_wb_ack,
	
        input wire  		i_fsdo,
	    input wire 			i_fscts,
	    output  			o_fsclk,
	    output 				o_fsdi);

	parameter fast_serial_divider = 4;
	parameter fast_serial_port	= 1'd1;  // which port connected to ftdi

	localparam RX_REG   = 8'h0;
	localparam TX_REG	= 8'h4;

	localparam FIFO_DEPTH = 8;
	localparam FIFO_WIDTH = 8;

	localparam IDLE_txFIFO 		= 	2'h0,
			   READ_FIFO_txFIFO =  	2'h1,
			   WAIT_FIFO_txFIFO =  	2'h2,
			   DONE_txFIFO 		= 	2'h3;

	reg [23:0] status;
	reg	[1:0]  txState;
	
	wire reset;

	wire [7:0] rx_data_fs;
	wire	   rx_data_ready_fs;

	wire [7:0] rx_data_fifo;
	wire  		rx_data_enable_fifo;
	wire  		rx_empty_fifo;
	wire 		rx_full_fifo;

	wire   		tx_write_fs;
	wire		tx_busy_fs;

	wire 		tx_write_fifo;
	wire[7:0]	tx_fifo_data;
	wire		tx_fifo_empty;
	wire		tx_fifo_full;
	wire		tx_fifo_read;
	wire		tx_write;

	assign reset = 1'b0;


	assign rx_data_enable_fifo =  !rx_empty_fifo & i_wb_cyc & !o_wb_ack & i_wb_addr[7:0]==RX_REG;
	assign tx_write_fifo = !tx_fifo_full && i_wb_cyc & o_wb_ack & i_wb_we  & (i_wb_addr[7:0]==TX_REG);
	assign tx_fifo_read = (txState == READ_FIFO_txFIFO)?1'b1:1'b0; 
	assign tx_write_fs = (txState == WAIT_FIFO_txFIFO)?1'b1:1'b0;

	initial begin
		status = 0;
		txState = IDLE_txFIFO;
	end


	clock_fastserial #(.fast_serial_divider(fast_serial_divider))
					clock_for_fastserial(.i_clk(i_clk), 
			  						    .o_fsclk(o_fsclk));

	rx_fastserial rx_lite(.i_clk(i_clk),
  						  .i_fsdo(i_fsdo),
						  .i_fsclk(o_fsclk),
						  .o_data(rx_data_fs),
						.o_ready(rx_data_ready_fs));
					

	fifo  #(.DEPTH_WIDTH(FIFO_DEPTH),
 			.DATA_WIDTH(FIFO_WIDTH))
		rx_fifo	(.clk(i_clk),
			.rst(reset),
			.wr_data_i(rx_data_fs),
			.wr_en_i(rx_data_ready_fs & !rx_full_fifo),
			.rd_data_o(rx_data_fifo),
			.rd_en_i(rx_data_enable_fifo),
			.full_o(rx_full_fifo),
			.empty_o(rx_empty_fifo));

	tx_fastserial 
			tx_lite(.i_clk(i_clk),
				.i_fsclk(o_fsclk),
				.i_fscts(i_fscts),
				.i_data(tx_fifo_data),
				.i_write(tx_write_fs),
				.o_busy(tx_busy_fs),
				.o_fsdi(o_fsdi));			
	
	
	fifo  #(.DEPTH_WIDTH(FIFO_DEPTH),
 			.DATA_WIDTH(FIFO_WIDTH))
		tx_fifo	(.clk(i_clk),
			.rst(reset),
			.wr_data_i(i_wb_dat[7:0]),
			.wr_en_i(tx_write_fifo),
			.rd_data_o(tx_fifo_data),
			.rd_en_i(tx_fifo_read),
			.full_o(tx_fifo_full),
			.empty_o(tx_fifo_empty));
	
			
			

always @(posedge i_clk) begin
	if (!rx_data_enable_fifo)
    	o_wb_ack <= i_wb_cyc & !o_wb_ack;
 	status[0] <= !rx_empty_fifo;
	status[1] <= rx_full_fifo;
	status[4] <= tx_busy_fs;
	status[5] <= tx_fifo_full;

	case (txState)
		IDLE_txFIFO: begin
			if (!tx_busy_fs & !tx_fifo_empty) begin
				txState <= txState + 1;
			end
		end
		READ_FIFO_txFIFO: begin
			txState <= txState + 1;
		end
		WAIT_FIFO_txFIFO: begin
			txState <= txState + 1;
		end
		DONE_txFIFO: txState <= IDLE_txFIFO;
	endcase

	


end

always @(posedge i_clk) begin

    if (i_wb_cyc & !o_wb_ack & ~i_wb_we) begin
        case (i_wb_addr[7:0])
            RX_REG: o_wb_dat <= {status, rx_data_fifo};
        default:
            o_wb_dat <= {status, 8'h0};
        endcase
    end

end	


endmodule
//eof

