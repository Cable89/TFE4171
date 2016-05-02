typedef struct {
         bit [7:0]  sflag;      // Begin flag
    rand bit [7:0]  address;    // 8 or more bits
    rand bit [7:0]  control;    // What is this? 8 or 16bits
    rand byte databytes[];           // Random junk n * 8bits
         bit [15:0] crc;        // CRC 16 bit
         bit  [7:0] eflag;      // End flag
} packet_t;

class HDLC_packet;
    rand packet_t packet;

    constraint c1 { packet.address inside {[0:8]}; }
    constraint c2 { packet.control inside {[0:8]}; }
    constraint data_size { packet.databytes.size() inside {[1:100]}; }   
 
    task clear_data;
        packet.databytes.delete();
    endtask

    function new ();
        packet.sflag = 8'b01111110;
        packet.eflag = 8'b01111110;
        packet.crc = crc16(packet.databytes, $size(packet.databytes));
    endfunction

    task randomize_foreach;
        foreach(packet.databytes[i])
            std::randomize(packet.databytes[i]);
    endtask
    
    // Unpack the data, and serialize it
    task getbits(ref bit data_o, input int delay=5);
        bit [23:0] header;
        bit [23:0] tail;
        int ones = 0;
        header = {packet.sflag, packet.address, packet.control};
        tail = {packet.crc, packet.eflag};
        //step through message and output each bit (from left to right)
        foreach(header[i]) #delay data_o = header[i];
        foreach(packet.databytes[i,j]) begin
            if(packet.databytes[i][j] == 1'b1) begin
                ones++;
                if(ones == 5) begin
                    // Zero bit insertion
                    #delay data_o = 1'b0;
                    ones = 0;
                end
            end
            #delay data_o = packet.databytes[i][j];
        end
        foreach(tail[i]) #delay data_o = tail[i];
    endtask

    task print();
        begin
            $display("sflag: %0d", packet.sflag);
            $display("address: %0d", packet.address);
            $display("control: %0d", packet.control);
            $display("data: %0d", packet.databytes);
            $display("crc: %0d", packet.crc);
            $display("eflag: %0d", packet.eflag);
        end
    endtask


	//The following two functions (crc16 and reflect) are from Pktlib by Sachin Gandhi. See the below copyright notice.
	// url=https://github.com/sach/System-Verilog-Packet-Library
	/*
	Copyright (c) 2011, Sachin Gandhi
	All rights reserved.
	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
	    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
	    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
	    * Neither the name of the author nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
	*/	  

  // function to compute crc16
  function bit [15:0] crc16 (byte  pkt [],
                             bit [31:0] len     = 0,
                             bit [31:0] offset  = 0); // {
    bit [15:0] crc = 16'hffff;
    bit [7:0]  local_reg;
    bit [15:0] crc16_array [256];
    crc16_array[255] = 16'h4040;
    crc16_array[254] = 16'h8081;
    crc16_array[253] = 16'h81c1;
    crc16_array[252] = 16'h4100;
    crc16_array[251] = 16'h8341;
    crc16_array[250] = 16'h4380;
    crc16_array[249] = 16'h42c0;
    crc16_array[248] = 16'h8201;
    crc16_array[247] = 16'h8641;
    crc16_array[246] = 16'h4680;
    crc16_array[245] = 16'h47c0;
    crc16_array[244] = 16'h8701;
    crc16_array[243] = 16'h4540;
    crc16_array[242] = 16'h8581;
    crc16_array[241] = 16'h84c1;
    crc16_array[240] = 16'h4400;
    crc16_array[239] = 16'h8c41;
    crc16_array[238] = 16'h4c80;
    crc16_array[237] = 16'h4dc0;
    crc16_array[236] = 16'h8d01;
    crc16_array[235] = 16'h4f40;
    crc16_array[234] = 16'h8f81;
    crc16_array[233] = 16'h8ec1;
    crc16_array[232] = 16'h4e00;
    crc16_array[231] = 16'h4a40;
    crc16_array[230] = 16'h8a81;
    crc16_array[229] = 16'h8bc1;
    crc16_array[228] = 16'h4b00;
    crc16_array[227] = 16'h8941;
    crc16_array[226] = 16'h4980;
    crc16_array[225] = 16'h48c0;
    crc16_array[224] = 16'h8801;
    crc16_array[223] = 16'h9841;
    crc16_array[222] = 16'h5880;
    crc16_array[221] = 16'h59c0;
    crc16_array[220] = 16'h9901;
    crc16_array[219] = 16'h5b40;
    crc16_array[218] = 16'h9b81;
    crc16_array[217] = 16'h9ac1;
    crc16_array[216] = 16'h5a00;
    crc16_array[215] = 16'h5e40;
    crc16_array[214] = 16'h9e81;
    crc16_array[213] = 16'h9fc1;
    crc16_array[212] = 16'h5f00;
    crc16_array[211] = 16'h9d41;
    crc16_array[210] = 16'h5d80;
    crc16_array[209] = 16'h5cc0;
    crc16_array[208] = 16'h9c01;
    crc16_array[207] = 16'h5440;
    crc16_array[206] = 16'h9481;
    crc16_array[205] = 16'h95c1;
    crc16_array[204] = 16'h5500;
    crc16_array[203] = 16'h9741;
    crc16_array[202] = 16'h5780;
    crc16_array[201] = 16'h56c0;
    crc16_array[200] = 16'h9601;
    crc16_array[199] = 16'h9241;
    crc16_array[198] = 16'h5280;
    crc16_array[197] = 16'h53c0;
    crc16_array[196] = 16'h9301;
    crc16_array[195] = 16'h5140;
    crc16_array[194] = 16'h9181;
    crc16_array[193] = 16'h90c1;
    crc16_array[192] = 16'h5000;
    crc16_array[191] = 16'hb041;
    crc16_array[190] = 16'h7080;
    crc16_array[189] = 16'h71c0;
    crc16_array[188] = 16'hb101;
    crc16_array[187] = 16'h7340;
    crc16_array[186] = 16'hb381;
    crc16_array[185] = 16'hb2c1;
    crc16_array[184] = 16'h7200;
    crc16_array[183] = 16'h7640;
    crc16_array[182] = 16'hb681;
    crc16_array[181] = 16'hb7c1;
    crc16_array[180] = 16'h7700;
    crc16_array[179] = 16'hb541;
    crc16_array[178] = 16'h7580;
    crc16_array[177] = 16'h74c0;
    crc16_array[176] = 16'hb401;
    crc16_array[175] = 16'h7c40;
    crc16_array[174] = 16'hbc81;
    crc16_array[173] = 16'hbdc1;
    crc16_array[172] = 16'h7d00;
    crc16_array[171] = 16'hbf41;
    crc16_array[170] = 16'h7f80;
    crc16_array[169] = 16'h7ec0;
    crc16_array[168] = 16'hbe01;
    crc16_array[167] = 16'hba41;
    crc16_array[166] = 16'h7a80;
    crc16_array[165] = 16'h7bc0;
    crc16_array[164] = 16'hbb01;
    crc16_array[163] = 16'h7940;
    crc16_array[162] = 16'hb981;
    crc16_array[161] = 16'hb8c1;
    crc16_array[160] = 16'h7800;
    crc16_array[159] = 16'h6840;
    crc16_array[158] = 16'ha881;
    crc16_array[157] = 16'ha9c1;
    crc16_array[156] = 16'h6900;
    crc16_array[155] = 16'hab41;
    crc16_array[154] = 16'h6b80;
    crc16_array[153] = 16'h6ac0;
    crc16_array[152] = 16'haa01;
    crc16_array[151] = 16'hae41;
    crc16_array[150] = 16'h6e80;
    crc16_array[149] = 16'h6fc0;
    crc16_array[148] = 16'haf01;
    crc16_array[147] = 16'h6d40;
    crc16_array[146] = 16'had81;
    crc16_array[145] = 16'hacc1;
    crc16_array[144] = 16'h6c00;
    crc16_array[143] = 16'ha441;
    crc16_array[142] = 16'h6480;
    crc16_array[141] = 16'h65c0;
    crc16_array[140] = 16'ha501;
    crc16_array[139] = 16'h6740;
    crc16_array[138] = 16'ha781;
    crc16_array[137] = 16'ha6c1;
    crc16_array[136] = 16'h6600;
    crc16_array[135] = 16'h6240;
    crc16_array[134] = 16'ha281;
    crc16_array[133] = 16'ha3c1;
    crc16_array[132] = 16'h6300;
    crc16_array[131] = 16'ha141;
    crc16_array[130] = 16'h6180;
    crc16_array[129] = 16'h60c0;
    crc16_array[128] = 16'ha001;
    crc16_array[127] = 16'he041;
    crc16_array[126] = 16'h2080;
    crc16_array[125] = 16'h21c0;
    crc16_array[124] = 16'he101;
    crc16_array[123] = 16'h2340;
    crc16_array[122] = 16'he381;
    crc16_array[121] = 16'he2c1;
    crc16_array[120] = 16'h2200;
    crc16_array[119] = 16'h2640;
    crc16_array[118] = 16'he681;
    crc16_array[117] = 16'he7c1;
    crc16_array[116] = 16'h2700;
    crc16_array[115] = 16'he541;
    crc16_array[114] = 16'h2580;
    crc16_array[113] = 16'h24c0;
    crc16_array[112] = 16'he401;
    crc16_array[111] = 16'h2c40;
    crc16_array[110] = 16'hec81;
    crc16_array[109] = 16'hedc1;
    crc16_array[108] = 16'h2d00;
    crc16_array[107] = 16'hef41;
    crc16_array[106] = 16'h2f80;
    crc16_array[105] = 16'h2ec0;
    crc16_array[104] = 16'hee01;
    crc16_array[103] = 16'hea41;
    crc16_array[102] = 16'h2a80;
    crc16_array[101] = 16'h2bc0;
    crc16_array[100] = 16'heb01;
    crc16_array[ 99] = 16'h2940;
    crc16_array[ 98] = 16'he981;
    crc16_array[ 97] = 16'he8c1;
    crc16_array[ 96] = 16'h2800;
    crc16_array[ 95] = 16'h3840;
    crc16_array[ 94] = 16'hf881;
    crc16_array[ 93] = 16'hf9c1;
    crc16_array[ 92] = 16'h3900;
    crc16_array[ 91] = 16'hfb41;
    crc16_array[ 90] = 16'h3b80;
    crc16_array[ 89] = 16'h3ac0;
    crc16_array[ 88] = 16'hfa01;
    crc16_array[ 87] = 16'hfe41;
    crc16_array[ 86] = 16'h3e80;
    crc16_array[ 85] = 16'h3fc0;
    crc16_array[ 84] = 16'hff01;
    crc16_array[ 83] = 16'h3d40;
    crc16_array[ 82] = 16'hfd81;
    crc16_array[ 81] = 16'hfcc1;
    crc16_array[ 80] = 16'h3c00;
    crc16_array[ 79] = 16'hf441;
    crc16_array[ 78] = 16'h3480;
    crc16_array[ 77] = 16'h35c0;
    crc16_array[ 76] = 16'hf501;
    crc16_array[ 75] = 16'h3740;
    crc16_array[ 74] = 16'hf781;
    crc16_array[ 73] = 16'hf6c1;
    crc16_array[ 72] = 16'h3600;
    crc16_array[ 71] = 16'h3240;
    crc16_array[ 70] = 16'hf281;
    crc16_array[ 69] = 16'hf3c1;
    crc16_array[ 68] = 16'h3300;
    crc16_array[ 67] = 16'hf141;
    crc16_array[ 66] = 16'h3180;
    crc16_array[ 65] = 16'h30c0;
    crc16_array[ 64] = 16'hf001;
    crc16_array[ 63] = 16'h1040;
    crc16_array[ 62] = 16'hd081;
    crc16_array[ 61] = 16'hd1c1;
    crc16_array[ 60] = 16'h1100;
    crc16_array[ 59] = 16'hd341;
    crc16_array[ 58] = 16'h1380;
    crc16_array[ 57] = 16'h12c0;
    crc16_array[ 56] = 16'hd201;
    crc16_array[ 55] = 16'hd641;
    crc16_array[ 54] = 16'h1680;
    crc16_array[ 53] = 16'h17c0;
    crc16_array[ 52] = 16'hd701;
    crc16_array[ 51] = 16'h1540;
    crc16_array[ 50] = 16'hd581;
    crc16_array[ 49] = 16'hd4c1;
    crc16_array[ 48] = 16'h1400;
    crc16_array[ 47] = 16'hdc41;
    crc16_array[ 46] = 16'h1c80;
    crc16_array[ 45] = 16'h1dc0;
    crc16_array[ 44] = 16'hdd01;
    crc16_array[ 43] = 16'h1f40;
    crc16_array[ 42] = 16'hdf81;
    crc16_array[ 41] = 16'hdec1;
    crc16_array[ 40] = 16'h1e00;
    crc16_array[ 39] = 16'h1a40;
    crc16_array[ 38] = 16'hda81;
    crc16_array[ 37] = 16'hdbc1;
    crc16_array[ 36] = 16'h1b00;
    crc16_array[ 35] = 16'hd941;
    crc16_array[ 34] = 16'h1980;
    crc16_array[ 33] = 16'h18c0;
    crc16_array[ 32] = 16'hd801;
    crc16_array[ 31] = 16'hc841;
    crc16_array[ 30] = 16'h0880;
    crc16_array[ 29] = 16'h09c0;
    crc16_array[ 28] = 16'hc901;
    crc16_array[ 27] = 16'h0b40;
    crc16_array[ 26] = 16'hcb81;
    crc16_array[ 25] = 16'hcac1;
    crc16_array[ 24] = 16'h0a00;
    crc16_array[ 23] = 16'h0e40;
    crc16_array[ 22] = 16'hce81;
    crc16_array[ 21] = 16'hcfc1;
    crc16_array[ 20] = 16'h0f00;
    crc16_array[ 19] = 16'hcd41;
    crc16_array[ 18] = 16'h0d80;
    crc16_array[ 17] = 16'h0cc0;
    crc16_array[ 16] = 16'hcc01;
    crc16_array[ 15] = 16'h0440;
    crc16_array[ 14] = 16'hc481;
    crc16_array[ 13] = 16'hc5c1;
    crc16_array[ 12] = 16'h0500;
    crc16_array[ 11] = 16'hc741;
    crc16_array[ 10] = 16'h0780;
    crc16_array[  9] = 16'h06c0;
    crc16_array[  8] = 16'hc601;
    crc16_array[  7] = 16'hc241;
    crc16_array[  6] = 16'h0280;
    crc16_array[  5] = 16'h03c0;
    crc16_array[  4] = 16'hc301;
    crc16_array[  3] = 16'h0140;
    crc16_array[  2] = 16'hc181;
    crc16_array[  1] = 16'hc0c1;
    crc16_array[  0] = 16'h0000;
    while (len--)
    begin // {
       local_reg = reflect (pkt[offset], 8);
       crc       = (crc >> 8) ^ crc16_array[(crc ^ local_reg) & 8'hff];
       offset++;
    end // }
    crc = reflect (crc, 16);
    crc16 = (crc);
  endfunction : crc16 // }
  
  function bit [31:0] reflect (bit [31:0] v, int b); // {
    int        i;
    bit [31:0] t = v;
    for (i = 0; i < b; i++)
    begin // {
        if (t & 1)                                                               
          v |= 1 << ((b-1)-i);
        else
          v &= ~(1 << ((b-1)-i));
        t   >>=1;
    end // }
    reflect = v;
  endfunction : reflect // }

endclass: HDLC_packet
