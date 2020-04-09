function [m p] = PMedXY(Facilidades,Usuarios)
%% Considerando o conjunto das Localidades abaixo:
%
% - | A | B | C | D | E
%
% Em que suas respectivas posicoes x e y estao contidas em uma matriz como
% a mostrada abaixo:
%
% - | A | B | C | D | E
% x | 1 | 2 | 2 | 5 | 7
% y | 0 | 5 | 8 | 1 | 8
%
% Com Facilidades : A e C
% Com Usuarios:  B, D e E
% Plota um grafico mosrando as facilidades mais procias de cada usuario.
% Retorna a distancia e da melhor facilidade paracada usuario

%% Ex:
%
% Facilidades = [1 2; 0 8];
% Usuarios = [2 5 7; 5 2 8];
%
% [m p] = PMedXY(Facilidades,Usuarios)
%
% m =
%     3   4.4721    5
% p =
%     2     1       2

%% Função:
for j=1:length( Usuarios )
    for i=1:length( Facilidades )
        %grupo das distancias asossiadas as facilidades
        a(i)=distH([Facilidades(1,i) Facilidades(2,i)],[Usuarios(1,j) Usuarios(2,j)]);
        
        plot(Facilidades(1,i),Facilidades(2,i),'ro')
        hold on
        plot(Usuarios(1,j),Usuarios(2,j),'b+')
        grid on
    end
    % melhor facilidade paracada usuario
    [m(j) p(j)]=min(a);
    plot([Usuarios(1,j) Facilidades(1,p(j))],[Usuarios(2,j) Facilidades(2,p(j))],'g--')
end
end