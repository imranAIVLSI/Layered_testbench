class driver;
    transaction trans;
    mailbox driv2gen;
    virtual mem_interface busa;
    int trans_count;

    function new(virtual mem_interface busa, mailbox driv2gen);
        trans = new();
        this.driv2gen = driv2gen;
        trans_count = 0;
        this.busa = busa;
    endfunction

    task run();
        // $display("**==================== Driver ======================**");
        forever begin
            trans = new();
            driv2gen.get(trans);
            // trans.display("Driver");
            @(negedge busa.clk);
                    busa.write <= trans.write;
                    busa.read <= trans.read;
                    busa.addr <= trans.address;
                    busa.data_in <= trans.data;
                    busa.data_out <= trans.data_out;

            trans_count++;
        end
    endtask

endclass