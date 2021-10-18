function [Result,Info] = saveFormat(x,TOP,SIZE,t)
%SAVEFORMAT この関数の概要をここに記述
%   詳細説明をここに記述
    UNIT = SIZE/t;
    Result = zeros(t,UNIT);
    for i = 1:t
        for j = 1:UNIT
            Result(i,j) = x((i-1)*UNIT+TOP+(j-1),1);
        end
    end
    Info = zeros(1,4);
    Info(1,1) = 1;
    Info(1,2) = UNIT*1/3+1;
    Info(1,3) = UNIT*2/3+1;
    Info(1,4) = UNIT/3;
end

