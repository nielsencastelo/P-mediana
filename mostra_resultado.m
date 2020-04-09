
% Função que imprime os resultados
function mostra_resultado(n,p,pos)   
    for i = 1 : n - p
        fprintf('Usuários[%d] -> facilidade[%d]\n', i, pos(i));
    end
end