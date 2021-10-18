function [A,NEWCOL] = besideArray(A,TOPCOL,TOPROW,ROWSIZE,T,NUM,Char,FLAG)
    UNIT = ROWSIZE/(3*T);
    for j = 0:T*3-1
        for i = 0:UNIT-1
            A(TOPCOL+j,TOPROW+i+j*UNIT) = NUM;
        end
    end
    
    if FLAG == 0
        NEWCOL = TOPCOL;
    else
        NEWCOL = TOPCOL+T*3;
    end
    fprintf('%s\n値：%d\n場所：(%d,%d)→(%d,%d)\n\n',Char,NUM,TOPCOL,TOPROW,TOPCOL+T*3-1,TOPROW+ROWSIZE-1)
end

