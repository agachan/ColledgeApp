function f = farray(f,TOPROW,Val,Char)
%FARRAY この関数の概要をここに記述
%   詳細説明をここに記述
    SIZE = size(Val,2);
    for i = 0:SIZE-1
        f(1,TOPROW+i) = Val(1,i+1);
    end
    fprintf('%s \n場所：(%d,%d)→(%d,%d)\n\n',Char,1,TOPROW,1,TOPROW + SIZE -1)
end

