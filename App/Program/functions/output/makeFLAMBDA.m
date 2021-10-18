function flambdaA_1 = makeFLAMBDA(R,RI,PA_1B,drcost_1,pa_1,NUM,t)
%MAKEFLAMBDA この関数の概要をここに記述
%   詳細説明をここに記述
%%アグリゲータ入札価格設定
flambdaA_1=zeros(t,RI(4));
for j=1:t
for i=1:RI(4)
if PA_1B(j,i)==0 && R(j,RI(NUM)+(i-1)) < drcost_1(j,i)
    flambdaA_1(j,i)=drcost_1(j,i);
end
end

for i=1:RI(4)
if  PA_1B(j,i)==0 && R(j,RI(NUM)+i-1) > drcost_1(j,i)
    flambdaA_1(j,i)=R(j,RI(NUM)+i-1);
end
end

if round(PA_1B(j,1)) == round(pa_1(j,1))
    flambdaA_1(j,1)=drcost_1(j,1);
end

for i=2:RI(4)
if round(PA_1B(j,i)) == round(pa_1(j,i)-pa_1(j,i-1))
    flambdaA_1(j,i)=drcost_1(j,i);
end
end

if  PA_1B(j,1) < pa_1(j,1) && PA_1B(j,1)~=0
    flambdaA_1(j,1)=R(j,RI(NUM))-10^(-6);
end

for i=2:RI(4)
if  PA_1B(j,i) < pa_1(j,i)-pa_1(j,i-1) && PA_1B(j,i)~=0
    flambdaA_1(j,i)=R(j,RI(NUM)+i-1)-10^(-6);
end
end

flambdaA_1(j,RI(4))=drcost_1(j,RI(4));
end
end

