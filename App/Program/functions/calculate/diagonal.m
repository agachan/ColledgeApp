function [SubB,NEWCOL] = diagonal(B,TOPCOL,TOPROW,SIZE,NUM,Char,FLAG)
%DIAGONAL この関数の概要をここに記述
%   詳細説明をここに記述
    for i = 0:SIZE-1
        B(TOPCOL+i,TOPROW+i) = NUM;
    end
    SubB = B;
    fprintf('%s\n値　：%d  サイズ：%d\n場所：(%d,%d)→(%d,%d)\n\n',Char,NUM,SIZE,TOPCOL,TOPROW,TOPCOL+SIZE-1,TOPROW+SIZE-1)
    if FLAG == 0
        NEWCOL = TOPCOL;
    else
        NEWCOL = TOPCOL + SIZE;
    end
end