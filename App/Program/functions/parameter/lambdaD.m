function lambdaD = lambdaD(size, limitVal, step)
%LAMBDAD パラメータlambdaGを生成する関数
%   lambdaG：ノードuにおける発電業者のoブロック目の入札価格[JPY\kMh]
%   先行研究では[20,19,18,17,16,15,14,13,12,11]
%需要入札価格
lambdaD = zeros(1,size);
lambdaD(1) = limitVal;
    for i=1:size -1
        lambdaD(1,i+1) = lambdaD(1,i) - step;
    end
%    disp('lambdaDを生成')
end

