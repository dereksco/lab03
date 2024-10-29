 `timescale 1ns / 1ps

module tb_demo08;

    // Inputs
    reg clk;
    reg reset;
    reg coin_05;
    reg coin_1;

    // Outputs
    wire dispense;
    wire [1:0] change;

    // Instantiate the Vending Machine Module
    demo08 uut (
        .clk(clk),
        .reset(reset),
        .coin_05(coin_05),
        .coin_1(coin_1),
        .dispense(dispense),
        .change(change)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        coin_05 = 0;
        coin_1 = 0;
        
        // Reset the machine
        #10 reset = 0;
        
        // Test Case 1: Insert 1 yuan + 1 yuan (should dispense one beverage with no change)
        #10 coin_1 = 1;   // Insert 1 yuan
        #10 coin_1 = 0;   // Reset coin_1 signal
        #10 coin_1 = 1;   // Insert another 1 yuan
        #10 coin_1 = 0;   // Reset coin_1 signal

        // Check if dispense is asserted and change is 0
        #20;

        // Test Case 2: Insert 0.5 + 0.5 + 1 yuan (should dispense one beverage with no change)
        #10 coin_05 = 1;  // Insert 0.5 yuan
        #10 coin_05 = 0;  // Reset coin_05 signal
        #10 coin_05 = 1;  // Insert another 0.5 yuan
        #10 coin_05 = 0;  // Reset coin_05 signal
        #10 coin_1 = 1;   // Insert 1 yuan
        #10 coin_1 = 0;   // Reset coin_1 signal

        // Check if dispense is asserted and change is 0
        #20;

        // Test Case 3: Insert 1 + 0.5 + 0.5 yuan (should dispense one beverage with no change)
        #10 coin_1 = 1;   // Insert 1 yuan
        #10 coin_1 = 0;   // Reset coin_1 signal
        #10 coin_05 = 1;  // Insert 0.5 yuan
        #10 coin_05 = 0;  // Reset coin_05 signal
        #10 coin_05 = 1;  // Insert another 0.5 yuan
        #10 coin_05 = 0;  // Reset coin_05 signal

        // Check if dispense is asserted and change is 0
        #20;

        // Test Case 4: Insert 2.5 yuan (should dispense one beverage with 0.5 yuan change)
        #10 coin_1 = 1;   // Insert 1 yuan
        #10 coin_1 = 0;   // Reset coin_1 signal
        #10 coin_1 = 1;   // Insert another 1 yuan
        #10 coin_1 = 0;   // Reset coin_1 signal
        #10 coin_05 = 1;  // Insert 0.5 yuan
        #10 coin_05 = 0;  // Reset coin_05 signal

        // Check if dispense is asserted and change is 0.5
        #20;

        // Test Case 5: Insert 0.5 + 1 + 1 yuan (should dispense one beverage with 0.5 yuan change)
        #10 coin_05 = 1;  // Insert 0.5 yuan
        #10 coin_05 = 0;  // Reset coin_05 signal
        #10 coin_1 = 1;   // Insert 1 yuan
        #10 coin_1 = 0;   // Reset coin_1 signal
        #10 coin_1 = 1;   // Insert another 1 yuan
        #10 coin_1 = 0;   // Reset coin_1 signal

        // Check if dispense is asserted and change is 0.5
        #20;

        $finish;
    end

endmodule
