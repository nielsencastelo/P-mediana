
% Fun��o que imprime os resultados
function mostra_resultado(n,p,pos)   
    for i = 1 : n - p
        fprintf('Usu�rios[%d] -> facilidade[%d]\n', i, pos(i));
    end
end