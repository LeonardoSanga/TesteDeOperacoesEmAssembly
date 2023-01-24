// Testbench for MIPS processor

module mipstest();

  logic        clk;
  logic        reset;

  logic [31:0] writedata, dataadr;
  logic        memwrite;
  logic [31:0] pc, instr, readdata;
  integer i;
  string option;

  // instantiate device to be tested
  top dut(clk, reset, pc, instr, readdata, writedata, dataadr, memwrite);
  
  // gerando as formas de onda
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    $timeformat(-9, 0, "ns", 3);
  end
  
  // initialize test
  initial
    begin
      i = 1;
      reset <= 1; # 22; reset <= 0;
    end
  
  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end
  
  always @(instr) begin 
    #5;
    case (i)
      1 : option = "addi $v0 $zero 0x0007";
      2 : option = "addi $v1 $zero 0x0009";
      3 : option = "add $a0 $v0 $v1";
      4 : option = "sw $a0 0x0044 $zero";
    endcase
    $display("\nInstrucao %0d: %s",i,option);
    $display("clk = %b, reset = %b, pc = %2d, instr = %h, aluout = %2d, writedata = %2d, memwrite = %b, readdata = %0d", clk, reset, pc, instr, dataadr, writedata, memwrite, readdata);
    i = i + 1;
  end

  // check that 7 gets written to address 84
  always@(negedge clk)
    begin
      if(reset == 0)
      if(memwrite) begin
        if(dataadr === 68 & writedata === 16) begin
          $display("\nSimulation succeeded\n");
          $stop;
        end else if (dataadr !== 80) begin
          $display("\nSimulation failed\n");
          $stop;
        end
      end
    end
endmodule