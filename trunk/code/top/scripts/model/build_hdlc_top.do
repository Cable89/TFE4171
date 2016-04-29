vlib work
vlib utility
vlib hdlc
vlib memlib

vmap work
vmap utility
vmap hdlc
vmap memlib


# Test bench
vlog -work work  ~/hdlc/trunk/code/top/tb/hdlc_tb.sv

# Utility files
vcom -work utility  ~/hdlc/trunk/code/tools_pkg.vhd


#memLib
vcom -work memlib ~/hdlc/trunk/code/spmem.vhd 

vcom -work memlib  ~/hdlc/trunk/code/mem_pkg.vhd 


#HDLC files
vcom -work hdlc  ~/hdlc/trunk/code/libs/PCK_CRC16_D8.vhd

vcom -work hdlc  ~/hdlc/trunk/code/libs/hdlc_components_pkg.vhd

#Work files
#Rx
vcom -work work  ~/hdlc/trunk/code/top/core/RxFCS.vhd

vcom -work work  ~/hdlc/trunk/code/top/core/RxBuff.vhd -explicit

vcom -work work  ~/hdlc/trunk/code/rx/core/Zero_detect.vhd

vcom -work work  ~/hdlc/trunk/code/rx/core/flag_detect.vhd

vcom -work work  ~/hdlc/trunk/code/rx/core/Rxcont.vhd


vcom -work work  ~/hdlc/trunk/code/rx/core/RxChannel.vhd

vcom -work work  ~/hdlc/trunk/code/top/core/RxSync.vhd


#Tx
vcom -work work  ~/hdlc/trunk/code/top/core/TxFCS.vhd

vcom -work work  ~/hdlc/trunk/code/top/core/TxBuff.vhd -explicit

vcom -work work  ~/hdlc/trunk/code/tx/core/flag_ins.vhd

vcom -work work  ~/hdlc/trunk/code/tx/core/zero_ins.vhd

vcom -work work  ~/hdlc/trunk/code/tx/core/TXcont.vhd


vcom -work work  ~/hdlc/trunk/code/tx/core/TxChannel.vhd

vcom -work work  ~/hdlc/trunk/code/top/core/TxSync.vhd


#WB and host
vcom -work work  ~/hdlc/trunk/code/top/core/WB_IF.vhd

vcom -work work  ~/hdlc/trunk/code/top/core/hdlc.vhd
