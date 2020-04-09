% Função que encontra os menores
function [men, pos] = menores(n,p,Fs,disposicao)
    men = zeros(n - p,1);
    pos   = zeros(n - p,1);
    j = 1;
    cont = 1;
    % Encontra os menores
    for i = 1 : n
        if (i ~= Fs(cont)) % Não percorre a linha de F (só os usuarios)
            [men(j), pos(j)]= min(disposicao(i,:));
            j = j + 1;
        else
            if cont < p % Garante que cont não é maior que tam de F
            cont = cont + 1;
            end
        end
    end
end