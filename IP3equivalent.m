function IP3eq = IP3equivalent(IP3, G) %kanei return enan pinaka me IP3
IP3eq = zeros(1, length(G));
for i = 1:length(G)
    if IP3(i) == Inf
        IP3eq(i) = Inf;
    else    
        IP3eq(i) = IP3(i) - sum(G(1:i-1));
    end
end
end