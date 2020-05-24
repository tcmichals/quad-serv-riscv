`default_nettype none
module quad_gpio(
    input wire          i_clk,
    input      [31:0]   i_wb_addr,
    input wire [31:0]   i_wb_dat,
    input wire 	        i_wb_we,
    input wire 	        i_wb_cyc,
    output reg [31:0]   o_wb_dat,
    output reg          o_wb_ack,
    output reg [7:0]    o_gpio);
  
    initial begin
        o_gpio = 0;
    end

    localparam REG          =8'h0;
    localparam SET_REG      =8'h4;
    localparam CLEAR_REG    =8'h8;
    localparam TOGGLE_REG   =8'hC;

   always @(posedge i_clk)
     o_wb_ack <= i_wb_cyc & !o_wb_ack;

   always @(posedge i_clk) begin
        /* write */
    if (i_wb_cyc & i_wb_we && !o_wb_ack) begin
        case (i_wb_addr[7:0])
            REG:        o_gpio <= i_wb_dat[7:0];
            SET_REG:    o_gpio <= i_wb_dat[7:0] | o_gpio;
            CLEAR_REG:  o_gpio <= ~i_wb_dat[7:0] & o_gpio;
            TOGGLE_REG: o_gpio <= i_wb_dat[7:0] ^ o_gpio;
            default: o_gpio <= o_gpio;
        endcase

      end
    else if (i_wb_cyc) 
            o_wb_dat[7:0] <= o_gpio;
   end

endmodule
//eof