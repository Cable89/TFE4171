#!/usr/bin/bash

echo "---- Compiling hdlc_props.v  ----"
vlog -sv top/scripts/sva/hdlc_props.v
echo ""
echo ""

echo "---- Compiling sva_wrapper.v ----"
vlog -sv top/scripts/sva/sva_wrapper.v
echo ""
echo ""

echo "------ Starting simulation ------"
vsim -c work.hdlc_tb work.sva_wrapper
