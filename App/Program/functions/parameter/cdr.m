function cdr = cdr(t,lambdaG,SIZE,STEP)
%CDR この関数の概要をここに記述
%発電機コスト付近の一様分布　需要家コスト
UNIT = SIZE/STEP;
cdr = zeros(t,SIZE);
a=zeros(t,UNIT);
b=zeros(t,UNIT);
ROW = size(lambdaG,2);
COL = size(lambdaG,1);
    for i = 1:COL
        for j=1:ROW
            a(i,j)=lambdaG(i,j)*0.75;
            b(i,j)=lambdaG(i,j)*1.2;
        end
    end
    for k = 1:STEP
        for j = 1:t
            for i=1+(k-1)*UNIT:k*UNIT
                cdr(j,i)=(b(j,k)-a(j,k)).*rand(1,1)+a(j,k);
            end
        end
    end
    
%     for i=101:200
%         cdr(i)=(b(j,2)-a(j,2)).*rand(1,1)+a(j,2);
%     end
%     for i=201:300
%         cdr(i)=(b(3)-a(3)).*rand(1,1)+a(j,3);
%     end
%     for i=301:400
%         cdr(i)=(b(4)-a(4)).*rand(1,1)+a(j,4);
%     end
%     for i=401:500
%         cdr(i)=(b(5)-a(5)).*rand(1,1)+a(j,5);
%     end
%     for i=501:600
%         cdr(i)=(b(6)-a(6)).*rand(1,1)+a(j,6);
%     end
%     for i=601:700
%         cdr(i)=(b(7)-a(7)).*rand(1,1)+a(j,7);
%     end
%     for i=701:800
%         cdr(i)=(b(8)-a(8)).*rand(1,1)+a(j,8);
%     end
%     for i=801:900
%         cdr(i)=(b(9)-a(9)).*rand(1,1)+a(j,9);
%     end
%     for i=901:1000
%         cdr(i)=(b(10)-a(10)).*rand(1,1)+a(10);
%     end

end

