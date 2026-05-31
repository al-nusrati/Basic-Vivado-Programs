# This file is a constraints file for the Basys 3 board, mapping ports of the myNOT module

# Input: Map in1 to switch SW0 (pin V17)
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports in1]

# Output: Map out1 to LED0 (pin U16)
set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports out1]

# Configuration settings for Basys 3
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]