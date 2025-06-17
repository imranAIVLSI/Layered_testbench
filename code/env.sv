class env;
    virtual mem_interface buse;
    mailbox gen2driv;
    mailbox gen2scb;
    mailbox mon2scb;

    generator gen;
    driver driv;
    monitor mon;
    scoreboard scb;

    event gen_end;
    int repeat_count;

    function new(virtual mem_interface buse, int repeat_count);
        this.buse = buse;
        this.repeat_count = repeat_count;
        gen2driv = new();
        gen2scb = new();
        mon2scb = new();
        
        gen = new(gen2driv, gen2scb, gen_end, repeat_count);
        driv = new(buse, gen2driv);
        mon = new(buse, mon2scb);
        scb = new(gen2scb, mon2scb);
    endfunction

    task test();
        fork
            gen.run();
            driv.run();
            mon.run();
            scb.run();
        join_any
    endtask

    task post_test();
        wait(gen_end.triggered);
        $display("Generator has Finished Producing Transactions");
        $display("No. of Transactions Generated: %0d", repeat_count);
        wait (driv.trans_count >= repeat_count);
        wait (scb.trans_count >= repeat_count);
   
        $display("==============TEST COMPLETED================");
        $display("Drv received: %0d", driv.trans_count);
        $display("Scb received: %0d", scb.trans_count);
        $display("Total Errors: %0d", scb.error_count);
        $display("Total Pass: %0d", scb.pass);
        if(scb.error_count == 0)
            $display("DUT VERIFICATION SUCCESSFULL");
        else
            $display("DUT VERIFICATION FAILED");

    endtask

    task run();
        test();
        post_test();
        $finish;
    endtask

endclass