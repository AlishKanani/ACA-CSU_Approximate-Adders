module aca_csu8_4(a,b,sum);
input [7:0] a,b;
output [8:0] sum;
wire [7:0] p,g;
wire appc,cout,c;

assign p = a^b;
assign g = a&b;
appc app0(p[3:0],g[3:0],appc);

assign c = appc;

carry_look_ahead_4bit cla1(p[3:0], g[3:0], 1'b0 , sum[3:0], cout);
carry_look_ahead_4bit cla2(p[7:4], g[7:4], c, sum[7:4], sum[8]);
endmodule


module carry_look_ahead_4bit(p,g,cin,sum,cout);
  input [3:0] g,p;
  input cin;
  output [3:0] sum;
  output cout;
  wire gext;
  wire [2:0] c, g1, p1;
  
  assign gext = g[0] | p[0]&cin;
  assign c[0] = gext;
  assign g1[0] = g[1] | p[1]&gext;  assign c[1] = g1[0];
  PGgen pggen01(g1[1],p1[1],g[2],p[2],g[1],p[1]); 
  PGgen pggen02(g1[2],p1[2],g[3],p[3],g[2],p[2]);

  assign c[2] = g1[1] | p1[1]&gext; 
  assign cout = g1[2] | p1[2]&g1[0]; 

  assign sum[0] = p[0]^cin;
  xor x[3:1](sum[3:1],p[3:1],c[2:0]);
endmodule

module appc(p,g,cout);
  input [3:0] g,p;
  output cout;
  wire [2:0] c, g1, p1;
  
  assign g1[0] = g[1] | p[1]&g[0];  
  PGgen pggen02(g1[2],p1[2],g[3],p[3],g[2],p[2]);

  assign cout = g1[2] | p1[2]&g1[0]; 
endmodule

module PGgen(G, P, Gi, Pi, GiPrev, PiPrev);
  output G, P;
  input Gi, Pi, GiPrev, PiPrev;
  
  assign G = (Gi) | (Pi&GiPrev);
  assign P = Pi&PiPrev;
endmodule