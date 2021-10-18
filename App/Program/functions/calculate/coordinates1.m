function [NEXTROW,SETTOPROW,SIZE] = coordinates1(SIZE,TOPROW,CHAR1,T)
%COORDINATES1 この関数の概要をここに記述
%   詳細説明をここに記述
    SETTOPROW = TOPROW;
    NEXTROW = TOPROW + SIZE*T;
    fprintf('%sは%d～%d\n',CHAR1,TOPROW,TOPROW + SIZE*T*3-1)
    if SIZE == 1
            for i = 1:T
            fprintf('%s(%d) %d\n',CHAR1,i,TOPROW)
            TOPROW = TOPROW+1;
            end
    else
        for i = 1:T
            fprintf('%s(%d) %d～%d\n',CHAR1,i,TOPROW+0*SIZE,TOPROW+1*SIZE-1)
            TOPROW = TOPROW+SIZE;
        end
    end
    fprintf('\n')
    SIZE = SIZE*T;
end
