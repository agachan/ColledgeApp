function [A,NEWCOL] = verticalArray(A,TOPCOL,TOPROW,ROWSIZE,COLSIZE,T,NUM,Char,FLAG)
    

if FLAG == 0 || FLAG == 1
    UNIT = COLSIZE/(3*T);
    for i = 0:ROWSIZE-1
        for j = 0:UNIT-1
            A(TOPCOL+j+i*UNIT,TOPROW+i) = NUM;
        end
    end
elseif FLAG == 2 || FLAG == 3
    UNIT = COLSIZE/T;
    for j = 0:T-1
        for i = 0:UNIT-1
            k = (i-rem(i,10))/(UNIT/3);
            A(TOPCOL+i+j*UNIT,TOPROW+k) = NUM;
        end
    end
end
    
    if FLAG == 0 || FLAG == 2
        NEWCOL = TOPCOL;
    elseif FLAG == 1 || FLAG == 3
        NEWCOL = TOPCOL+COLSIZE;
    end
    fprintf('%s\n値：%d\n場所：(%d,%d)→(%d,%d)\n\n',Char,NUM,TOPCOL,TOPROW,TOPCOL+COLSIZE-1,TOPROW+ROWSIZE-1)
end

