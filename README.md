# Pipelined MIPS32 Processor (Verilog)

A 5-stage pipelined MIPS32 processor implemented in Verilog, using a dual-clock design (clk1 / clk2) to separate pipeline stages.

## Pipeline Stages

| Stage | Clock | Description |
|-------|-------|-------------|
| IF    | clk1  | Instruction Fetch |
| ID    | clk2  | Instruction Decode & Register Read |
| EX    | clk1  | Execute / ALU |
| MEM   | clk2  | Memory Access |
| WB    | clk1  | Write Back |

## Supported Instructions

| Type     | Instructions |
|----------|-------------|
| R-Type   | ADD, SUB, AND, OR, SLT, MUL |
| I-Type   | ADDI, SUBI, SLTI |
| Memory   | LW, SW |
| Branch   | BEQZ, BNEQZ |
| Control  | HLT |

## Files

| File | Description |
|------|-------------|
| `pipe_MIPS.v` | Main pipelined processor module |
| `tb_pipe_MIPS.v` | Testbenches (3 provided) |

## Testbenches

### TB1 – ADDI + ADD
Tests basic register-register and immediate arithmetic. Loads constants into registers, then adds them together.

### TB2 – ADDI + LW + ADDI + ADD
Tests memory load followed by arithmetic. Loads a value from `Mem[120]`, adds an immediate, then performs a register add.

### TB3 – Loop with BNEQZ (Factorial)
Tests branch instructions by computing 7! using a loop. Stores the result into `Mem[198]`.  

## How to Simulate

Using **Icarus Verilog**:

```bash
iverilog -o sim_out file_name test_benche_file_name 
vvp sim_out
```

View waveforms with **GTKWave**:

```bash
gtkwave mips.vcd
```

## Notes

- Dummy NOP instructions (using `OR`) are inserted between dependent instructions to handle data hazards manually.
- `TAKEN_BRANCH` flag suppresses incorrect instructions fetched after a branch.
- The processor halts when the `HLT` instruction reaches the WB stage.
