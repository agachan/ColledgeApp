function lambdaG = lambdaG(size, step)
%LAMBDAG パラメータlambdaGを生成する関数
%   lambdaG：ノードuにおける発電業者のoブロック目の入札価格[JPY\kMh]
%   先行研究では[2,4,6,8,10,12,14,16,18,20]
lambdaG = zeros(1,size);
    for i = 1: size
        lambdaG(i) = i*step;
    end
%    disp('lamdaGを生成')
end

