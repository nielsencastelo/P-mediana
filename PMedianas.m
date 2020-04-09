% P-Medianas
clear
clc


% Conjunto das Localidades : exemplo

% - | A | B | C | D | E | F | G | H | I | J | K | L | M | N
% x | 
% y |

% Facilidades

% A, B e C

numF = 10; %numero de facilidades( esse numero deveser maior que 1)

Facilidades=rand(2,numF)*100;

% Usuarios

% D, E, F, G, H, I, J, K, L, M, N

numU = 100; % numero de usuarios 
 
Usuarios=rand(2,numU)*100;

% calcular adistanciade cada usuario para as facilidades

for j=1:length( Usuarios )

for i=1:length( Facilidades )
    
%grupo das distancias asossiadas as facilidades
a(i)=distH([Facilidades(1,i) Facilidades(2,i)],[Usuarios(1,j) Usuarios(2,j)]);

plot(Facilidades(1,i),Facilidades(2,i),'ro')
hold on
plot(Usuarios(1,j),Usuarios(2,j),'b+')
grid on

end

% usuarios corespondentes as facilidades 
[m(j) p(j)]=min(a);

plot([Usuarios(1,j) Facilidades(1,p(j))],[Usuarios(2,j) Facilidades(2,p(j))],'g--')

end


