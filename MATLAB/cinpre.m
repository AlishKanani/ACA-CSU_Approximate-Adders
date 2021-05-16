function AppC = cinpre (P,G)
K = length(P);
AppC = bitget(0,1);
for i = K-1:-1:1
    P(i) = and(P(i),P(i+1));
    G(i) = and(G(i),P(i+1));
end
for j = 1:K
    AppC = or(G(j),AppC);
end
end