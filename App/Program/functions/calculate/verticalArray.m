function [A,NEWCOL] = verticalArray(A,TOPCOL,TOPROW,ROWSIZE,COLSIZE,T,NUM,Char,FLAG)
    UNIT = COLSIZE/(3*T);
    for i = 0:ROWSIZE-1
        for j = 0:UNIT-1
            A(TOPCOL+j+i*UNIT,TOPROW+i) = NUM;
        end
    end
    
    if FLAG == 0
        NEWCOL = TOPCOL;
    else
        NEWCOL = TOPCOL+COLSIZE;
    end
    fprintf('%s\n値：%d\n場所：(%d,%d)→(%d,%d)\n\n',Char,NUM,TOPCOL,TOPROW,TOPCOL+COLSIZE-1,TOPROW+ROWSIZE-1)
end

