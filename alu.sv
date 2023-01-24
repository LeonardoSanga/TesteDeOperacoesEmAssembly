// alu.sv
// 17 September 2012 David_Harris@hmc.edu, Sarah_Harris@hmc.edu
//
// A 32-bit ALU

module alu(input  logic [31:0] a, b,
           input  logic [2:0]  f,
           output logic [31:0] y,
           output logic        zero);
           
  logic [31:0] bb, b2, add_res, and_res, or_res, slt_res;
  
  assign bb = ~b;
  assign b2 = f[2] ? bb : b;
  assign add_res = a + b2 + f[2]; // handle 2's complement
  assign and_res = a & b2;
  assign or_res  = a | b2;
  assign slt_res = add_res[31] ? 32'b1 : 32'b0;
  
  always_comb
    case (f[1:0])
      2'b00: y = and_res;
      2'b01: y = or_res;
      2'b10: y = add_res;
      2'b11: y = slt_res;
    endcase
    
  assign zero = (y == 32'b0);
endmodule