iverilog -o tb quad_timer_tb.v ../rtl/quad_timer.v
vvp tb
gtkwave quad_timer_tb.vcd 


iverilog -o tb quad_gpio_tb.v ../rtl/quad_gpio.v
vvp tb
if [ $? -eq 0 ]
then
  gtkwave quad_gpio_tb.vcd 
  exit 0
else
  echo "The script failed" >&2
  exit 1
fi


