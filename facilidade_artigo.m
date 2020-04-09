% Autor: Nielsen C. Damasceno
% Data: 21/12/2012
% Problema das p-medianas a partir de uma matriz
% simétrica que contém as distâncias euclidiana e duas demandas

clc;close all; clear;

bairros = [1 3 5 3 7 2 8; ...
           7 5 3 8 2 6 5];
tb = length(bairros);

d = zeros(tb,tb);

% Visualiza a distância dos bairros
hold on;
for i = 1 : tb
    plot(bairros(1,i), bairros(2,i),'-mo','LineWidth',2,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','g',...
    'MarkerSize',8);
end
% Calcula a distância euclidiana dos bairros
for i = 1 : tb
    for j = 1 : tb
        d(i,j) = distH([bairros(1,i) bairros(2,i)],[bairros(1,j) bairros(2,j)]);
    end
end


p = 2;              % Quantidade de medianas a ser localizada

[n,m] = size(d);
custo = zeros(n,m);

H = ones(1,n); % Demanda (Hi) são todos 1's

% Calcula o custo: demanda(Hi) * distância (Dij)
for i = 1 : n
    for j  = 1 : m
        custo(i,j) = d(i,j) * H(i);
    end
end

% Variáveis principais
total = zeros(1,n);
F = zeros(p,1);      % Guarda as posições de cada mediana (as facilidades)
menor = zeros(p,1);  % Guarda o custo total de cada mediana
disposicao = zeros(p,1);
cont = 1;

for qtd = 1 : p
    if (p == 1) % Testa se existir somente 1-mediana e encontra a facilidade
        for i = 1 : n
            total(i) =  sum(custo(:,i));
        end
        [menor(qtd), F(qtd)] = min(total);
        fprintf('Custo da 1ª facilidade: %2.2f\n',menor(qtd));
        fprintf('E sua posição: %d\n', F(qtd));
        break;
    end
    % Passo 1: Se for maior que 2-mediana calcule todos as p-medianas
    for i = 1 : n
        total(i) =  sum(custo(:,i));
    end
    [menor(qtd), F(qtd)] = min(total);
    % Passo 2: zera toda linha
    for i = 1 : n
        custo(F(qtd),i) = 0;
    end
    % Passo 3: Calcula o min de cada custo em relação a facilidade
    % encontrada
    for i = 1 : n
        for j  = 1 : m
            custo(i,j) = min(custo(i,j),custo(i,F(qtd)));
        end
    end
    fprintf('Custo da %dª facilidade: %2.2f\n',qtd ,menor(qtd));
    fprintf('E sua posição: %d\n', F(qtd));
end
% Encontrou as Facilidades. Agora vamos determinar a localização dos
% usuários em relação as Facilidades
Facilidades = zeros(2,length(F));
for i = 1: length(F)
    Facilidades(:,i) = bairros(:,F(i));
end

for j = 1:length( bairros )
    for i = 1:length( Facilidades )
        %grupo das distancias associadas as facilidades
        a(i)= distH([Facilidades(1,i) Facilidades(2,i)],[bairros(1,j) bairros(2,j)]);

        plot(Facilidades(1,i),Facilidades(2,i),'ro');
        hold on
        plot(bairros(1,j),bairros(2,j),'b+')
        grid on
    end

    % usuarios correspondente as facilidades 
    [m(j), g(j)] = min(a);

    plot([bairros(1,j) Facilidades(1,g(j))],[bairros(2,j) Facilidades(2,g(j))],'g--');

end