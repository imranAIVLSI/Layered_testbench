module random_test;
    logic clk = 0;
    always #5 clk = ~clk;

    mem_interface bus(clk);

    mem DUT(.bus(bus));

    env env1;

    initial begin
        bus.rst = 1;
        @(posedge bus.clk);
        bus.rst = 0;
        @(posedge bus.clk);

        env1 = new(bus, 200);
        env1.run();
    end

endmodule