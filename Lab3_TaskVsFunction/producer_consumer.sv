module ProducerConsumer;

  // Packet type definition
  typedef enum logic [1:0] {
    Message,
    Command,
    Control
  } PacketType_t;

  // Packet definition
  typedef struct packed {
    int ID;
    int sent_time;
    PacketType_t packet_type;
    bit [31:0] data;
  } Packet;


  // Define mailbox and mailbox size
  mailbox PacketMailbox = new();

  // Producer task
  task producer;
    Packet pkt;
    forever begin
      // Randomize packet
      pkt = randomize_packet();
      // Write packet to mailbox
      PacketMailbox.put(pkt);
      // Wait for 10ns
      #10;
    end
  endtask

  // Consumer task
  task consumer;
    Packet pkt;
    forever begin
      // Read packet from mailbox
      PacketMailbox.get(pkt);
      // Process packet
      process_packet(pkt);
      // Wait for 5ns
      #5;
    end
  endtask

  // Task to process packet
  task process_packet(Packet pkt);
    // Display packet information
    $display("Received packet: ID=%d, Sent Time=%d, Type=%s, Data=%h", pkt.ID, pkt.sent_time, pkt.packet_type.name, pkt.data);
  endtask

  // Task to randomize packet
  function Packet randomize_packet();
    Packet pkt;
    int unsigned random_positive_number;

    // Randomize packet fields
    pkt.ID = $random;
    pkt.sent_time = $time;
    random_positive_number = $urandom_range(0, 2);
    pkt.packet_type = PacketType_t'(random_positive_number);
    pkt.data = $random;
    return pkt;
  endfunction

  // Initial block to start producer and consumer tasks
  initial begin
    // Start producer and consumer tasks in parallel
    fork
      producer();
      consumer();
    join
  end

endmodule
