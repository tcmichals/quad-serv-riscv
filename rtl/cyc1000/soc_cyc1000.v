
`default_nettype none
module soc_cyc1000(input wire CLK12M,
				   input wire USR_BTN,
					  output wire [7:0]LED,
            input wire BDBUS2,   //FSDO 
					  input wire BDBUS3,    //FSCTS
            output wire BDBUS0,   //FSDI
						output wire BDBUS1,  //FSCLK

            output wire D2,
            output wire D3,
            output wire D4,
            output wire D5
             );
parameter firmware = "exampleLED.hex";
parameter romsize = (1024 * 8);
parameter ramsize = (1024 * 8);

assign D2 = BDBUS2;
assign D3 = BDBUS3;
assign D4 = BDBUS0;
assign D5 = BDBUS1;
	/*USR_BTN is HIGH until pressed */
	wire wb_clk;
	wire pll_locked;
	reg  [9:0]pll_settle;
	wire wb_rst;

	assign wb_rst = pll_settle[9];

	
	PLL12M pll(.areset(~USR_BTN),
			  .inclk0(CLK12M),
			  .c0(wb_clk),
			  .locked(pll_locked));
			  
			  
always @(posedge wb_clk) begin
     if (pll_locked)
       pll_settle <= {pll_settle[8:0],1'b0};
     else
       pll_settle <= 10'b1111111111;  
end

quadsoc #(.rom_file(firmware),
       .rom_file_size(romsize),
       .ram_size (ramsize))
    soc (.wb_clk (wb_clk),
        .wb_rst (wb_rst),
        .o_gpio(LED),
        .o_debug_strobe(),
        .pll_lockedo_debug_port(),
        .i_fsdo(BDBUS2),
        .i_fscts(BDBUS3),
        .o_fsclk(BDBUS1),
        .o_fsdi(BDBUS0),
        .o_pc());


endmodule
//eof
