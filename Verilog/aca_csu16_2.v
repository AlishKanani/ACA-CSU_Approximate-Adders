module aca_csu16_2(a,b,sum);
input [15:0] a,b;
output [16:0] sum;
wire [15:0] p,g;
wire [6:0] appc,cout,c;
wire bp1,bp2,bp3,bp4,bp5,bp6;

assign p = a^b;
assign g = a&b;
assign appc[0] = g[1] | p[1]&g[0] ;
assign appc[1] = g[3] | p[3]&g[2] ;
assign bp1 = p[3]&p[2];
assign appc[2] = g[5] | p[5]&g[4] ;
assign bp2 = p[5]&p[4];
assign appc[3] = g[7] | p[7]&g[6] ;
assign bp3 = p[7]&p[6];
assign appc[4] = g[9] | p[9]&g[8] ;
assign bp4 = p[9]&p[8];
assign appc[5] = g[11] | p[11]&g[10] ;
assign bp5 =p[11]&p[10];
assign appc[6] = g[13] | p[13]&g[12] ;
assign bp6 =p[13]&p[12];

assign c[0] = appc[0];
csu cin2(bp1,appc[1],g[1],1'b0, 1'b0,c[1]);
csu cin3(bp2,appc[2],g[3],1'b0, 1'b0,c[2]);
csu cin4(bp3,appc[3],g[5],1'b0, 1'b0,c[3]);
csu cin5(bp4,appc[4],g[7],1'b0, 1'b0,c[4]);
csu cin6(bp5,appc[5],g[9],1'b0, 1'b0,c[5]);
csu cin7(bp6,appc[6],g[11],1'b0, 1'b0,c[6]);

carry_look_ahead_2bit cla1(p[1:0], g[1:0], 1'b0 , sum[1:0], cout[0]);
carry_look_ahead_2bit cla2(p[3:2], g[3:2], c[0] , sum[3:2], cout[1]);
carry_look_ahead_2bit cla3(p[5:4], g[5:4], c[1] , sum[5:4], cout[2]);
carry_look_ahead_2bit cla4(p[7:6], g[7:6], c[2] , sum[7:6], cout[3]);
carry_look_ahead_2bit cla5(p[9:8], g[9:8], c[3] , sum[9:8], cout[4]);
carry_look_ahead_2bit cla6(p[11:10], g[11:10], c[4] , sum[11:10], cout[5]);
carry_look_ahead_2bit cla7(p[13:12], g[13:12], c[5] , sum[13:12], cout[6]);
carry_look_ahead_2bit cla8(p[15:14], g[15:14], c[6] , sum[15:14], sum[16]);
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