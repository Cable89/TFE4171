timeunit 10ns;

`include "hdlc_packet.sv"
//'include "tb_wrapper.v"

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

parameter NMESSAGES=10;

//initial begin
//  clk_i=0;
//  txclk=0;
//  rxclk=0;
//end

HDLC_packet test_message[NMESSAGES];

initial
message_gen: begin
  clk_i=0;
  txclk=0;
  rxclk=0;
  for (int i = 0; i < NMESSAGES; i++) begin
    test_message[i] = new;
    test_message[i].getbits(rx);
  end
end:message_gen
  
always #1  clk_i =~clk_i;
always #25 txclk =~txclk;
always #25 rxclk =~txclk;

endmodule : hdlc_tb

