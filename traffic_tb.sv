`timescale 1ns / 1ns

// Include the UVM library
import uvm_pkg::*;

// Define the testbench module
module testbench;

    // Clock and reset signals
    logic clk;
    logic rst_n;

    // Instantiate the traffic light controller
    traffic_light_controller dut (
        .clk(clk),
        .rst_n(rst_n),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    // Declare the signals for driving the test
    logic red, yellow, green;

    // Testbench clock generation
    always #5 clk = ~clk;

    // Testbench reset generation
    initial begin
        rst_n = 0;
        #10;
        rst_n = 1;
        #10;
        repeat (100) @(posedge clk);
        $finish;
    end

    // Instantiate the test
    initial begin
        // Start UVM
        run_test();
    end

endmodule

// Define the test class
class traffic_light_test extends uvm_test;
    // Define the test sequence
    class traffic_light_sequence extends uvm_sequence#(bit);
        `uvm_object_utils(traffic_light_sequence)
        
        // Sequence body
        task body();
            forever begin
                #20;
                $display("Red: %b, Yellow: %b, Green: %b", dut.red, dut.yellow, dut.green);
            end
        endtask
    endclass

    // Define the test
    function new(string name = "traffic_light_test");
        super.new(name);
    endfunction

    // Define the test's main task
    task run_phase(uvm_phase phase);
        traffic_light_sequence seq;
        seq = traffic_light_sequence::type_id::create("traffic_light_sequence");
        seq.start(null);
    endtask

endclass

// Run the test
initial begin
    uvm_config_db#(uvm_object_wrapper)::set(null, "*", "default_sequence", traffic_light_test::type_id::get());
    run_test();
end
