class comm_component;
  // Properties
  rand bit [7:0] data;
  rand bit [7:0] address;

  // Methods
  virtual function void Initialize();
    // Randomize data and address
    data = $random;
    address = $random;
  endfunction

  virtual task Display();
    // Display data and address
    $display("Data: %h, Address: %h", data, address);
  endtask

endclass

class Transmitter extends comm_component;
  // Additional properties and methods specific to Transmitter can be added here
endclass

class Receiver extends comm_component;
  // Additional properties and methods specific to Receiver can be added here
endclass

module transceiver;
  Transmitter tx;
  Receiver rx;

  initial begin
    // Initialize and display Transmitter and Receiver
    tx = new;
    rx = new;

    tx.Initialize();
    rx.Initialize();

    $display("Transmitter:");
    tx.Display();
    $display("Receiver:");
    rx.Display();
  end
endmodule
