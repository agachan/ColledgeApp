function [SubB,NEWCOL] = substitution(B,TOPCOL,TOPROW,Val,t,Char,FLAG)
%SUBSTITUTION この関数の概要をここに記述
%   詳細説明をここに記述
    COL = size(Val,1);
    ROW = size(Val,2);
    if FLAG == 0|| FLAG == 1
        for k = 0:t-1
            for i = 0:COL-1
                for j = 0:ROW-1
                    B(TOPCOL+i+k*COL,TOPROW+j+k*ROW) = Val(i+1,j+1);
                end
            end
        end
    elseif FLAG == 2||FLAG == 3
        for k = 0:t-1
            for i = 0:COL-1
                for j = 0:ROW-1
                    B(TOPCOL+i+k*COL,TOPROW+j) = Val(i+1,j+1);
                end
            end
        end
    end
    
    
    SubB = B;
    fprintf('%s\nサイズ：（縦%d，横：%d）\n場所：(%d,%d)→(%d,%d)\n\n',Char,COL,ROW,TOPCOL,TOPROW,TOPCOL+COL*t-1,TOPROW+ROW*t-1)
    if FLAG == 0 || FLAG == 2
        NEWCOL = TOPCOL;
    elseif FLAG == 1 || FLAG == 3
        NEWCOL = TOPCOL+COL;
    end
end

