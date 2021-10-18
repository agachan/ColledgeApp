function swf = makeSWF(R_P,RI_P,lambda,t)
%MAKESWF この関数の概要をここに記述
%   詳細説明をここに記述
swf = zeros(t,1);
for j=1:t
    for i=0:RI_P(4)-1
        swf=swf+lambda(RI_P(1)+i)*R_P(RI_P(1)+i)+lambda(RI_P(2)+i)*R_P(RI_P(2)+i)+lambda(RI_P(3)+i)*R_P(RI_P(3)+i);
    end
end

