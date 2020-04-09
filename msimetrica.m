% A seguinte fun��o implementa uma matriz simetrica
%
% Entrada:  M � o n�mero de linhas da matriz
%           N � o numero de colunas da matriz
%
% Sa�da: 	a: � a matriz sim�trica
%
%
% Autor:    Nielsen C. Damasceno
% Data:     01.06.2012
function a = msimetrica(M,N)

    A = rand(M,N)*100;
    
    for i = 1:M
        A(i,i) = 0; 
    end
    
    for i = 1:M 
        for j = 1:N 
            A(i,j) = A(j,i); 
        end
    end
    a = ceil(A);
end