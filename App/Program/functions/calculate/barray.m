function b = barray(b,COL,Val,Char)
%BARRAY この関数の概要をここに記述
%   詳細説明をここに記述
    SIZE = size(Val,2);
    for i = 0:SIZE-1
        b(COL+i,1) = Val(1,i+1);
    end
    fprintf('%s\nサイズ：%d\n場所：(%d,%d)→(%d,%d)\n\n',Char,SIZE,COL,1,COL+SIZE-1,1)
end

