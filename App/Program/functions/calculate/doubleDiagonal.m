function [SubB,NEWCOL] = doubleDiagonal(B,TOPCOL,TOPROW,SIZE,NUM1,NUM2,Char,FLAG,T,l)
%DOUBLEDIAGONAL この関数の概要をここに記述
%   詳細説明をここに記述
    UNIT = SIZE/(3*T);
    
    for k = 0:T-1
         for j = 0:l-1
            for i = 0:UNIT-2
                B(TOPCOL+j*(UNIT-1)+k*(UNIT-1)+i,TOPROW+j*UNIT+k*UNIT+i) = NUM1;
                B(TOPCOL+j*(UNIT-1)+k*(UNIT-1)+i,TOPROW+j*UNIT+k*UNIT+i+1) = NUM2;
            end
        end
    end
    
    
    SubB = B;
    fprintf('%s\n値：%d,%d  サイズ：%d\n場所：(%d,%d)→(%d,%d)\n\n',Char,NUM1,NUM2,SIZE,TOPCOL,TOPROW,TOPCOL+SIZE-T-1,TOPROW+SIZE-1)
    if FLAG == 0
        NEWCOL = TOPCOL;
    else
        NEWCOL = TOPCOL + SIZE-T*3;
    end
end

