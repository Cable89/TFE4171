program hdlc_props(input 
	txclk,
	rxclk,
	tx,
	rx,
	txen,
	rxen,
	rst_i,
	clk_i,
	adr_i,
	dat_o,
	dat_i,
	we_i,
	stb_i,
	ack_o,
	cyc_i,
	rty_o,
	tag0_o,
	tag1_o,
	txdataavail,
	rxfcsvalidframe,
	txfcsvalidframe,
	zeroremovedflag,
	abortframe,
	abortsignal
	);
	//1. Synchronous operation
	
	// If txclk is stable when tx is asserted or disasserted throw error
	property syncTest1;
		@(posedge clk_i)
			($rose(tx)) |-> !($stable(txclk));
	endproperty
	assert property (syncTest1) else $display($stime,,,"syncTest1 FAIL");

	property syncTest2;
		@(posedge clk_i)
	                ($fell(tx)) |-> !($stable(txclk));
        endproperty
        assert property (syncTest2) else $display($stime,,,"syncTest2 FAIL");

	// rxclk and rx is both external signals, so checking sync for rx
	// makes no sense.
	
	//2. 8 bit parallell back-end interface
	//Use constrained randomization
	//Test bench?? should we do something
	
	//3. Use external RX and TX clocks
	
	//4. Start and end of frame pattern generation (Tx)
	
	// When data enters buffer check if start of frame is generated

	sequence flag;
		!tx ##1 tx [*6] ##1 !tx;
	endsequence
	
	sequence startFlag;
		$rose(txdataavail) ##[1:$] flag;
	endsequence

	sequence endFlag;
		$fell(txdataavail) ##[1:$] flag;
	endsequence

	property startFrameTx;
		@(posedge txclk)
			$rose(txdataavail) |-> ##[1:$] !tx ##1 tx [*6] ##1 !tx;
	endproperty
	assert property (startFrameTx) else $display($stime,,,"startFrameTx FAIL");

	// When data buffer is empty check if end of frame is generated
	
	property endFrameTx;
                @(posedge txclk)
                        $fell(txdataavail) |-> ##[1:$] !tx ##1 tx [*6] ##1 !tx;
        endproperty
        assert property (endFrameTx) else $display($stime,,,"endFrameTx FAIL");	
	
	//5. Start and end of frame pattern checking (Rx)

	property startFrameRx;
		@(negedge rxclk) 
			!rx ##1 rx [*6] ##1 !rx |-> ##[1:$] $rose(rxfcsvalidframe);
	endproperty
	assert property (startFrameRx) else $display($stime,,,"startFrameRx FAIL");

	property endFrameRx;
                @(negedge rxclk)
                        !rx ##1 rx [*6] ##1 !rx |-> ##[1:$] $fell(rxfcsvalidframe);
        endproperty
        assert property (endFrameRx) else $display($stime,,,"endFrameRx FAIL");

	//6. Idle pattern generation and detection (all ones)
	
	property idlePatternTx;
		@(posedge txclk)
			!txfcsvalidframe |-> ##[0:50] tx [*8];
	endproperty
	assert property (idlePatternTx) else $display($stime,,,"idlePatternTx FAIL"); 
	property idlePatternRx;
		@(negedge rxclk)
			rx [*8] |-> ##2 !rxfcsvalidframe;
	endproperty
	assert property (idlePatternRx) else $display($stime,,,"idlePatternRx FAIL");

	//7. Zero insertion and removal for transparent transmission
	
	//property zeroInsertion;
	//	@(posedge txclk)
	//		disable iff (endFlag)
	//		(startFlag) ##[0:$] tx [*5] |-> ##1 !tx;
	//endproperty

	//assert property (zeroInsertion) else $display($time,,,"zeroInsertion FAIL");

	//TBD: Change input from testbench to actually get an inserted zero on
	//rx line
	property zeroRemoval;
		@(negedge rxclk)
			!rx ##1 rx [*5] ##1 !rx |-> ##1 !zeroremovedflag;
	endproperty

	assert property (zeroRemoval) else $display($time,,,"zeroRemoval FAIL");

	//8. Abort pattern generation and checking (7 ones)
	
	property abortPatterGeneration;
		@(posedge txclk)
			$rose(abortframe) |-> ##[0:50] !tx ##1 tx [*7];
	endproperty

	assert property (abortPatterGeneration) else $display($time,,,"abortPatterGeneration FAIL");

	property abortPatternChecking;
		@(negedge rxclk)
			!rx ##1 rx [*7] |-> ##[0:2] $rose(abortsignal); 
	endproperty

	assert property (abortPatternChecking) else $display($time,,,"abortPatternChecking FAIL");
	
	//9. Address insertion and detection by software
	// --- N/A ---
	//10. CRC generation and checking (CRC-16 or CRC-32 can be used witch
	//is configurable at the code top level)
	
	
	
	//11. FIFO buffers and synchronization (External)
	// --- N/A ---
	//12. Byte aligned data (if data is not aligned to 8-bits error signal
	//is reported to the backend interface)
	
	property alignmentCheck;
		@(posedge txclk)
	endproperty

	//13. Q.921, LAPD and LAPB compliant
	
	//14. The core should not have internal configuration registers or
	//counters, instead it provides all the signals to implement external
	//registers.
	
	//15. There is No limit on the Maximum frame size as long as the
	//backend can read and write data (depends on the wxternal FIFO size)
	// Hmm... how to test????
	//16. Bus connection is not supported directly (TxEN and RxEN pins can
	//be used for that reason)
	// --- ??? ---
	//17. Retransmission is not supported when there is collision in the
	//Bus connection mode
	// --- N/A ---
	//18. This controller is used for low speed application only
	//(relative to the backend bus)
	// --- No coverage needed ---
	//19. Supports connection to TDM core via backend interface and
	//software control for time slot selection and control (signaling,
	//etc.) generation
	// --- ??? ---
	//20. Backend interface uses the Wishbone bus interface which can be
	//connected directly to the system or via FIFO buffer
	
	//21. Optional External FIFO buffers, configuration and status
	//registers
	
	//22. The core will be made of two levels of hierchies, the basic
	//functionality and the Optional interfaces and buffers
	// --- N/A ---
endprogram
