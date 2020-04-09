% Calcula o custo: demanda(Hi) * distância (Dij)
function custo = custoHD(d,H)
    [n, m] = size(d);
    custo = zeros(n,m);
    for i = 1 : n
        for j  = 1 : m
            custo(i,j) = d(i,j) * H(i);
        end
    end
end