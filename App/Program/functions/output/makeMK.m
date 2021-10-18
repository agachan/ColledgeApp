function mk = makeMK(pa,pdr,PDR_size,P_size,t)
%MAKEMK この関数の概要をここに記述
%   詳細説明をここに記述
drb=zeros(t,P_size);
mk=zeros(t,P_size);
for k = 1:t
    for i=1:PDR_size
        if drb(k,1)>pa(k,1)
            mk(k,1)=i-1;
        break
        end
        drb(k,1)=drb(k,1)+pdr(k,i);
    end

    for j=2:P_size
        for i=mk(k,j-1)+1:PDR_size
            if i==PDR_size
               mk(k,j)=i;
                break
            end
            if drb(k,j)>pa(k,j)-pa(k,j-1)
                mk(k,j)=i-1;
                break
            end
            drb(k,j)=drb(k,j)+pdr(k,i);
        end
    end
end
end

