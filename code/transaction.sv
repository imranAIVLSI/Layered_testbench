class transaction;
    // Class Properties
    rand bit read;
    rand bit write;
    randc bit[4:0]address;
    rand bit[7:0]data;
    bit [7:0]data_out;

    constraint rw_type {
        read == 1 -> write == 0;
        read == 0 -> write == 1;
        write == 1 -> read == 0;
        write == 0 -> read == 1;
    }

    // cover group
    covergroup cg ;
    c1: coverpoint address;
    c2: coverpoint data {
    bins up = {[8'h41:8'h5a]};
    bins lo = {[8'h61:8'h7a]};
    bins restof = default;
    }
    endgroup
    // constructor
    function new();
        address = 0;
        data = 0;
        read = 0;
        write = 1;
        // data_out = 0;
        cg = new();
    endfunction
    // display method
    function void display(string name);
        $display("\t==========%s Transaction======== ", name);
        $display("Address: %0d", address);
        $display("Data_in: %0h", data);
        $display("Read: %0b", read);
        $display("Write: %0b", write);
        $display("Data_out: %0h", data_out);
    endfunction
endclass
