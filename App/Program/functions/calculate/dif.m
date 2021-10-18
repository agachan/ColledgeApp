function difVal = dif(Val,TIMES,DIRECTION)
%FDIF この関数の概要をここに記述
%   詳細説明をここに記述
    ROW = size(Val,2);
    COL = size(Val,1);
    difVal = zeros(COL,ROW);
    if DIRECTION == 'HEAD'
        for j = 1:COL
            for i=2:ROW
            difVal(j,i)=TIMES*(-Val(j,i)+Val(j,i-1));
            end
            difVal(j,1) = -TIMES*Val(j,1);
        end
    elseif DIRECTION == 'TAIL'
        for j = 1:COL
            for i = 1:ROW-1
                difVal(j,ROW) = -Val(j,ROW);
                difVal(j,i) = TIMES*(-Val(j,i)+Val(j,i+1));
            end
        end
    end
end

