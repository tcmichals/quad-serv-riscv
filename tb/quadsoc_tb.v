`default_nettype none
module quadsoc_tb
  ( input wire  i_clk,
    input wire  i_rst,
    output wire [7:0] o_gpio,
    output wire o_debug_strobe,
    output wire [7:0] o_debug_port,
    input wire  i_fsdo,
    input wire  i_fscts,
    output wire o_fsclk,
    output wire o_fsdi,
    output wire [31:0] o_pc,
    input wire [31:0] i_debug);

    parameter romfile = "";
    parameter romsize = (1024 * 8);
    parameter ramsize = (1024 * 8);
    parameter fast_serial_divider = 200;

    reg [1023:0] firmwaretb_file;
    initial begin
      if ($value$plusargs("firmwaretb=%s", firmwaretb_file)) begin
	      $display("Loading RAM from %0s", firmwaretb_file);
	      $readmemh(firmwaretb_file, UUT.rom.mem);
      end
    end

   quadsoc #(.rom_file(romfile),
       .rom_file_size(romsize),
       .ram_size (ramsize))
   UUT(.wb_clk(i_clk), 
        .wb_rst(i_rst),
        .o_gpio(o_gpio),
        .o_debug_strobe(o_debug_strobe),
        .o_debug_port(o_debug_port),
        .i_fsdo(i_fsdo),
        .i_fscts(i_fscts),
        .o_fsclk(o_fsclk),
         .o_fsdi(o_fsdi),
        .o_pc(o_pc));


endmodule
