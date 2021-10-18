function pdr = pdr(t, size, limitVal)
%PDR パラメータpdrを生成する関数
%   先行研究では[0.02, ... , 0.02] 1000列で生成
pdr = zeros(t, size);
    for i = 1:t
        for j = 1:size
        pdr(i,j) = limitVal;
        end
    end
%     disp('pdrを生成');
end

