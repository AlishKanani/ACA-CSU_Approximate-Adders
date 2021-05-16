function [s,cout] = block (a,b,cin)
n = length(a);
s = zeros(1,n);
s = bitget(s,1:-1:1);
cout = false;
for i = 1:n
    s(i) = xor(a(i),xor(b(i),cin));
    cin = or(and(a(i),b(i)),or(and(b(i),cin),and(a(i),cin)));
end
cout = cin;
end