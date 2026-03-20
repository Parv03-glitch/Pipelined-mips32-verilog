three testbenches are provided here!!!

TEST BENCH 1
module test_mips32;
    reg clk1,clk2;
    integer k;
    pipe_MIPS mips(clk1,clk2);

    initial begin
        clk1 = 0 ; clk2 = 0;
        repeat(20) begin
            #5 clk1 = 1 ; #5 clk1 = 0 ;
            #5 clk2 = 1 ; #5 clk2 = 0 ;
        end
    end

    initial begin
        for(k=0;k<31;k++) mips.Reg[k] = k;
        mips.Mem[0] = 32'h2801000a; // addi 001010 0000 0000 0100 0000 0000 001010
        mips.Mem[1] = 32'h28020014; // addi
        mips.Mem[2] = 32'h28030019; // addi
        mips.Mem[3] = 32'h0ce77800; // or // dummy variable
        mips.Mem[4] = 32'h0ce77800; // op // dummy variable
        mips.Mem[5] = 32'h00222000; // add
        mips.Mem[6] = 32'h0ce77800; // or // dummy variable
        mips.Mem[7] = 32'h00832800; // add
        mips.Mem[8] = 32'hfc000000; // hlt
        
        mips.HALTED = 0;
        mips.PC = 0;
        mips.TAKEN_BRANCH = 0;

        #280
        for(k=0; k<6 ; k++) $display("R%1d - %1d", k , mips.Reg[k]);
    end
 
    initial begin
        $dumpfile("mips.vcd");
        $dumpvars(0,test_mips32);
        #300 $finish;
    end
endmodule
 -----------------------------
TEST BENCH 2
module test_mips32;
    reg clk1,clk2;
    integer k;
    pipe_MIPS mips(clk1,clk2);

    initial begin
        clk1 = 0 ; clk2 = 0;
        repeat(20) begin
            #5 clk1 = 1 ; #5 clk1 = 0 ;
            #5 clk2 = 1 ; #5 clk2 = 0 ;
        end
    end

    initial begin
        for(k=0;k<31;k++) mips.Reg[k] = k;
        mips.Mem[0] = 32'h28010078; // addi
        mips.Mem[1] = 32'h0c631800; // or // dummy variable
        mips.Mem[2] = 32'h20220000; // LW
        mips.Mem[3] = 32'h0c631800; // or // dummy variable
        mips.Mem[4] = 32'h2842002d; // andi
        mips.Mem[5] = 32'h0c631800; // or // dummy variable
        mips.Mem[6] = 32'h24220001; // add
        mips.Mem[7] = 32'hfc000000; // hlt
        mips.Mem[120] = 85;
        mips.HALTED = 0;
        mips.PC = 0;
        mips.TAKEN_BRANCH = 0;

        #500
        $display("mem[120] : %4d \nmem[121] : %4d", mips.Mem[120] , mips.Mem[121]);
    end
 
    initial begin
        $dumpfile("mips.vcd");
        $dumpvars(0,test_mips32);
        #600 $finish;
    end

endmodule

-----------------------------
Test bench 3
module test_mips32;
    reg clk1,clk2;
    integer k;
    pipe_MIPS mips(clk1,clk2);

    initial begin
        clk1 = 0 ; clk2 = 0;
        repeat(50) begin
            #5 clk1 = 1 ; #5 clk1 = 0 ;
            #5 clk2 = 1 ; #5 clk2 = 0 ;
        end
    end

    initial begin
        for(k=0;k<31;k++) mips.Reg[k] = k;
        mips.Mem[0] = 32'h280a00c8; // addi r10,r0,200
        mips.Mem[1] = 32'h28020001; // addi
        mips.Mem[2] = 32'h0e94a000; // or // dummy variable
        mips.Mem[3] = 32'h21430000; // LW
        mips.Mem[4] = 32'h0e94a000; // or // dummy variable
        mips.Mem[5] = 32'h14431000; // loop
        mips.Mem[6] = 32'h2c630001; // subi
        mips.Mem[7] = 32'h0e94a000; // or // dummy variable
        mips.Mem[8] = 32'h3460fffc; // bneqz (offset of -3 for loop to go on);
        mips.Mem[9] = 32'h2542fffe; // sw , r2,-2(r10);
        mips.Mem[10] = 32'hfc000000; // hlt

        mips.Mem[200] = 7;
        mips.HALTED = 0;
        mips.PC = 0;
        mips.TAKEN_BRANCH = 0;

        #2000
        $display("mem[200] : %2d \nmem[198] : %2d", mips.Mem[200] , mips.Mem[198]);
    end
 
    initial begin
        $dumpfile("mips.vcd");
        $dumpvars(0,test_mips32);
        $monitor("R2 : %4d", mips.Reg[2]);
        #3000 $finish;
    end

endmodule
