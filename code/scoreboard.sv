class scoreboard;
    mailbox gen2scoreboard;
    mailbox mon2scoreboard;
    int trans_count;
    int error_count;
    int mem_model [int];
    int pass;

    function new(mailbox gen2scoreboard, mailbox mon2scoreboard);
        this.gen2scoreboard = gen2scoreboard;
        this.mon2scoreboard = mon2scoreboard;
        this.trans_count = 0;
        this.error_count = 0;

    endfunction

    task run;
        transaction gen_trans, mon_trans;

        forever begin
            gen_trans=new();
            mon_trans=new();
            gen2scoreboard.get(gen_trans);
            mon2scoreboard.get(mon_trans);
            mon_trans.display("scb(mon)");
            if(gen_trans.write) 
            begin
                mem_model[gen_trans.address] = gen_trans.data;
            end

            if(mon_trans.read && mem_model.exists(mon_trans.address)) begin
                bit [7:0] expected_data = mem_model[mon_trans.address];
                bit [7:0] actual_data = mon_trans.data_out;
                    if(actual_data!= expected_data) begin
                        $error("Error! MISMATCH ==>     Addr %0d    Expected %0d    GOT %0d",
                             mon_trans.address, expected_data, actual_data);
                        error_count++;
                    end
                    else begin
                        $display("DATA MATCHED ==>     Addr %0d    Data %0d ", 
                            mon_trans.address, actual_data);
                        pass++;
                    end
                end
            trans_count++;
        end
    endtask

endclass