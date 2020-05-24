
module clock_fastserial(input wire i_clk, 
                        output wire o_fsclk)
                       ;
parameter fast_serial_divider = 4;                     

reg [15:0] counter;
initial begin
    counter = 0;
end

always @(posedge i_clk) begin
  
    counter <= counter + 1'b1;
    if (counter >=  (fast_serial_divider -1)) begin
            counter <= 0;
    end
end	 



assign o_fsclk = (counter < ((fast_serial_divider/2)))?1'b0: 1'b1;


endmodule
//eof
