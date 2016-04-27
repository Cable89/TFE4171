'include "hdlc_packet.sv"
'include "../core/hdlc.vhd"

HDLC_packet test_message[NMESSAGES];

module hdlc_tb();

parameter NMESSAGES = 10;

module hdlc_tb(output
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
    tag1_o
    );
endmodule : hdlc_tb
