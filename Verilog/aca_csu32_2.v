module aca_csu32_2(a,b,sum);
input [31:0] a,b;
output [32:0] sum;
wire [31:0] p,g;
wire [14:0] appc,cout,c;
wire bp1,bp2,bp3,bp4,bp5,bp6,bp7,bp8,bp9,bp10,bp11,bp12,bp13,bp14;

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
assign appc[7] = g[15] | p[15]&g[14]  ;
assign bp7 = p[15]&p[14];
assign appc[8] = g[17] | p[17]&g[16]  ;
assign bp8 = p[17]&p[16];
assign appc[9] = g[19] | p[19]&g[18] ;
assign bp9 = p[19]&p[18];
assign appc[10] = g[21] | p[21]&g[20]  ;
assign bp10 = p[21]&p[20];
assign appc[11] = g[23] | p[23]&g[22]  ;
assign bp11 = p[23]&p[22];
assign appc[12] = g[25] | p[25]&g[24] ;
assign bp12 = p[25]&p[24];
assign appc[13] = g[27] | p[27]&g[26]  ;
assign bp13 = p[27]&p[26];
assign appc[14] = g[29] | p[29]&g[28]  ;
assign bp14 = p[29]&p[28];

assign c[0] = appc[0];
csu cin2(bp1,appc[1],g[1],1'b0, 1'b0,c[1]);
csu cin3(bp2,appc[2],g[3],1'b0, 1'b0,c[2]);
csu cin4(bp3,appc[3],g[5],1'b0, 1'b0,c[3]);
csu cin5(bp4,appc[4],g[7],1'b0, 1'b0,c[4]);
csu cin6(bp5,appc[5],g[9],1'b0, 1'b0,c[5]);
csu cin7(bp6,appc[6],g[11],1'b0, 1'b0,c[6]);
csu cin8(bp7,appc[7],g[13],1'b0, 1'b0,c[7]);
csu cin9(bp8,appc[8],g[15],1'b0, 1'b0,c[8]);
csu cin10(bp9,appc[9],g[17],1'b0, 1'b0,c[9]);
csu cin11(bp10,appc[10],g[19],1'b0, 1'b0,c[10]);
csu cin12(bp11,appc[11],g[21],1'b0, 1'b0,c[11]);
csu cin13(bp12,appc[12],g[23],1'b0, 1'b0,c[12]);
csu cin14(bp13,appc[13],g[25],1'b0, 1'b0,c[13]);
csu cin15(bp14,appc[14],g[27],1'b0, 1'b0,c[14]);

carry_look_ahead_2bit cla1(p[1:0], g[1:0], 1'b0 , sum[1:0], cout[0]);
carry_look_ahead_2bit cla2(p[3:2], g[3:2], c[0] , sum[3:2], cout[1]);
carry_look_ahead_2bit cla3(p[5:4], g[5:4], c[1] , sum[5:4], cout[2]);
carry_look_ahead_2bit cla4(p[7:6], g[7:6], c[2] , sum[7:6], cout[3]);
carry_look_ahead_2bit cla5(p[9:8], g[9:8], c[3] , sum[9:8], cout[4]);
carry_look_ahead_2bit cla6(p[11:10], g[11:10], c[4] , sum[11:10], cout[5]);
carry_look_ahead_2bit cla7(p[13:12], g[13:12], c[5] , sum[13:12], cout[6]);
carry_look_ahead_2bit cla8(p[15:14], g[15:14], c[6] , sum[15:14], cout[6]);
carry_look_ahead_2bit cla9(p[17:16], g[17:16], c[7] , sum[17:16], cout[7]);
carry_look_ahead_2bit cla10(p[19:18], g[19:18], c[8] , sum[19:18], cout[8]);
carry_look_ahead_2bit cla11(p[21:20], g[21:20], c[9] , sum[21:20], cout[9]);
carry_look_ahead_2bit cla12(p[23:22], g[23:22], c[10] , sum[23:22], cout[10]);
carry_look_ahead_2bit cla13(p[25:24], g[25:24], c[11] , sum[25:24], cout[11]);
carry_look_ahead_2bit cla14(p[27:26], g[27:26], c[12] , sum[27:26], cout[12]);
carry_look_ahead_2bit cla15(p[29:28], g[29:28], c[13] , sum[29:28], cout[13]);
carry_look_ahead_2bit cla16(p[31:30], g[31:30], c[14] , sum[31:30], sum[32]);
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