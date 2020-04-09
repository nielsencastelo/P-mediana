% Cria a matriz de dist�ncia dos dados
% Autor: Nielsen C. Damasceno
% Data: 29/07/2014
% Entrada:
%       x s�o as amostras
% Sa�da:
%       r � a matriz de dist�ncia
function r = matriz_distancia(x)
    [lin,col] = size(x);
    r = zeros(lin,lin);
    for i = 1 : lin
        for j = 1 : lin
            soma = 0;
            for c = 1 : col
                soma = soma + (x(i,c) - x(j,c)) * (x(i,c) - x(j,c));
            end
            r(i,j) = sqrt(soma);
        end
    end
end
