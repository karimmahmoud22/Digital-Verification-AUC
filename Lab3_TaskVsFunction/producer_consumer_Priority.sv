module ProducerConsumer;

  // Packet type definition
  typedef enum logic [1:0] {
    Message,
    Command,
    Control
  } PacketType_t;

  // Packet priority definition
  typedef enum logic [1:0] {
    High,
    Medium,
    Low
  } Priority_t;

  // Packet definition
  typedef struct packed {
    int ID;
    int sent_time;
    PacketType_t packet_type;
    Priority_t packet_priority;
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
      // Wait for 5ns
      #5;
    end
  endtask

  // Consumer task
// Consumer task
task consumer;
  Packet pkt;
  Priority_t current_priority;
  forever begin
    // Search for high priority packets first
    if (PacketMailbox.try_get(pkt)) begin
      if (pkt.packet_priority == High) begin
        process_packet(pkt);
        current_priority = High;
      end
      else
        PacketMailbox.put(pkt); // Put the packet back if it's not high priority
    end
    // If no high priority packets found, search for medium priority packets
    else if (PacketMailbox.try_get(pkt)) begin
      if (pkt.packet_priority == Medium) begin
        process_packet(pkt);
        current_priority = Medium;
      end
      else
        PacketMailbox.put(pkt); // Put the packet back if it's not medium priority
    end
    // If no medium priority packets found, search for low priority packets
    else if (PacketMailbox.try_get(pkt)) begin
      if (pkt.packet_priority == Low) begin
        process_packet(pkt);
        current_priority = Low;
      end
      else
        PacketMailbox.put(pkt); // Put the packet back if it's not low priority
    end
    // Wait for 20ns
    #20;
  end
endtask

  // Task to process packet
  task process_packet(Packet pkt);
    // Display packet information
    $display("Received packet: ID=%d, Sent Time=%d, Type=%s, Priority=%s, Data=%h",
              pkt.ID, pkt.sent_time, pkt.packet_type.name, pkt.packet_priority.name, pkt.data);
  endtask

  // Task to randomize packet
  function Packet randomize_packet();
    Packet pkt;
    int unsigned random_type, random_priority;

    // Randomize packet fields
    pkt.ID = $random;
    pkt.sent_time = $time;
    random_type = $urandom_range(0, 2);
    pkt.packet_type = PacketType_t'(random_type);
    random_priority = $urandom_range(0, 2);
    pkt.packet_priority = Priority_t'(random_priority);
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
