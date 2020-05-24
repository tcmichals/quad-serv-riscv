`default_nettype none
`timescale 1 ns/10 ps  // time-unit = 1 us, precision = 10 ps

module fast_serial_timer_tb;

    reg clk=0;
    wire o_fsclk;
    wire o_negdge_fsclk;
    reg [4:0]state = 0;
    reg wait_clk=0;

    clock_fastserial UUT( .i_clk(clk),
                    .o_fsclk(o_fsclk));
                    
                 
    always begin
        #1 clk =!clk;
    end

initial begin
    $dumpfile("fast_serial_timer_tb.vcd");
    $dumpvars(0,fast_serial_timer_tb);

    #500;

    


    #10 $finish;
end

always @(posedge clk) begin
        if (~o_fsclk && wait_clk)
            wait_clk <=0;
end
always @(posedge clk) begin

    if (o_fsclk && ~wait_clk) begin
        case (state)
        0: state <= state+ 1;
        1: state <= state+ 1;
        2: state <= state+ 1;
        3: state <= state+ 1;
        4: state <= state+ 1;
        default:
            state <= 0;
        endcase
        wait_clk <= 1;
    
    end	 
end




endmodule