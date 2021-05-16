module aca_csu16_4(a,b,sum);
input [15:0] a,b;
output [16:0] sum;
wire [15:0] p,g;
wire [2:0] appc,cout,c;
wire bp1,bp2;

assign p = a^b;
assign g = a&b;
appc app0(p[3:0],g[3:0],appc[0]);
appc app1(p[7:4],g[7:4],appc[1]);
appc app2(p[11:8],g[11:8],appc[2]);
assign bp1 = p[7]&p[6]&p[5]&p[4];
assign bp2 = p[11]&p[10]&p[9]&p[8];

assign c[0] = appc[0];
csu cin2(bp1,appc[1],g[3],1'b0,1'b0,c[1]);
csu cin3(bp2,appc[2],g[7],1'b0, 1'b0,c[2]);

carry_look_ahead_4bit cla1(p[3:0], g[3:0], 1'b0 , sum[3:0], cout[0]);
carry_look_ahead_4bit cla2(p[7:4], g[7:4], c[0], sum[7:4], cout[1]);
carry_look_ahead_4bit cla3(p[11:8], g[11:8], c[1], sum[11:8], cout[2]);
carry_look_ahead_4bit cla4(p[15:12], g[15:12], c[2], sum[15:12], sum[16]);
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

module csu(bp,cprdt,gin,ci,control,cout);
output cout;
input bp,cprdt,gin,ci,control;

assign cout = cprdt&(~bp) | (~control)&bp&gin | control&bp&ci;
endmodule

module PGgen(G, P, Gi, Pi, GiPrev, PiPrev);
  output G, P;
  input Gi, Pi, GiPrev, PiPrev;
  
  assign G = (Gi) | (Pi&GiPrev);
  assign P = Pi&PiPrev;
endmodule