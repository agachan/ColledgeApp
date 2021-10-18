function [NEXTROW,SETTOPROW,SIZE] = coordinates3(SIZE,TOPROW,CHAR1,CHAR2,CHAR3,T)
%COORDINATES3 この関数の概要をここに記述
%   詳細説明をここに記述
    SETTOPROW = TOPROW;
    NEXTROW = TOPROW + SIZE*T*3;
    fprintf('%sは%d～%d\n',CHAR1,TOPROW,TOPROW + SIZE*T*3-1)
    if SIZE == 1
            for i = 1:T
            fprintf('%s(%d) %d\n',CHAR1,i,TOPROW)
            fprintf('%s(%d) %d\n',CHAR2,i,TOPROW+1)
            fprintf('%s(%d) %d\n',CHAR3,i,TOPROW+2)
            TOPROW = TOPROW+3;
            end
    else
        for i = 1:T
            fprintf('%s(%d) %d～%d\n',CHAR1,i,TOPROW+0*SIZE,TOPROW+1*SIZE-1)
            fprintf('%s(%d) %d～%d\n',CHAR2,i,TOPROW+1*SIZE,TOPROW+2*SIZE-1)
            fprintf('%s(%d) %d～%d\n',CHAR3,i,TOPROW+2*SIZE,TOPROW+3*SIZE-1)
            TOPROW = TOPROW+3*SIZE;
        end
    end
    fprintf('\n')
    SIZE = SIZE*T*3;
    
end

