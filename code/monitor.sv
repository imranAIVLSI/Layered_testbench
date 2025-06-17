// `include "transaction.sv"
class monitor;
    virtual mem_interface buso;
    mailbox mon2scoreboard;

    function new(virtual mem_interface buso, mailbox mon2scoreboard);
        this.buso = buso;
        this.mon2scoreboard = mon2scoreboard;

    endfunction

    task run;
        transaction trans;
        // string operation;
        forever begin
            trans = new();
            
            @(posedge buso.clk);
            #1ns;
                trans.address = buso.addr;
                trans.data_out = buso.data_out;
                trans.read = buso.read;
                trans.data = buso.data_in;
                trans.write = buso.write;
                mon2scoreboard.put(trans); 
                // trans.display("Monitor");
        end

    endtask
endclass