## Generated SDC file "DIVISOR.out.sdc"

## Copyright (C) 2017  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 17.1.1 Internal Build 593 12/11/2017 SJ Standard Edition"

## DATE    "Mon Nov 13 15:45:37 2023"

##
## DEVICE  "EP4CE115F29C7"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {CLK} -period 10.000 -waveform { 0.000 5.000 } [get_ports { CLK }]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {CLK}] -rise_to [get_clocks {CLK}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {CLK}] -fall_to [get_clocks {CLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {CLK}] -rise_to [get_clocks {CLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {CLK}] -fall_to [get_clocks {CLK}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[0]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[1]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[2]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[3]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[4]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[5]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[6]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[7]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[8]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[9]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[10]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[11]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[12]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[13]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[14]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[15]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[16]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[17]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[18]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[19]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[20]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[21]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[22]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[23]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[24]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[25]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[26]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[27]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[28]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[29]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[30]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Den[31]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[0]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[1]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[2]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[3]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[4]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[5]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[6]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[7]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[8]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[9]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[10]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[11]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[12]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[13]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[14]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[15]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[16]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[17]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[18]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[19]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[20]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[21]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[22]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[23]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[24]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[25]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[26]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[27]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[28]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[29]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[30]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Num[31]}]
set_input_delay -add_delay  -clock [get_clocks {CLK}]  1.000 [get_ports {Start}]


#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

