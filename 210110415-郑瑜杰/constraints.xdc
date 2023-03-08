create_clock -period 10.000 -name clk_100M -waveform {0.000 5.000} [get_ports clk]

set_property -dict {PACKAGE_PIN Y18 IOSTANDARD LVCMOS33} [get_ports clk]
#//S1
set_property -dict {PACKAGE_PIN R1  IOSTANDARD LVCMOS33} [get_ports reset]  
#//S2
set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS33} [get_ports set_code_button]
#//s5
set_property -dict {PACKAGE_PIN P2  IOSTANDARD LVCMOS33} [get_ports confirm_button]
#//S3
set_property -dict {PACKAGE_PIN P5 IOSTANDARD LVCMOS33} [get_ports input_button]

set_property -dict {PACKAGE_PIN K4 IOSTANDARD LVCMOS33} [get_ports {row[0]}]
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports {row[1]}]
set_property -dict {PACKAGE_PIN L3 IOSTANDARD LVCMOS33} [get_ports {row[2]}]
set_property -dict {PACKAGE_PIN K3 IOSTANDARD LVCMOS33} [get_ports {row[3]}]
set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVCMOS33} [get_ports {col[0]}]
set_property -dict {PACKAGE_PIN K6 IOSTANDARD LVCMOS33} [get_ports {col[1]}]
set_property -dict {PACKAGE_PIN J6 IOSTANDARD LVCMOS33} [get_ports {col[2]}]
set_property -dict {PACKAGE_PIN L5 IOSTANDARD LVCMOS33} [get_ports {col[3]}]

set_property -dict {PACKAGE_PIN A21 IOSTANDARD LVCMOS33} [get_ports {gre_led[0]}]
set_property -dict {PACKAGE_PIN E22 IOSTANDARD LVCMOS33} [get_ports {gre_led[1]}]
set_property -dict {PACKAGE_PIN D22 IOSTANDARD LVCMOS33} [get_ports {gre_led[2]}]


set_property -dict {PACKAGE_PIN K14 IOSTANDARD LVCMOS33} [get_ports {red_led[0]}]
set_property -dict {PACKAGE_PIN K13 IOSTANDARD LVCMOS33} [get_ports {red_led[1]}]
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS33} [get_ports {red_led[2]}]

#output led_en 0-7
set_property PACKAGE_PIN C19 [get_ports led_en[0]]
set_property PACKAGE_PIN E19 [get_ports led_en[1]]
set_property PACKAGE_PIN D19 [get_ports led_en[2]]
set_property PACKAGE_PIN F18 [get_ports led_en[3]]
set_property PACKAGE_PIN E18 [get_ports led_en[4]]
set_property PACKAGE_PIN B20 [get_ports led_en[5]]
set_property PACKAGE_PIN A20 [get_ports led_en[6]]
set_property PACKAGE_PIN A18 [get_ports led_en[7]]

#output led_cx 0-7  led:DP,G,F,E,D,C,B,A
set_property PACKAGE_PIN E13 [get_ports led_cx[0]]
set_property PACKAGE_PIN C15 [get_ports led_cx[1]]
set_property PACKAGE_PIN C14 [get_ports led_cx[2]]
set_property PACKAGE_PIN E17 [get_ports led_cx[3]]
set_property PACKAGE_PIN F16 [get_ports led_cx[4]]
set_property PACKAGE_PIN F14 [get_ports led_cx[5]]
set_property PACKAGE_PIN F13 [get_ports led_cx[6]]
set_property PACKAGE_PIN F15 [get_ports led_cx[7]]


set_property IOSTANDARD LVCMOS33 [get_ports led_en[0]]
set_property IOSTANDARD LVCMOS33 [get_ports led_en[1]]
set_property IOSTANDARD LVCMOS33 [get_ports led_en[2]]
set_property IOSTANDARD LVCMOS33 [get_ports led_en[3]]
set_property IOSTANDARD LVCMOS33 [get_ports led_en[4]]
set_property IOSTANDARD LVCMOS33 [get_ports led_en[5]]
set_property IOSTANDARD LVCMOS33 [get_ports led_en[6]]
set_property IOSTANDARD LVCMOS33 [get_ports led_en[7]]

set_property IOSTANDARD LVCMOS33 [get_ports led_cx[0]]
set_property IOSTANDARD LVCMOS33 [get_ports led_cx[1]]
set_property IOSTANDARD LVCMOS33 [get_ports led_cx[2]]
set_property IOSTANDARD LVCMOS33 [get_ports led_cx[3]]
set_property IOSTANDARD LVCMOS33 [get_ports led_cx[4]]
set_property IOSTANDARD LVCMOS33 [get_ports led_cx[5]]
set_property IOSTANDARD LVCMOS33 [get_ports led_cx[6]]
set_property IOSTANDARD LVCMOS33 [get_ports led_cx[7]]
