# Remove all old libraries
echo Cleaning old libraries
vdel -lib work -all -verbose
vdel -lib utility -all -verbose
vdel -lib hdlc -all -verbose
vdel -lib memlib -all -verbose
# Build
echo building new libraries
vlib work
vlib utility
vlib hdlc
vlib memlib
echo mapping new libraries
vmap work work
vmap utility utility
vmap hdlc hdlc
vmap memlib memlib
# Compile files
# Utility Files
vcom -work utility tools_pkg.vhd
#hdlc lib files
vcom -work hdlc ../code/libs/PCK_CRC16_D8.vhd

#memlib lib files
vcom -work memlib spmem.vhd
vcom -work memlib mem_pkg.vhd

#Core files
vcom -work work ../code/top/core/TxFCS.vhd
vcom -work work ../code/top/core/TxBuff.vhd

#Simulation core files
vcom -work work top/tb/TxTop_tb.vhd

#Load 
#vsim work.txtop_ent_tb 
