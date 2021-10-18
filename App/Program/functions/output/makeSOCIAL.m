function social = makeSOCIAL(R,RI,p,t)
%MAKESOCIAL この関数の概要をここに記述
%   詳細説明をここに記述
social=zeros(t,1);
social=social+R(RI(1))*p(1);
    for j=1:t
        for i=2:RI(4)
            social(j,1)=social(j,1)+R(j,RI(1)+i)*(p(j,i)-p(j,i-1));
        end
    end
end

