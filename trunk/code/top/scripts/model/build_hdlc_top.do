vlib work
vlib utility
vlib hdlc
vlib memlib

vmap work
vmap utility
vmap hdlc
vmap memlib


# Utility files
vcom -work utility  ../code/tools_pkg.vhd


#memLib
vcom -work memlib ../code/spmem.vhd 

vcom -work memlib  ../code/mem_pkg.vhd 


#HDLC files
vcom -work hdlc  ../code/libs/PCK_CRC16_D8.vhd

vcom -work hdlc  ../code/libs/hdlc_components_pkg.vhd

#Work files
#Rx
vcom -work work  ../code/top/core/RxFCS.vhd

vcom -work work  ../code/top/core/RxBuff.vhd -explicit

vcom -work work  ../code/rx/core/Zero_detect.vhd

vcom -work work  ../code/rx/core/flag_detect.vhd

vcom -work work  ../code/rx/core/Rxcont.vhd


vcom -work work  ../code/rx/core/RxChannel.vhd

vcom -work work  ../code/top/core/RxSync.vhd


#Tx
vcom -work work  ../code/top/core/TxFCS.vhd

vcom -work work  ../code/top/core/TxBuff.vhd -explicit

vcom -work work  ../code/tx/core/flag_ins.vhd

vcom -work work  ../code/tx/core/zero_ins.vhd

vcom -work work  ../code/tx/core/TXcont.vhd


vcom -work work  ../code/tx/core/TxChannel.vhd

vcom -work work  ../code/top/core/TxSync.vhd


#WB and host
vcom -work work  ../code/top/core/WB_IF.vhd

vcom -work work  ../code/top/core/hdlc.vhd

# Test bench
vcom -work work  ../code/top/tb/hdlc_tb.vhd -explicit
