timeunit 10ns; 
`include "hdlc_packet.sv"
`include "tb_wrapper.v"
`include "hdlc_props.v"

module hdlc_tb();
reg txclk = 0;
reg rxclk = 1;
wire tx;
bit rx = 0;
reg txen = 0;
reg rxen = 0;
reg rst_i = 1;
reg clk_i = 0;
reg [2:0] adr_i = 3'h0;
wire [31:0] dat_o;
reg [31:0] dat_i = 32'h0;
reg we_i = 0;
reg stb_i = 0;
wire ack_o;
reg cyc_i = 0;
wire rty_o;
wire tag0_o;
wire tag1_o;

parameter NMESSAGES=10;

//bit rx_thingy;
HDLC_packet test_message[10];
//rx <= rx_thingy;

initial
message_gen: begin
    for (int i = 0; i < 10; i++) begin
        test_message[i] = new;
        test_message[i].randomize();
        test_message[i].getbits(rx);
    end
end:message_gen

/*
  // From vhdl test bench
  Txclk <= not Txclk after 250 ns;
  Rxclk <= not Rxclk after 250 ns;
  CLK_I <= not CLK_I after 10 ns;
  RST_I <= '1',
           '0'       after 1 us;
 
  TxEN <= '1';
  RxEN <= '1';
*/

always begin
    #1 clk_i =~clk_i;
end

always begin
    #25 txclk =~txclk;
        rxclk =~txclk;
end


hdlc_ent dut   (txclk,
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

