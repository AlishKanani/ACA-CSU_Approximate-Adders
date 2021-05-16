module aca_csu16_8(a,b,sum);
input [15:0] a,b;
output [16:0] sum;
wire [15:0] p,g;
wire appc,cout,c;

assign p = a^b;
assign g = a&b;
appc app(p[7:0],g[7:0],appc);
assign c = appc;

carry_look_ahead_8bit cla1(p[7:0], g[7:0], 1'b0 , sum[7:0], cout);
carry_look_ahead_8bit cla2(p[15:8], g[15:8], c, sum[15:8], sum[16]);
endmodule

module carry_look_ahead_8bit(p,g,cin,sum,cout);
  input [7:0] g,p;
  input cin;
  output [7:0] sum;
  output cout;
  wire gext,pext;
  wire [6:0] c, g1, p1;
  wire [5:0] g2, p2;
  
  assign gext = g[0] | p[0]&cin;
  assign c[0] = gext;
  PGgen pggen00(g1[0],p1[0],g[1],p[1],gext,pext);assign c[1] = g1[0];
  PGgen pggen01(g1[1],p1[1],g[2],p[2],g[1],p[1]); 
  PGgen pggen02(g1[2],p1[2],g[3],p[3],g[2],p[2]);
  PGgen pggen03(g1[3],p1[3],g[4],p[4],g[3],p[3]);
  PGgen pggen04(g1[4],p1[4],g[5],p[5],g[4],p[4]);
  PGgen pggen05(g1[5],p1[5],g[6],p[6],g[5],p[5]);
  PGgen pggen06(g1[6],p1[6],g[7],p[7],g[6],p[6]);

  assign g2[0] = g1[1] | p1[1]&gext; assign c[2] = g2[0];
  assign g2[1] = g1[2] | p1[2]&g1[0]; assign c[3] = g2[1];
  PGgen pggen12(g2[2],p2[2],g1[3],p1[3],g1[1],p1[1]);
  PGgen pggen13(g2[3],p2[3],g1[4],p1[4],g1[2],p1[2]);
  PGgen pggen14(g2[4],p2[4],g1[5],p1[5],g1[3],p1[3]);
  PGgen pggen15(g2[5],p2[5],g1[6],p1[6],g1[4],p1[4]);

  assign c[4] = g2[2] | p2[2]&gext;
  assign c[5] = g2[3] | p2[3]&g1[0];
  assign c[6] = g2[4] | p2[4]&g2[0];
  assign cout = g2[5] | p2[5]&g2[1];
  
  assign sum[0] = p[0]^cin;
  xor x[7:1](sum[7:1],p[7:1],c[6:0]);
endmodule

// module carry_look_ahead_8bit(p,g,cin,sum,cout);
//   input [7:0] g,p;
//   input cin;
//   output [7:0] sum;
//   output cout;
//   wire [7:0] c;
//   wire [3:0] g1, p1;
//   wire [1:0] g2, p2;
//   wire [1:0] g3, p3;
//   wire gext;
  
//   assign gext = g[0] | p[0]&cin;
//   assign c[0] = gext;

// assign g1[0] = g[1] | p[1]&gext; assign c[1] = g1[0]; 
// PGgen gen11(g1[1],p1[1],g[3],p[3],g[2],p[2]);
// PGgen gen12(g1[2],p1[2],g[5],p[5],g[4],p[4]);
// PGgen gen13(g1[3],p1[3],g[7],p[7],g[6],p[6]);

// PGgen gen20(g2[0],p2[0],g1[1],p1[1],g1[0],p1[0]);assign c[3] = g2[0];
// PGgen gen21(g2[1],p2[1],g1[3],p1[3],g1[2],p1[2]); 

// assign g3[0] = g1[2] | p1[2]&g2[0]; assign c[5] = g3[0];
// assign g3[1] = g2[1] | p2[1]&g2[0]; assign c[7] = g3[1];

// assign c[2] = g[2] | p[2]&g1[0];
// assign c[4] = g[4] | p[4]&g2[0];
// assign c[6] = g[6] | p[6]&g3[0];

//   assign sum[0] = p[0]^cin;
//   xor x[7:1](sum[7:1],p[7:1],c[6:0]);
//   assign cout = c[7];

// endmodule

module appc(p,g,cout);
  input [7:0] g,p;
  output cout;
  wire [3:0] g1, p1;
  wire [1:0] g2;
  wire p2;
  
assign g1[0] = g[1] | p[1]&g[0];
PGgen gen11(g1[1],p1[1],g[3],p[3],g[2],p[2]);
PGgen gen12(g1[2],p1[2],g[5],p[5],g[4],p[4]);
PGgen gen13(g1[3],p1[3],g[7],p[7],g[6],p[6]);

assign g2[0] = g1[1] | p1[1]&g1[0];
PGgen gen21(g2[1],p2,g1[3],p1[3],g1[2],p1[2]);

assign cout = g2[1] | p2&g2[0];
endmodule

module PGgen(G, P, Gi, Pi, GiPrev, PiPrev);
  output G, P;
  input Gi, Pi, GiPrev, PiPrev;
  
  assign G = (Gi) | (Pi&GiPrev);
  assign P = Pi&PiPrev;
endmodule