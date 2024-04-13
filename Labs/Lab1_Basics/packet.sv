module PacketGenerator;

  // Define packet types
  typedef enum {
    CONTROL = 2'b00,
    COMMAND = 2'b01,
    DATA = 2'b10
  } PacketType_t;

  // Define packet structure
  typedef struct packed {
    logic [7:0] packet_id;
    logic [31:0] packet_data;
    PacketType_t packet_type;
    time packet_sent_time;
  } Packet_s;

  // Function to generate random packet data
  function automatic logic [31:0] generateRandomData();
    generateRandomData = $random;
  endfunction

  // Function to generate random packet type
  function automatic PacketType_t generateRandomType();
    PacketType_t types[3] = '{CONTROL, COMMAND, DATA};
    generateRandomType = types[$random % 3];
  endfunction

  // Generate and display packets
  initial begin
    int signed packet_count;
    Packet_s pkt;

    $display("Packet ID | Packet Type | Packet Data | Packet Sent Time");
    $display("---------------------------------------------------------");

    // First packet is Control
    pkt.packet_id = 0;
    pkt.packet_data = generateRandomData();
    pkt.packet_type = CONTROL;
    pkt.packet_sent_time = $time;
    $display("%d | %s | %h | %0t", pkt.packet_id, "Control", pkt.packet_data, pkt.packet_sent_time);

    // Second packet is Command
    pkt.packet_id = 1;
    pkt.packet_data = generateRandomData();
    pkt.packet_type = COMMAND;
    pkt.packet_sent_time = $time;
    $display("%d | %s | %h | %0t", pkt.packet_id, "Command", pkt.packet_data, pkt.packet_sent_time);

    // Rest of the packets are Data
    for (packet_count = 2; packet_count <= 20; packet_count++) begin
      pkt.packet_id = packet_count;
      pkt.packet_data = generateRandomData();
      pkt.packet_type = DATA;
      pkt.packet_sent_time = $time;
      $display("%d | %s | %h | %0t", pkt.packet_id, "Data", pkt.packet_data, pkt.packet_sent_time);
    end
  end

endmodule

/*
Output: 
Packet ID | Packet Type | Packet Data | Packet Sent Time
---------------------------------------------------------
  0 | Control | 12153524 | 0
  1 | Command | c0895e81 | 0
  2 | Data | 8484d609 | 0
  3 | Data | b1f05663 | 0
  4 | Data | 06b97b0d | 0
  5 | Data | 46df998d | 0
  6 | Data | b2c28465 | 0
  7 | Data | 89375212 | 0
  8 | Data | 00f3e301 | 0
  9 | Data | 06d7cd0d | 0
 10 | Data | 3b23f176 | 0
 11 | Data | 1e8dcd3d | 0
 12 | Data | 76d457ed | 0
 13 | Data | 462df78c | 0
 14 | Data | 7cfde9f9 | 0
 15 | Data | e33724c6 | 0
 16 | Data | e2f784c5 | 0
 17 | Data | d513d2aa | 0
 18 | Data | 72aff7e5 | 0
 19 | Data | bbd27277 | 0
 20 | Data | 8932d612 | 0
*/