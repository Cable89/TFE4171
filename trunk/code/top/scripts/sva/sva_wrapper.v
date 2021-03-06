module sva_wrapper;
	bind hdlc_tb

	hdlc_props hdlc_tb_bind

	(
	.txclk(Txclk),
	.rxclk(RxClk),
	.tx(Tx),
	.rx(Rx),
	.txen(TxEN),
	.rxen(RxEN),
	.rst_i(RST_I),
	.clk_i(CLK_I),
	.adr_i(ADR_I),
	.dat_o(DAT_O),
	.dat_i(DAT_I),
	.we_i(WE_I),
	.stb_i(STB_I),
	.ack_o(ACK_O),
	.cyc_i(CYC_I),
	.rty_o(RTY_O),
	.tag0_o(TAG0_O),
	.tag1_o(TAG1_O),
	.txdataavail(DUT.TxBuff.TxDataAvail),
	.rxfcsvalidframe(DUT.RxFCS.ValidFrame),
	.txfcsvalidframe(DUT.TxFCS.ValidFrame),
	.zeroremovedflag(DUT.RxChannel.zero_backend.flag),
	.abortframe(DUT.TxCore.AbortFrame),
	.abortsignal(DUT.RxChannel.AbortSignal)
	);
	
endmodule
