`default_nettype none
`timescale 1 ns/10 ps  // time-unit = 1 us, precision = 10 ps

module quad_timer_tb;

    reg          clk=0;
    reg [31:0]   wb_addr=0;
    reg [31:0]   wb_dat=0;
    reg 	     wb_we=0;
    reg 	     wb_cyc=0;
    wire [31:0]  wb_rdt;
    wire 	     irq;


    localparam TIME_REG     =8'h0;
    localparam CMP_REG      =8'h4;
    localparam STATUS_REG   =8'h8;
    localparam TIMEOUT_VALUE =32'hF0;
    
    quad_timer UUT( .i_clk(clk),
                    .i_wb_addr(wb_addr),
                    .i_wb_dat(wb_dat),
                    .i_wb_we(wb_we),
                    .i_wb_cyc(wb_cyc),
                    .o_wb_dat(wb_rdt),
                    .o_irq(irq));

    always begin
        #1 clk =!clk;
    end

initial begin
    $dumpfile("quad_timer_tb.vcd");
    $dumpvars(0,quad_timer_tb);

    #2  wb_addr <= CMP_REG;
        wb_dat <= TIMEOUT_VALUE;
        wb_cyc <= 1;
        wb_we <= 1;


    #2  wb_cyc <= 0;
        wb_we <= 0;


    #2  wb_addr <= STATUS_REG;
        wb_dat <= 1;
        wb_cyc <= 1;
        wb_we <= 1;
  
    #2  wb_cyc <= 0;
        wb_we <= 0;


    #500;

    #2 wb_addr <= STATUS_REG;
        wb_dat <= 0;
        wb_cyc <= 1;
        wb_we <= 1;


    #2  wb_cyc <= 0;
        wb_we <= 0;        


    #10 $finish;
end

always @(posedge clk) begin
    if (irq) begin
        $display("IRQ ");
	end

end

endmodule
//eof
