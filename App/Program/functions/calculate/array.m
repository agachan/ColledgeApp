function [Aeq,NEWCOL] = array(Aeq,TOPCOL,TOPROW,SIZE,NUM,Char,FLAG)
%ARRAY この関数の概要をここに記述
%   詳細説明をここに記述
    for i = 0:SIZE-1
        Aeq(TOPCOL,TOPROW+i) = NUM;
    end
    if FLAG == 0
        NEWCOL = TOPCOL;
    else
        NEWCOL = TOPCOL+1;
    end
    fprintf('%s\n値：%d\n場所：(%d,%d)→(%d,%d)\n\n',Char,NUM,TOPCOL,TOPROW,TOPCOL,TOPROW+SIZE-1)
end

