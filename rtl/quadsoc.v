
`default_nettype none
module quadsoc
(
 input wire  wb_clk,
 input wire  wb_rst,
 output wire [7:0] o_gpio,

output wire o_debug_strobe,
output wire [7:0] o_debug_port,
input wire  i_fsdo,
input wire  i_fscts,
output wire o_fsclk,
output wire o_fsdi,
output wire [31:0] o_pc);
 
parameter rom_file = "main.hex";
parameter rom_file_size = 8192;
parameter ram_size = 8192;
parameter fast_serial_divider = 8;

   wire 	timer_irq;

/* instruction bus is seperate */
   wire [31:0] wb_cpu_ibus_adr;
   wire [31:0] wb_cpu_ibus_dat; /* not used in CPU */  
   wire [3:0]  wb_cpu_ibus_sel; /* not used by CPU */
   wire 	     wb_cpu_ibus_cyc;
   wire        wb_cpu_ibus_we;  /* not used by CPU */
   wire [31:0] wb_cpu_ibus_rdt;  
   wire 	      wb_cpu_ibus_ack;

//TCM assign wb_cpu_ibus_dat = 32'h0;
//assign wb_cpu_ibus_sel = 4'h0;
//assign wb_cpu_ibus_we = 1'h0;

    /* data bus from processor*/
   wire [31:0] 	  wb_cpu_dbus_adr;
   wire [31:0] 	  wb_cpu_dbus_dat;
   wire [3:0] 	  wb_cpu_dbus_sel;
   wire 	        wb_cpu_dbus_we;
   wire 	        wb_cpu_dbus_cyc;
   wire [31:0] 	  wb_cpu_dbus_rdt;
   wire 	        wb_cpu_dbus_ack;

  /* ram bus from processor*/
   wire [31:0]  	wb_ram_adr;
   wire [31:0] 	  wb_ram_dat;
   wire [3:0] 	  wb_ram_sel;
   wire 	        wb_ram_we;
   wire 	        wb_ram_cyc;
   wire [31:0] 	  wb_ram_rdt;
   wire 	        wb_ram_ack;

     /* rom bus from processor*/
   wire [31:0]  	wb_rom_adr;
   wire [31:0] 	  wb_rom_dat;
   wire [3:0] 	  wb_rom_sel;
   wire 	        wb_rom_we;
   wire 	        wb_rom_cyc;
   wire [31:0] 	  wb_rom_rdt;
   wire 	        wb_rom_ack;


   /* GPIO */
   wire [31:0] 	wb_gpio_adr;
   wire [31:0] 	wb_gpio_dat;
   wire [3:0] 	wb_gpio_sel;
   wire 	    wb_gpio_we;
   wire 	    wb_gpio_cyc;
   wire [31:0] 	wb_gpio_rdt;
   wire 	    wb_gpio_ack;

   /* TIMER */
   wire [31:0] 	wb_timer_adr;
   wire [31:0] 	wb_timer_dat;
   wire [3:0] 	wb_timer_sel;
   wire 	    wb_timer_we;
   wire 	    wb_timer_cyc;
   wire [31:0] 	wb_timer_rdt;
   wire 	    wb_timer_ack;

   /* debug */
   wire [31:0] 	wb_debug_adr;
   wire [7:0] 	wb_debug_dat;
   wire [3:0] 	wb_debug_sel;
   wire 	    wb_debug_we;
   wire 	    wb_debug_cyc;
   wire [7:0] 	wb_debug_rdt;
   wire 	    wb_debug_ack;

   /* fastserial */
   wire [31:0] 	wb_fastserial_adr;
   wire [31:0] 	wb_fastserial_dat;
   wire [3:0] 	wb_fastserial_sel;
   wire 	      wb_fastserial_we;
   wire 	      wb_fastserial_cyc;
   wire [31:0] 	wb_fastserial_rdt;
   wire 	      wb_fastserial_ack;




wb_intercon wb(
        .wb_clk_i(wb_clk),
        .wb_rst_i(wb_rst),
        /* processor, master */
        .wb_cpu_dbus_adr_i(wb_cpu_dbus_adr),
        .wb_cpu_dbus_dat_i(wb_cpu_dbus_dat),
        .wb_cpu_dbus_sel_i(wb_cpu_dbus_sel),
        .wb_cpu_dbus_we_i(wb_cpu_dbus_we),
        .wb_cpu_dbus_cyc_i(wb_cpu_dbus_cyc),
        .wb_cpu_dbus_stb_i(),
        .wb_cpu_dbus_cti_i(),
        .wb_cpu_dbus_bte_i(),
        .wb_cpu_dbus_rty_o(),
        .wb_cpu_dbus_dat_o(wb_cpu_dbus_rdt),
        .wb_cpu_dbus_ack_o(wb_cpu_dbus_ack),
        .wb_cpu_dbus_err_o(),   
        /* ROM/Insruction bus */
        .wb_cpu_ibus_adr_i(wb_cpu_ibus_adr),
        .wb_cpu_ibus_dat_i(wb_cpu_ibus_dat),
        .wb_cpu_ibus_sel_i(wb_cpu_ibus_sel),
        .wb_cpu_ibus_we_i(wb_cpu_ibus_we),
        .wb_cpu_ibus_cyc_i(wb_cpu_ibus_cyc),
        .wb_cpu_ibus_stb_i(),
        .wb_cpu_ibus_cti_i(),
        .wb_cpu_ibus_bte_i(),
        .wb_cpu_ibus_dat_o(wb_cpu_ibus_rdt),
        .wb_cpu_ibus_ack_o(wb_cpu_ibus_ack),
        .wb_cpu_ibus_err_o(),
        .wb_cpu_ibus_rty_o(),
         /* debug slave*/
        .wb_debug_adr_o(wb_debug_adr),
        .wb_debug_dat_o(wb_debug_dat),
        .wb_debug_sel_o(wb_debug_sel),
        .wb_debug_we_o(wb_debug_we),
        .wb_debug_cyc_o(wb_debug_cyc),
        .wb_debug_stb_o(),
        .wb_debug_cti_o(),
        .wb_debug_bte_o(),
        .wb_debug_dat_i(wb_debug_rdt),
        .wb_debug_ack_i(wb_debug_ack),
        .wb_debug_err_i(),
        .wb_debug_rty_i(),
        /* fast serial */
        .wb_fastserial_adr_o(wb_fastserial_adr),
        .wb_fastserial_dat_o(wb_fastserial_dat),
        .wb_fastserial_sel_o(wb_fastserial_sel),
        .wb_fastserial_we_o(wb_fastserial_we),
        .wb_fastserial_cyc_o(wb_fastserial_cyc),
        .wb_fastserial_stb_o(),
        .wb_fastserial_cti_o(),
        .wb_fastserial_bte_o(),
        .wb_fastserial_dat_i(wb_fastserial_rdt),
        .wb_fastserial_ack_i(wb_fastserial_ack),
        .wb_fastserial_err_i(),
        .wb_fastserial_rty_i(),        

         /* gpio slave */
        .wb_gpio_adr_o(wb_gpio_adr),
        .wb_gpio_dat_o(wb_gpio_dat),
        .wb_gpio_sel_o(wb_gpio_sel),
        .wb_gpio_we_o(wb_gpio_we),
        .wb_gpio_cyc_o(wb_gpio_cyc),
        .wb_gpio_stb_o(),
        .wb_gpio_cti_o(),
        .wb_gpio_bte_o(),
        .wb_gpio_dat_i(wb_gpio_rdt),
        .wb_gpio_ack_i(wb_gpio_ack),
        .wb_gpio_err_i(),
        .wb_gpio_rty_i(),
        /* RAM */
        .wb_ram_adr_o(wb_ram_adr),
        .wb_ram_dat_o(wb_ram_dat),
        .wb_ram_sel_o(wb_ram_sel),
        .wb_ram_we_o(wb_ram_we),
        .wb_ram_cyc_o(wb_ram_cyc),
        .wb_ram_stb_o(),
        .wb_ram_cti_o(),
        .wb_ram_bte_o(),
        .wb_ram_dat_i(wb_ram_rdt),
        .wb_ram_ack_i(wb_ram_ack),
        .wb_ram_err_i(),
        .wb_ram_rty_i(),
/* ROM */
        .wb_rom_adr_o(wb_rom_adr),
        .wb_rom_dat_o(wb_rom_dat),
        .wb_rom_sel_o(wb_rom_sel),
        .wb_rom_we_o(wb_rom_we),
        .wb_rom_cyc_o(wb_rom_cyc),
        .wb_rom_stb_o(),
        .wb_rom_cti_o(),
        .wb_rom_bte_o(),
        .wb_rom_dat_i(wb_rom_rdt),
        .wb_rom_ack_i(wb_rom_ack),
        .wb_rom_err_i(),
        .wb_rom_rty_i(),        
         /* timer slave */
        .wb_timer_adr_o(wb_timer_adr),
        .wb_timer_dat_o(wb_timer_dat),
        .wb_timer_sel_o(wb_timer_sel),
        .wb_timer_we_o(wb_timer_we),
        .wb_timer_cyc_o(wb_timer_cyc),
        .wb_timer_stb_o(),
        .wb_timer_cti_o(),
        .wb_timer_bte_o(),
        .wb_timer_dat_i(wb_timer_rdt),
        .wb_timer_ack_i(wb_timer_ack),
        .wb_timer_err_i(),
        .wb_timer_rty_i());

    debug_output debug
       (.i_wb_clk (wb_clk),
      .i_wb_dat (wb_debug_dat),
      .i_wb_we  (wb_debug_we),
      .i_wb_cyc (wb_debug_cyc),
      .o_wb_rdt (wb_debug_rdt),
      .o_debug_strobe(o_debug_strobe),
      .o_debug_data(o_debug_port));

  quad_gpio gpio
    ( .i_clk (wb_clk),
      .i_wb_addr(wb_gpio_adr),
      .i_wb_dat (wb_gpio_dat),
      .i_wb_we  (wb_gpio_we),
      .i_wb_cyc (wb_gpio_cyc),
      .o_wb_dat (wb_gpio_rdt),
      .o_wb_ack(wb_gpio_ack),
      .o_gpio(o_gpio));

   /* Instruction ROM */
    ram
     #(.memfile(rom_file),
       .depth (rom_file_size))
   rom
     (// Wishbone interface
      .i_wb_clk (wb_clk),
      .i_wb_adr (wb_rom_adr[$clog2(rom_file_size)-1:2]),
      .i_wb_cyc (wb_rom_cyc),
      .i_wb_we  (wb_rom_we) ,       /* cannot write */
      .i_wb_sel (wb_rom_sel),        /* always selected */
      .i_wb_dat (wb_rom_dat),        /* data is zero */
      .o_wb_rdt (wb_rom_rdt),
      .o_wb_ack (wb_rom_ack));

   /* Instruction ROM */
    ram
     #(.memfile(),
       .depth (ram_size))
   ram_device
     (// Wishbone interface
      .i_wb_clk (wb_clk),
      .i_wb_adr (wb_ram_adr[$clog2(ram_size)-1:2]),
      .i_wb_cyc (wb_ram_cyc),
      .i_wb_we  (wb_ram_we) ,       /* cannot write */
      .i_wb_sel (wb_ram_sel),        /* always selected */
      .i_wb_dat (wb_ram_dat),        /* data is zero */
      .o_wb_rdt (wb_ram_rdt),
      .o_wb_ack (wb_ram_ack));      


quad_timer
  timer(.i_clk(wb_clk),
        .i_wb_addr(wb_timer_adr),
        .i_wb_dat(wb_timer_dat),
        .i_wb_we(wb_timer_we),
        .i_wb_cyc(wb_timer_cyc),
        .o_wb_dat(wb_timer_rdt),
        .o_wb_ack(wb_timer_ack),
        .o_irq());



fastserial_wb #(.fast_serial_divider(fast_serial_divider))
fast_serial(.i_clk(wb_clk),
            .i_wb_addr(wb_fastserial_adr),
            .i_wb_dat(wb_fastserial_dat),
            .i_wb_we(wb_fastserial_we),
            .i_wb_cyc(wb_fastserial_cyc),
            .o_wb_dat(wb_fastserial_rdt),
            .o_wb_ack(wb_fastserial_ack),
            .i_fsdo(i_fsdo),
            .i_fscts(i_fscts),
            .o_fsclk(o_fsclk),
            .o_fsdi(o_fsdi));


    serv_rf_top
     #(.RESET_PC (32'h0000_0000),
       .WITH_CSR (1))
   cpu
     (
      .clk      (wb_clk),
      .i_rst    (wb_rst),
      .i_timer_irq  (timer_irq),
`ifdef RISCV_FORMAL
      .rvfi_valid     (),
      .rvfi_order     (),
      .rvfi_insn      (),
      .rvfi_trap      (),
      .rvfi_halt      (),
      .rvfi_intr      (),
      .rvfi_mode      (),
      .rvfi_ixl       (),
      .rvfi_rs1_addr  (),
      .rvfi_rs2_addr  (),
      .rvfi_rs1_rdata (),
      .rvfi_rs2_rdata (),
      .rvfi_rd_addr   (),
      .rvfi_rd_wdata  (),
      .rvfi_pc_rdata  (),
      .rvfi_pc_wdata  (o_pc),
      .rvfi_mem_addr  (),
      .rvfi_mem_rmask (),
      .rvfi_mem_wmask (),
      .rvfi_mem_rdata (),
      .rvfi_mem_wdata (),
`endif

      .o_ibus_adr   (wb_cpu_ibus_adr),
      .o_ibus_cyc   (wb_cpu_ibus_cyc),
      .i_ibus_rdt   (wb_cpu_ibus_rdt),
      .i_ibus_ack   (wb_cpu_ibus_ack),

      .o_dbus_adr   (wb_cpu_dbus_adr),
      .o_dbus_dat   (wb_cpu_dbus_dat),
      .o_dbus_sel   (wb_cpu_dbus_sel),
      .o_dbus_we    (wb_cpu_dbus_we),
      .o_dbus_cyc   (wb_cpu_dbus_cyc),
      .i_dbus_rdt   (wb_cpu_dbus_rdt),
      .i_dbus_ack   (wb_cpu_dbus_ack));



endmodule
//eof
