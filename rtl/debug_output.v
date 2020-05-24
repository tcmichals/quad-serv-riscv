
`default_nettype none
module debug_output(input wire i_wb_clk,
                    input wire [7:0]i_wb_dat,
                    input wire i_wb_we,
                    input wire i_wb_cyc,
                    output reg [7:0]o_wb_rdt,
                    output reg o_debug_strobe,
                    output reg [7:0] o_debug_data);



   always @(posedge i_wb_clk) begin
      o_wb_rdt <= o_debug_data;
      if (i_wb_cyc & i_wb_we) begin
	        o_debug_data <= i_wb_dat;
            o_debug_strobe <= 1;
      end
      else
        o_debug_strobe <= 0;
       
   end

endmodule
//eof
