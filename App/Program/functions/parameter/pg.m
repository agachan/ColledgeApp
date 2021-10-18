function pg = pg(m,initVal,step)
%PG パラメータpgを生成する関数
%pg：ノードuにおける需要ブロックnの入札価格
pg = zeros(1,m);
pg(1) = initVal;
    for i = 1:m-1
        pg(i+1) = pg(i) + step;
    end
%    disp('pgを生成')
end

