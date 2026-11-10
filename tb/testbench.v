module testbench();
    reg              clk;
    reg              reset;
    wire [31:0] WriteData, DataAdr;
    wire              MemWrite;
    
    // instantiate device to be tested
    top dut(clk, reset, WriteData, DataAdr, MemWrite);
    
    initial begin
        $dumpfile("sim.vcd");
        $dumpvars(0, dut);
        $monitor("time=%0t clk=%0b reset=%0b WriteData=%0h DataAdr=%0h MemWrite=%0b PC=%0h InstrF=%0h", $time, clk, reset, WriteData, DataAdr, MemWrite, dut.PC, dut.Instr);
    end
        
    // initialize test
    initial begin
        reset <= 1; # 22; reset <= 0;
    end

    // generate clock to sequence tests
    always begin
        clk <= 1; # 5; clk <= 0; # 5;
    end

    initial begin
        #280 $finish;
    end

    // check results
    always @(negedge clk) begin
        if(MemWrite) begin
            if(DataAdr == 100 & WriteData == 25) begin
                $display("Simulation succeeded");
                $finish;
            end else if (DataAdr != 96) begin
                $display("Simulation failed");
                $finish;
            end
        end
    end
endmodule