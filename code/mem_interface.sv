timeunit 1ns;
timeprecision 1ns;
interface mem_interface(input clk);
    // logic clk;
    bit read, write, rst;
    logic [4:0]addr;
    logic [7:0]data_in;
    bit [7:0]data_out;

    /*modport master ( // mem_test
    input data_out,clk, rst,
    output read, write, addr, data_in, import read_mem, write_mem, printstatus
    );

    modport slave ( // mem
        input read, write, addr, data_in,clk,rst,
        output data_out
    );
    bit debug = 1;
    // add read_mem and write_mem tasks
  task write_mem(input [4:0]address, input [7:0]data);
    
    @(negedge clk)
    addr = address;
    data_in = data;
    write = 1;
    read = 0;
    // @(posedge clk)
    // bus.write = 0;
    
    if(debug) begin
      $display("WRITE: addr = %0d,  ASCII Data = %c ", address, data);
    end
  endtask
    // read task
   task read_mem(input [4:0]address, output [7:0]r_data);
    @(negedge clk)
    addr = address;
    read = 1;
    write = 0;

    @(posedge clk)
    #1;
    r_data = data_out;
    
    if(debug) begin
    $display("READ: addr = %0d,  ASCII Data = %c ", address, r_data); 
    end
 endtask 
    // print function
   function void printstatus(input int status);
    if (status == 0)
      $display("TEST PASSED");
    else
      $display("TEST FAILED: %0d errors", status);
  endfunction

  */
  
endinterface 