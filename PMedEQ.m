function [m p] = PMedEQ(M,f)
%% Considerando o conjunto das Localidades abaixo:
%
% - | A | B | C | D | E
%
% Em que suas respectivas distancias estao contdas em uma matriz simetrica:
%
% - |  A  |  B  |  C  |  D  |  E
% A |  0  |  1  |  6  |  8  |  3
% B |  1  |  0  |  5  |  2  |  9
% C |  6  |  5  |  0  |  7  |  2
% D |  8  |  2  |  7  |  0  |  1
% E |  3  |  9  |  2  |  1  |  0
%
% Com Facilidades : A e C
% Com Usuarios:  B, D e E
% Retorna a distancia e da melhor facilidade para cada usuario

%% Ex:
%
% M = [0 1 6 8 3;
%      1 0 5 2 9;
%      6 5 0 7 2;
%      8 2 7 0 1;
%      3 9 2 1 0];
%
% f = [1 3]; % posicao em que se encontram as facilidades
%
% [m p] = PMedEQ(M,f)
%
% m =
%     1     2
% p =
%     2     5

%% Função:

a=zeros(1,size(M,1));
p=zeros(1,size(M,1));
m=zeros(1,size(M,1));

cnt=1;

for i=1:size(M,1)
    for k=1:length( f )
        if(i == f(k))
            for j = 1:size(M,1)
                if(M(i,j)>0)
                    a(cnt)= M(i,j);
                    cnt = cnt+1;
                end
            end
            m(k) = min(a(1:cnt-1));
            a = zeros(1,size(M,1));
            cnt = 1;
        end
        
    end
end


for k=1:length( f )
    
    for i=1:size(M,1)
        if(M(f(k),i)== m(k))
            p(k)= i;
        end
    end
end

m = m(1:length( f ));
p = p(1:length( f ));


end