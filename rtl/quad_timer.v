
`default_nettype none
module quad_timer(
    input wire          i_clk,
    input  wire [31:0]  i_wb_addr,
    input wire [31:0]   i_wb_dat,
    input wire 	        i_wb_we,
    input wire 	        i_wb_cyc,
    output reg [31:0]   o_wb_dat,
    output reg          o_wb_ack,
    output reg 	        o_irq);

parameter timer_divider= 16'd200;

   reg [31:0]  value;
   reg [31:0]  compare;
   reg [31:0]  status;
   reg [15:0]  divider_cnt;

   
    initial begin
        status = 0;
        value = 0;
        compare = 0;
        o_irq =0;
        o_wb_dat = 0;
        divider_cnt = 0;
    end

    localparam TIME_REG     =8'h0;
    localparam CMP_REG      =8'h4;
    localparam STATUS_REG   =8'h8;

  always @(posedge i_clk)
     o_wb_ack <= i_wb_cyc & !o_wb_ack;

   always @(posedge i_clk) begin

        /* write */
    if (i_wb_cyc & i_wb_we & !o_wb_ack) begin
        case (i_wb_addr[7:0])
            TIME_REG:   value <= i_wb_dat;
            CMP_REG:    compare <= i_wb_dat;
            STATUS_REG: status <= i_wb_dat;
        default:
            value <= value;
        endcase

      end
    else if (i_wb_cyc & !o_wb_ack) begin
        case (i_wb_addr[7:0])
            TIME_REG:   o_wb_dat <= value; 
            CMP_REG:    o_wb_dat <= compare;
            STATUS_REG: o_wb_dat <= status;
        default:
            o_wb_dat <= value;
        endcase
    end
    else begin
        if (status[0]) begin

            // slow the count to 1us
            if (divider_cnt == timer_divider) begin
                value <= value + 1;
                divider_cnt <= 0;
            end
            else
                divider_cnt <= divider_cnt + 1'b1;
        end

        if ( value == compare && (status[1:0] == 2'b11)) begin
            value <= 0; //reload
            o_irq <= 1;
        end
        else
            o_irq <= 0;
    end
   end

endmodule
//eof