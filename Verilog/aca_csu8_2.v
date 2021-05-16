module aca_csu8_2(a,b,sum);
input [7:0] a,b;
output [8:0] sum;
wire [7:0] p,g;
wire [2:0] appc,cout,c;
wire bp1,bp2;

assign p = a^b;
assign g = a&b;
assign appc[0] = g[1] | p[1]&g[0] ;
assign appc[1] = g[3] | p[3]&g[2] ;
assign bp1 = p[3]&p[2];
assign appc[2] = g[5] | p[5]&g[4]  ;
assign bp2 = p[5]&p[4];

assign c[0] = appc[0];
csu cin2(bp1,appc[1],g[1],1'b0, 1'b0,c[1]);
csu cin3(bp2,appc[2],g[3],1'b0, 1'b0,c[2]);

carry_look_ahead_2bit cla1(p[1:0], g[1:0], 1'b0 , sum[1:0], cout[0]);
carry_look_ahead_2bit cla2(p[3:2], g[3:2], c[0] , sum[3:2], cout[1]);
carry_look_ahead_2bit cla3(p[5:4], g[5:4], c[1] , sum[5:4], cout[2]);
carry_look_ahead_2bit cla4(p[7:6], g[7:6], c[2] , sum[7:6], sum[8]);
endmodule

module carry_look_ahead_2bit(p,g, cin, sum,cout);
input [1:0] p,g;
input cin;
output [1:0] sum;
output cout;
wire [1:0] c;

assign c[0]=cin;
assign c[1]= g[0] | (p[0]&c[0]);
assign cout= g[1] | (p[1]&g[0]) | p[1]&p[0]&c[0];
assign sum=p^c; 
endmodule

module csu(bp,cprdt,gin,ci,control,cout);
output cout;
input bp,cprdt,gin,ci,control;

assign cout = cprdt&(~bp) | (~control)&bp&gin | control&bp&ci;
endmodule