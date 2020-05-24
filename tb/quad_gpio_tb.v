`default_nettype none
`timescale 1 ns/10 ps  // time-unit = 1 us, precision = 10 ps

module quad_gpio_tb;

    reg          clk=0;
    reg [31:0]   wb_addr=0;
    reg [31:0]   wb_dat=0;
    reg 	     wb_we=0;
    reg 	     wb_cyc=0;
    wire [31:0]  wb_rdt;
    wire [7:0]	 gpio;


    localparam REG          =8'h0;
    localparam SET_REG      =8'h4;
    localparam CLEAR_REG    =8'h8;
    localparam TOGGLE_REG   =8'hC;
    
    localparam GPIO_VAL = 8'hAA;

    quad_gpio UUT( .i_clk(clk),
                    .i_wb_addr(wb_addr),
                    .i_wb_dat(wb_dat),
                    .i_wb_we(wb_we),
                    .i_wb_cyc(wb_cyc),
                    .o_wb_dat(wb_rdt),
                    .o_gpio(gpio));

    always begin
        #1 clk =!clk;
    end

initial begin
    $dumpfile("quad_gpio_tb.vcd");
    $dumpvars(0,quad_gpio_tb);

    #2  wb_addr <= SET_REG;
        wb_dat <= GPIO_VAL;
        wb_cyc <= 1;
        wb_we <= 1;


    #2  wb_cyc <= 0;
        wb_we <= 0;

    #2  if (gpio == GPIO_VAL)
            $fatal(1, "GPIO is not correct value");
    
    #2  wb_addr <= TOGGLE_REG;
        wb_dat <= GPIO_VAL;
        wb_cyc <= 1;
        wb_we <= 1;


    #2  wb_cyc <= 0;
        wb_we <= 0;    

    #2  if (gpio != ~GPIO_VAL)
            $fatal(1, "GPIO is not correct value");


    #500;

    


    #10 $finish;
end

always @(posedge clk) begin


end

endmodule
//eof
