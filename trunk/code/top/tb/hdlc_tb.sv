`include "hdlc_packet.sv"
`include "tb_wrapper.v"

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
timeunit 10ns;

parameter NMESSAGES=10;

bit rx_thingy;
HDLC_packet test_message[10];

initial
message_gen: begin
  for (int i = 0; i < 10; i++) begin
    test_message[i] = new;
    test_message[i].randomize();
    test_message[i].getbits(rx_thingy);
  end
end:message_gen
  
//always #1  clk_i =~clk_i;
//always #25 txclk =~txclk;
//always #25 rxclk =~txclk;

endmodule : hdlc_tb

