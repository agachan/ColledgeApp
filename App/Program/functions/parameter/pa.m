function pa = pa(m, pdr)
%PA パラメータpaを生成する関数
%pa：アグリゲータｍのノードuにおけるブロックmの入札価格
pa = zeros(1,m);
    for i=2:m
        pa(1)=sum(pdr)/m;
        pa(i)=pa(i-1)+sum(pdr)/m;
    end
%    disp('paを生成');
end

