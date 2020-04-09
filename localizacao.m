% Fun��o que determinar a localiza��o dos usu�rios em rela��o 
% as Facilidades
function [disposicao, Fs] = localizacao(p,F,d)
    disposicao = zeros(p,1);
    [n,m] = size(d);
    Fs = sort(F);
    cont = 1;
    
    for i = 1 : n
        for j = 1 : m
            % Pula a diagonal principal pois � zero.
            % Se a coluna for igual a indices de F e Se a linha for 
            % diferente dos indices de F
            if (i ~= j && j == Fs(cont) && i ~= Fs(cont))
                disposicao(i,cont) = d(i,j);
                cont = cont + 1;
                if (cont > p)  % Garante que conta n�o vai ser maior
                    cont = p;  % que tam de F
                end
            end
        end
        cont = 1;
    end
end