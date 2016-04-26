
typedef struct {
         bit [8:0]  SFLAG;   // Begin flag
    rand bit [8:0]  ADDRESS; // 8 or more bits
    rand bit [8:0]  CONTROL; // What is this? 8 or 16bits
    rand bit [64:0] DATA;    // Random junk n * 8bits
         bit [16:0] CRC      // CRC 16 bit
         bit [8:0]  EFLAG    // End flag
} packet_t

class HDLC_packet;
    rand packet_t packet;
    packet.SFLAG = 01111110;
    packet.EFLAG = packet.SFLAG;
    packet.ADDRESS = 

// PSUDOKODE
    def generate_data():
        for i in range 8 to rand%8<:
            data = rand8bits

    

// END PSUDOKODE
	
endclass: HDLC_packet
