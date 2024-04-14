module MemoryModel;

  // Define parameters
  parameter MEM_SIZE = 64; // Number of locations
  parameter ENTRY_SIZE = 32; // Bits entry size
  parameter DATA_WIDTH = 8; // Bits per byte
  
  // Define memory array
  logic [DATA_WIDTH-1:0] memory [0:MEM_SIZE-1][0:(ENTRY_SIZE/DATA_WIDTH)-1];

  // Function to initialize memory with random values
  function automatic void initializeMemory();
    int i, j;
    for (i = 0; i < MEM_SIZE; i++) begin
      for (j = 0; j < (ENTRY_SIZE/DATA_WIDTH); j++) begin
        memory[i][j] = $random;
      end
    end
  endfunction

  // Function to print memory contents
  function automatic void printMemory();
    int i, j;
    $display("Memory Contents:");
    for (i = 0; i < MEM_SIZE; i++) begin
      $write("[%0d]: ", i);
      for (j = 0; j < (ENTRY_SIZE/DATA_WIDTH); j++) begin
        $write("%h ", memory[i][j]);
      end
      $display("");
    end
  endfunction

  // Function to complement last 3 bytes of each entry
  function automatic void complementLastThreeBytes();
    int i, j;
    for (i = 0; i < MEM_SIZE; i++) begin
      for (j = (ENTRY_SIZE/DATA_WIDTH)-3; j < (ENTRY_SIZE/DATA_WIDTH); j++) begin
        memory[i][j] = ~memory[i][j];
      end
    end
  endfunction

  // Initial block to demonstrate memory operations
  initial begin
    // Initialize memory
    initializeMemory();
    // Print original memory contents
    printMemory();
    // Complement last 3 bytes of each entry
    complementLastThreeBytes();
    // Print modified memory contents
    $display("\nMemory Contents After Complementing Last 3 Bytes:");
    printMemory();
  end

endmodule

/*
Output: 

Memory Contents:
[0]: 24 81 09 63 
[1]: 0d 8d 65 12 
[2]: 01 0d 76 3d 
[3]: ed 8c f9 c6 
[4]: c5 aa e5 77 
[5]: 12 8f f2 ce 
[6]: e8 c5 5c bd 
[7]: 2d 65 63 0a 
[8]: 80 20 aa 9d 
[9]: 96 13 0d 53 
[10]: 6b d5 02 ae 
[11]: 1d cf 23 0a 
[12]: ca 3c f2 8a 
[13]: 41 d8 78 89 
[14]: eb b6 c6 ae 
[15]: bc 2a 0b 71 
[16]: 85 4f 3b 3a 
[17]: 7e 15 f1 d9 
[18]: 62 4c 9f 8f 
[19]: f8 b7 9f 5c 
[20]: 5b 89 49 d0 
[21]: d7 51 96 0c 
[22]: c2 c8 77 3d 
[23]: 12 7e 6d 39 
[24]: 1f d3 85 78 
[25]: 5b 49 3f 2a 
[26]: 58 86 8e 9c 
[27]: fa 26 73 a3 
[28]: 2f b3 5f 44 
[29]: f7 cb e6 5a 
[30]: 29 ed da 65 
[31]: b5 df 79 44 
[32]: d0 2a ab 0e 
[33]: dc 9a fd c3 
[34]: 56 4e 67 0a 
[35]: b6 38 79 b8 
[36]: 94 93 04 59 
[37]: db 4d d9 6d 
[38]: 76 ca b6 95 
[39]: 46 04 f7 69 
[40]: b4 88 28 2d 
[41]: c7 2e 08 1c 
[42]: fd 29 1c 86 
[43]: da 3d 66 70 
[44]: 73 ba 5e fa 
[45]: d5 1a b9 37 
[46]: 96 c0 26 b6 
[47]: 7d dc 86 78 
[48]: 7e db cf 79 
[49]: fa 61 17 a1 
[50]: 86 50 f5 35 
[51]: 29 c1 c5 98 
[52]: 4b 73 ec 8a 
[53]: 4e a8 a9 a1 
[54]: 0e e6 9f 2a 
[55]: 2a 8d 9e 38 
[56]: 79 c8 ca 13 
[57]: 6b c7 b6 ba 
[58]: c4 b9 92 b4 
[59]: 7f 86 fa f2 
[60]: 32 bd 84 e4 
[61]: ca a9 a1 8e 
[62]: fb 0b ef c9 
[63]: 36 75 8f 6b 

Memory Contents After Complementing Last 3 Bytes:
Memory Contents:
[0]: 24 7e f6 9c 
[1]: 0d 72 9a ed 
[2]: 01 f2 89 c2 
[3]: ed 73 06 39 
[4]: c5 55 1a 88 
[5]: 12 70 0d 31 
[6]: e8 3a a3 42 
[7]: 2d 9a 9c f5 
[8]: 80 df 55 62 
[9]: 96 ec f2 ac 
[10]: 6b 2a fd 51 
[11]: 1d 30 dc f5 
[12]: ca c3 0d 75 
[13]: 41 27 87 76 
[14]: eb 49 39 51 
[15]: bc d5 f4 8e 
[16]: 85 b0 c4 c5 
[17]: 7e ea 0e 26 
[18]: 62 b3 60 70 
[19]: f8 48 60 a3 
[20]: 5b 76 b6 2f 
[21]: d7 ae 69 f3 
[22]: c2 37 88 c2 
[23]: 12 81 92 c6 
[24]: 1f 2c 7a 87 
[25]: 5b b6 c0 d5 
[26]: 58 79 71 63 
[27]: fa d9 8c 5c 
[28]: 2f 4c a0 bb 
[29]: f7 34 19 a5 
[30]: 29 12 25 9a 
[31]: b5 20 86 bb 
[32]: d0 d5 54 f1 
[33]: dc 65 02 3c 
[34]: 56 b1 98 f5 
[35]: b6 c7 86 47 
[36]: 94 6c fb a6 
[37]: db b2 26 92 
[38]: 76 35 49 6a 
[39]: 46 fb 08 96 
[40]: b4 77 d7 d2 
[41]: c7 d1 f7 e3 
[42]: fd d6 e3 79 
[43]: da c2 99 8f 
[44]: 73 45 a1 05 
[45]: d5 e5 46 c8 
[46]: 96 3f d9 49 
[47]: 7d 23 79 87 
[48]: 7e 24 30 86 
[49]: fa 9e e8 5e 
[50]: 86 af 0a ca 
[51]: 29 3e 3a 67 
[52]: 4b 8c 13 75 
[53]: 4e 57 56 5e 
[54]: 0e 19 60 d5 
[55]: 2a 72 61 c7 
[56]: 79 37 35 ec 
[57]: 6b 38 49 45 
[58]: c4 46 6d 4b 
[59]: 7f 79 05 0d 
[60]: 32 42 7b 1b 
[61]: ca 56 5e 71 
[62]: fb f4 10 36 
[63]: 36 8a 70 94 


*/