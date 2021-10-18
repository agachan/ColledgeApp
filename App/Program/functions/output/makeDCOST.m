function drcost = makeDCOST(pdr,cdr,RI_P,mk,t)
%MAKEDCOST この関数の概要をここに記述
%   詳細説明をここに記述
drcost=zeros(t,RI_P);
for k = 1:t
    for j=1:RI_P
        if j==1
            for i=1+1:mk(k,j)
                drcost(k,1)=drcost(k,1)+pdr(k,i)*cdr(k,i);
            end
        else
            for i=mk(k,j-1)+1:mk(k,j)
                drcost(k,j)=drcost(k,j)+pdr(k,i)*cdr(k,i);
            end
        end
    end
end
end

