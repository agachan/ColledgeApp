function vector =  matrix2vector(val1,val2,val3)
%MATRIX2VECTOR この関数の概要をここに記述
%   詳細説明をここに記述
    parameter = cat(2,val1,val2,val3);
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

