function appSum = ACA_CSU(N,M,K,num1,num2)

blks = ceil(N/M);
c = zeros(1,blks+1);
c = bitget(c,1);
AppSum = zeros(1,N);
AppSum = bitget(AppSum,1);

num1 = bitget(num1,1:N);
num2 = bitget(num2,1:N);
P = xor(num1,num2);
G = and(num1,num2);

for i = 1:blks
    if(i == 1)
        [AppSum(1:M),c(2)] = block(num1(1:M),num2(1:M),c(1));
      elseif ((i==2)&&(K>=M))
        [AppSum(((i-1)*M)+1:(i*M)),c(i+1)] = block(num1(((i-1)*M)+1:(i*M)),num2(((i-1)*M)+1:(i*M)),c(i));
      else
        c(i) = cinpre(P((i-1)*M-K:(i-1)*M),G((i-1)*M-K:(i-1)*M));
        [AppSum(((i-1)*M)+1:(i*M)),c(i+1)] = block(num1(((i-1)*M)+1:(i*M)),num2(((i-1)*M)+1:(i*M)),c(i));
    end
end
appSum = double(c(end))*power(2,N);
AppSum = double(AppSum);
for j = 1:N
    appSum = appSum + (power(2,j-1)*AppSum(j));
end
end