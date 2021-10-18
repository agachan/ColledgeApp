function vector = matrix2vectorD(val1,val2,val3,TIMES,DIRECTION)
%MATRIX2VECTORD この関数の概要をここに記述
%   詳細説明をここに記述
    clear fdif
        param_1 = dif(val1,TIMES,DIRECTION);
        param_2 = dif(val2,TIMES,DIRECTION);
        param_3 = dif(val3,TIMES,DIRECTION);
    parameter = cat(2,param_1,param_2,param_3);
    COL = size(parameter,1);
    ROW = size(parameter,2);
    SIZE = COL*ROW;
    vector = zeros(1,SIZE);
    for t = 1:COL
        for i = 1:ROW
            vector(1,ROW*(t-1)+i) = parameter(t,i);
        end
    end
end