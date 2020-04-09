%% Grafos y Matrices
% Este demo da un explicación de la relación entre gráficos y matrices
%y
% una buena aplicación de las matrices SPARSE
%
% Copyright 1984-2005 The MathWorks, Inc.
% $Revision: 5.18.4.1 $ $Date: 2007/06/20 00:11:25 $

%%
% Un grafo es un conjunto de nodos con conexiones específicas entre
%ellos.
% Un ejemplo es la conectividad gráfica del domo geodésico de
%Buckminster
% Fuller (también un balón de fútbol o una molécula de carbono 60).

% En MATLAB, el grafo del domo geodésico puede ser generado con la
%función
% BUCKY.

% Definir las variables.
[B,V] = bucky;
H = sparse(60,60);
k = 31:60;
H(k,k) = B(k,k);

% Visualizar las variables
gplot(B-H,V,'b-');
hold on
gplot(H,V,'r-');
hold off
axis off equal

%%
% Un grafo puede ser representado por su matriz adyacente.
%
% Para construir la matriz adyacente, los nodos son numerados desde 1
%hasta
% N. Entonces el elemento (i,j) de la matriz se fija a 1 si el nodo i
%esta
% conectado al nodo j, y 0 si no es así.

% Definir una matriz A.
A = [0 1 1 0 ; 1 0 0 1 ; 1 0 0 1 ; 0 1 1 0];

% Crear una cuadro mostrando los nodos conectados.
cla
subplot(1,2,1);
gplot(A,[0 1;1 1;0 0;1 0],'.-');
text([-0.2, 1.2 -0.2, 1.2],[1.2, 1.2, -.2, -.2],('1234')', ...
    'HorizontalAlignment','center')
axis([-1 2 -1 2],'off')

% Crear un cuadro mostrando la matriz adyacente.
subplot(1,2,2);
xtemp=repmat(1:4,1,4);
ytemp=reshape(repmat(1:4,4,1),16,1)';
text(xtemp-.5,ytemp-.5,char('0'+A(:)),'HorizontalAlignment','center');
line([.25 0 0 .25 NaN 3.75 4 4 3.75],[0 0 4 4 NaN 0 0 4 4])
axis off tight

%%
% Aquí están los nodos en un hemisferio de la bola bucky, numerada
%polígono
% por polígono.

subplot(1,1,1);
gplot(B(1:30,1:30),V(1:30,:),'b-')
for j = 1:30,
    text(V(j,1),V(j,2),int2str(j),'FontSize',10);
end
axis off equal

%%
% Para visualizar la matriz adyacente de este hemisferio, usamos la
%función
% SPY para graficar la silueta de los elementos diferentes de cero.
%
% Note que la matriz es simétrica, siempre y cuando el nodo i este
% conectado al nodo j, entonces el nodo j esta conectado al nodo i.

spy(B(1:30,1:30))
title('spy(B(1:30,1:30))')

%%
% Ahora extendemos nuestro esquema numérico al grafo entero reflejando
%la
% numeración de un hemisferio en el otro.

[B,V] = bucky;
H = sparse(60,60);
k = 31:60;
H(k,k) = B(k,k);
gplot(B-H,V,'b-');
hold on
gplot(H,V,'r-');
for j = 31:60
    text(V(j,1),V(j,2),int2str(j), ...
        'FontSize',10,'HorizontalAlignment','center');
end
hold off
axis off equal

%%
% Finalmente, aquí hay una diagrama SPY de la matriz sparse final.

spy(B)
title('spy(B)')

%%
% En muchos grafos útiles, cada nodo esta conectado solo a algunos
%otros
% nodos. Consecuentemente, las matrices adyacentes contienen apenas
%algunas
% entradas distintas a cero por fila.
%
% Este demo ha mostrado un lugar en donde las matrices SPARSE se hacen
% prácticas

gplot(B-H,V,'b-');
axis off equal
hold on
gplot(H,V,'r-')
hold off

% Traducido al español por Ataraxiainc


displayEndOfDemoMessage(mfilename)