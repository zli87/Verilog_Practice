# clock
#set_property -dict {PACKAGE_PIN R3 IOSTANDARD LVDS_25} [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 4.000} -add [get_ports clk]

#button (active high)
set_property -dict {PACKAGE_PIN U4 IOSTANDARD SSTL15} [get_ports rst]

# led
set_property -dict {PACKAGE_PIN M26 IOSTANDARD LVCMOS33} [get_ports Dout[0]]
#set_property -dict {PACKAGE_PIN T24 IOSTANDARD LVCMOS33} [get_ports Dout[5]];
#set_property -dict {PACKAGE_PIN T25 IOSTANDARD LVCMOS33} [get_ports Dout[6]];
#set_property -dict {PACKAGE_PIN R26 IOSTANDARD LVCMOS33} [get_ports Dout[7]];

#lcd
set_property -dict {PACKAGE_PIN L25 IOSTANDARD LVCMOS33} [get_ports Dout[1]];
set_property -dict {PACKAGE_PIN M24 IOSTANDARD LVCMOS33} [get_ports Dout[2]];
set_property -dict {PACKAGE_PIN M25 IOSTANDARD LVCMOS33} [get_ports Dout[3]];
set_property -dict {PACKAGE_PIN L22 IOSTANDARD LVCMOS33} [get_ports Dout[4]];
set_property -dict {PACKAGE_PIN L24 IOSTANDARD LVCMOS33} [get_ports Dout[5]];
set_property -dict {PACKAGE_PIN L23 IOSTANDARD LVCMOS33} [get_ports Dout[6]];
set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVCMOS33} [get_ports Dout[7]];

set_input_delay -clock [get_clocks sys_clk_pin] -min -add_delay 2.000 [get_ports rst]
set_input_delay -clock [get_clocks sys_clk_pin] -max -add_delay 2.000 [get_ports rst]
set_output_delay -clock [get_clocks sys_clk_pin] -min -add_delay 0.000 [get_ports Dout]
set_output_delay -clock [get_clocks sys_clk_pin] -max -add_delay 2.000 [get_ports Dout]
