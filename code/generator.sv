class generator;
    transaction trans;
    mailbox gen2driv;
    mailbox gen2scoreboard;
    int repeat_count;
    event gen_done;


    function new(mailbox gen2driv, mailbox gen2scoreboard,
                event gen_done, int repeat_count);
    this.gen2driv = gen2driv;
    this.gen2scoreboard = gen2scoreboard;
    this.repeat_count = repeat_count;
    this.gen_done = gen_done;
    gen2driv = new();
    gen2scoreboard = new();
    // trans = new();
    endfunction

    task run();
        // string operation;
        bit ok;
        for(int i = 0; i < repeat_count; i++) begin
            trans = new();
            ok = trans.randomize();
            if(!ok) begin
                $display("Transactoion Randomization Failed");
                continue;
            end
            gen2driv.put(trans);
            gen2scoreboard.put(trans);
            // $display("===========Transaction No: %0d===========", i);
            // trans.display("Generator");
        end
        -> gen_done;
    endtask

endclass
