function [B1,B2,B3] = makeB(SIZE,t,Val,FLAG)
%MAKEB この関数の概要をここに記述
%   詳細説明をここに記述
    Bb1=zeros(t,SIZE);
    Bb2=zeros(t,SIZE);
    Bb3=zeros(t,SIZE);
    B1=zeros(t,SIZE);
    B2=zeros(t,SIZE);
    B3=zeros(t,SIZE);
    for i = 1:t
        for j = 1:SIZE
        Bb1(i,j) = Val(i,j);
        Bb2(i,j) = Val(i,j+SIZE);
        Bb3(i,j) = Val(i,j+2*SIZE);
        end
    end
    
    if FLAG == 1
        B1 = sort(Bb1,'descend');
        B2 = sort(Bb2,'descend');
        B3 = sort(Bb3,'descend');
    end
end

