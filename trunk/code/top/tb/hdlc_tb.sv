'include "hdlc_packet.sv"
'include "../core/hdlc.vhd"

HDLC_packet test_message[NMESSAGES];

module hdlc_tb();

parameter NMESSAGES = 10;

reg Txclk;
reg RxClk;
wire Tx;
wire Rx;
wire TxEN
wire RxEN;
wire RST_I;
reg CLK_I;
wire [2:0] ADR_I;
wire [31:0] DAT_O;
wire [31:0] DAT_I;
wire WE_I;
wire STB_I;
wire ACK_O;
wire CYC_I;
wire RTY_O;
wire TAG0_O;
wire TAG1_O;

hdlc_ports ports (
    .Txclk       (Txclk ),
    .RxClk       (RxClk ),
    .Tx          (Tx    ),
    .Rx          (Rx    ),
    .TxEN        (TxEN  ),
    .RxEN        (RxEN  ),
    .RST_I       (RST_I ),
    .CLK_I       (CLK_I ),
    .ADR_I       (ADR_I ),
    .DAT_O       (DAT_O ),
    .DAT_I       (DAT_I ),
    .WE_I        (WE_I  ),
    .STB_I       (STB_I ),
    .ACK_O       (ACK_O ),
    .CYC_I       (CYC_I ),
    .RTY_O       (RTY_O ),
    .TAG0_O      (TAG0_O),
    .TAG1_O      (TAG1_O)
);

hdlc_monitor_ports mports (
    .Txclk       (Txclk ),
    .RxClk       (RxClk ),
    .Tx          (Tx    ),
    .Rx          (Rx    ),
    .TxEN        (TxEN  ),
    .RxEN        (RxEN  ),
    .RST_I       (RST_I ),
    .CLK_I       (CLK_I ),
    .ADR_I       (ADR_I ),
    .DAT_O       (DAT_O ),
    .DAT_I       (DAT_I ),
    .WE_I        (WE_I  ),
    .STB_I       (STB_I ),
    .ACK_O       (ACK_O ),
    .CYC_I       (CYC_I ),
    .RTY_O       (RTY_O ),
    .TAG0_O      (TAG0_O),
    .TAG1_O      (TAG1_O)
);

hdlc_top top(ports,mports);

initial begin
    $dumpfile("hdlc.vcd");
    $dumpvars();
    Txclk=0;
    RxClk=0;
    CLK_I=0;
end

always #1 Txclk = ~Txclk
always #1 RxClk = ~RxClk
always #1 CLK_I = ~CLK_I

syn_hdlc hdlc (
    .Txclk       (Txclk ),
    .RxClk       (RxClk ),
    .Tx          (Tx    ),
    .Rx          (Rx    ),
    .TxEN        (TxEN  ),
    .RxEN        (RxEN  ),
    .RST_I       (RST_I ),
    .CLK_I       (CLK_I ),
    .ADR_I       (ADR_I ),
    .DAT_O       (DAT_O ),
    .DAT_I       (DAT_I ),
    .WE_I        (WE_I  ),
    .STB_I       (STB_I ),
    .ACK_O       (ACK_O ),
    .CYC_I       (CYC_I ),
    .RTY_O       (RTY_O ),
    .TAG0_O      (TAG0_O),
    .TAG1_O      (TAG1_O)
);
