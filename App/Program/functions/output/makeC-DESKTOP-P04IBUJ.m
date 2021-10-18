function [C,C1,C2,C3] = makeC(R,RI,t)
%MAKEC この関数の概要をここに記述
%   詳細説明をここに記述
    C1 = zeros(t,1);
    C2 = zeros(t,1);
    C3 = zeros(t,1);
    C  = zeros(t,1);
    for j = 1:t
        for i=0:RI(4)-1
            C1(j,1)=C1(j,1)+R(j,RI(1)+i);
            C2(j,1)=C2(j,1)+R(j,RI(2)+i);
            C3(j,1)=C3(j,1)+R(j,RI(3)+i);
        end
    end
    C = C1+C2+C3;
end

