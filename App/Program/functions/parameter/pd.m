function pd = pd(n,limitVal,step)
%PD この関数の概要をここに記述
%   詳細説明をここに記述
pd=zeros(1,n);
    for i=1:n-1
        pd(1)=limitVal;
        pd(i+1)=pd(i)-step;
    end
%     disp('pdを生成');
end

