timeunit 1ns;
timeprecision 1ns;
module mem(mem_interface bus);

// input logic clk;
  
  logic [7:0] memory [31:0];
  
  always_ff@(posedge bus.clk) begin
    if(bus.rst) begin
      bus.data_out <= 0;
    end
    else begin
      if((bus.read==1) && (bus.write==0)) begin
        bus.data_out <= memory[bus.addr];
      end
      else if((bus.write==1) && (bus.read==0)) begin
        memory[bus.addr] <= bus.data_in;
      end
    end
end
endmodule