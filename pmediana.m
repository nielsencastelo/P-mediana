% Autor: Nielsen C. Damasceno
% Data: 18/04/2013
% Problema das p-medianas a partir de uma matriz
% simétrica que contém as distâncias e duas demandas.
% Utiliza o Whitaker.
clc;close all; clear;

p = 5;                % Quantidade de medianas a ser localizada

[d,H] = instancias(); % Inicia as instâncias

[n,m] = size(d);
    
custo = custoHD(d,H); % Calcula o custo: demanda(Hi) * distância (Dij)

% Variáveis principais
total = zeros(1,n);
F = zeros(p,1);       % Guarda as posições de cada mediana (as facilidades)
menor = zeros(p,1);   % Guarda o custo total de cada mediana
cont = 1;

tic;
for k = 1 : p   
    if (p == 1) % Testa se existir somente 1-mediana e encontra a facilidade
        for i = 1 : n
            total(i) =  sum(custo(:,i));
        end
        [menor(k), F(k)] = min(total);
        fprintf('Custo da 1ª facilidade: %2.2f\n',menor(k));
        fprintf('E sua posição: %d\n', F(k));
        break;
    end
    % Passo 1: Se for maior que 2-mediana calcule todos as p-medianas
    for i = 1 : n
            total(i) =  sum(custo(:,i));
    end
    [menor(k), F(k)] = min(total);
    % Passo 2: zera toda linha
    for i = 1 : n
        custo(F(k),i) = 0;
    end
    % Passo 3: Calcula o min de cada custo em relação a facilidade
    % encontrada
    for i = 1 : n
        for j  = 1 : m
            custo(i,j) = min(custo(i,j),custo(i,F(k)));
        end
    end
    fprintf('Custo da %dª facilidade: %2.2f\n',k ,menor(k));
    fprintf('E sua posição: %d\n', F(k));
end 

% Encontrou as Facilidades. Agora vamos determinar a localização dos
% usuários em relação as Facilidades
[disposicao, Fs] = localizacao(p,F,d);

[men, pos] = menores(n,p,Fs,disposicao); % Encontra os menores

mostra_resultado(n,p,pos);

toc