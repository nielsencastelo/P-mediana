function [ fr , profit , p] = findOut( Sf, Su, fi, o1, o2 )
% Implementação de Whitaker

% - Entrada -
% Sf : (vetor) solução atual das facilidades -|---->soluçao atual
% Su : (vetor) solução atual dos usuarios    -|
% fi : candidato a inserção
% o1 : (vetor) facilidade(φ1) mais próxima de fi
% o2 : (vetor) facilidade(φ2) mais próxima de fi depois de φ1

% - Saída -
% fr : melhor candidato a remoção
% profit : valor da melhora da troca de fr por fi
% p : posição vetorial do candidato a remoção

% =========================================================================
% gain : (vetor) avalia os clientes beneficiados por (fi)
% netloos : perda devido a remoção de (fr)

gain=zeros(1,length(Sf));
netloss = zeros(1,length(Sf));%facilidade f pertencente a S

p=1;
posg=zeros(1,length(Sf));

 for u=1:length(Su)%usuário u pertencente a S
     if d(Su(u),fi) <= d(Su(u),o1(u))%ganho se fi está mais próximo de u
      gain(p)=d(Su(u),o1(u))-d(Su(u),fi);
      posg(p)=u;
      p=p+1;
     else %perda se a facilidade associada u é removida
      netloss(p)=+min([d(Su(u),fi),d(Su(u),o2(u))])-d(Su(u),o1(u));

     end
 end

[fr p_fr]=min(gain(1:p-1));
p =posg(p_fr);
profit=sum(gain)-netloss(p);
end

%d(u,f) = distancia ente u e f
function [ dr ] = d(u,f)
    dr=abs(diff([u f]));
end
