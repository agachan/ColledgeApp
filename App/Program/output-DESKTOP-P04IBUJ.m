clearvars -except GETDATA_PASS RESULT_PASS PASS
%% パスの設定
OUTPUT_PASS = strcat(PASS,'\Program\functions\output'); 


cd(GETDATA_PASS)
List = ls;
col = size(List,1)-2;
row = size(List,2);
for i = 1:col
    chr = '';
    for j = 1:row
        chr = strcat(chr,List(i+2,j));
    end
    str = convertCharsToStrings(chr);
    load(str)
end
cd(RESULT_PASS)
load('Results.mat')



%% 変数の削除と階層を\Phase1\Program\functions\calculateに変更する．
cd(OUTPUT_PASS)
clearvars chr col i j GETDATA_PASS List row str CAL_PASS

%% 関数の設定
clear makeC
TIME = zeros(t,1);
f1 = zeros(t,1);
f2 = zeros(t,1);
f3 = zeros(t,1);
LMP1 = zeros(t,1);
LMP2 = zeros(t,1);
LMP3 = zeros(t,1);
for j = 1:t
    TIME(j,1) = j;
LMP1(j,1) = R_alpha(j,RI_alpha(1));
LMP2(j,1) = R_alpha(j,RI_alpha(2));
LMP3(j,1) = R_alpha(j,RI_alpha(3));
f1(j,1)=Bs(1)*(R_theta(j,RI_theta(1))-R_theta(j,RI_theta(2)));
f2(j,1)=Bs(2)*(R_theta(j,RI_theta(1))-R_theta(j,RI_theta(3)));
f3(j,1)=Bs(3)*(R_theta(j,RI_theta(2))-R_theta(j,RI_theta(3)));
end

%% AC,GC,DC アグリゲータ，発電事業者，需要
[AC,AC1,AC2,AC3] = makeC(R_PA,RI_PA,t);
[GC,GC1,GC2,GC3] = makeC(R_PG,RI_PG,t);
[DC,DC1,DC2,DC3] = makeC(R_PD,RI_PD,t);
%% fprintf('アグリゲータ%.3f\n発電事業者%.3f\n需要%.3f\n',AC,GC,DC);
for j = 1:t    
    fprintf('\nt=%d\n',j)
    fprintf('f1 %.3f\nf2 %.3f\nf3 %.3f\n',f1(j,1),f2(j,1),f3(j,1));
    fprintf('LMP1 %.3f\nLMP2 %.3f\nLMP3 %.3f\n',LMP1(j,1),LMP2(j,1),LMP3(j,1));
    fprintf('AC1 %.3f GC1 %.3f DC1 %.3f \n',AC1(j,1),GC1(j,1),DC1(j,1));
    fprintf('AC2 %.3f GC2 %.3f DC2 %.3f \n',AC2(j,1),GC2(j,1),DC2(j,1));
    fprintf('AC3 %.3f GC3 %.3f DC3 %.3f \n\n',AC3(j,1),GC3(j,1),DC3(j,1));
end
T = table(LMP1,LMP2,LMP3,AC1,GC1,DC1,AC2,GC2,DC2,AC3,GC3,DC3,...
    'RowNames',string(TIME));
writetable(T,strcat(RESULT_PASS,'\OUTPUT.xlsx'),'WriteRowNames',true)  

%需要家調達量ブロック
drb1=zeros(1,m);
mk1=zeros(1,m);
for i=1:N
    if drb1(1)>pa_1(1)
        mk1(1)=i-1;
    break
    end
    drb1(1)=drb1(1)+pdr_1(i);
end

for j=2:m
for i=mk1(j-1)+1:N
    if i==N
       mk1(j)=i;
        break
    end
    if drb1(j)>pa_1(j)-pa_1(j-1)
        mk1(j)=i-1;
        break
    end
    drb1(j)=drb1(j)+pdr_1(i);
end
end 

drb2=zeros(1,m);
mk2=zeros(1,m);
for i=1:N
    if drb2(1)>pa_2(1)
        mk2(1)=i-1;
    break
    end
    drb2(1)=drb2(1)+pdr_2(i);
end

for j=2:m
for i=mk2(j-1)+1:N
    if i==N
       mk2(j)=i;
        break
    end
    if drb2(j)>pa_2(j)-pa_2(j-1)
        mk2(j)=i-1;
        break
    end
    drb2(j)=drb2(j)+pdr_2(i);
end
end 

drb3=zeros(1,m);
mk3=zeros(1,m);
for i=1:N
    if drb3(1)>pa_3(1)
        mk3(1)=i-1;
    break
    end
    drb3(1)=drb3(1)+pdr_3(i);
end

for j=2:m
for i=mk3(j-1)+1:N
    if i==N
       mk3(j)=i;
        break
    end
    if drb3(j)>pa_3(j)-pa_3(j-1)
        mk3(j)=i-1;
        break
    end
    drb3(j)=drb3(j)+pdr_3(i);
end
end 
%%
drcost_1=zeros(1,m);
for i=1:mk1(1)
    drcost_1(1)=drcost_1(1)+pdr_1(i)*cdr_1(i);
end

for i=mk1(1)+1:mk1(2)
    drcost_1(2)=drcost_1(2)+pdr_1(i)*cdr_1(i);
end

for i=mk1(2)+1:mk1(3)
    drcost_1(3)=drcost_1(3)+pdr_1(i)*cdr_1(i);
end

for i=mk1(3)+1:mk1(4)
    drcost_1(4)=drcost_1(4)+pdr_1(i)*cdr_1(i);
end

for i=mk1(4)+1:mk1(5)
    drcost_1(5)=drcost_1(5)+pdr_1(i)*cdr_1(i);
end

for i=mk1(5)+1:mk1(6)
    drcost_1(6)=drcost_1(6)+pdr_1(i)*cdr_1(i);
end

for i=mk1(6)+1:mk1(7)
    drcost_1(7)=drcost_1(7)+pdr_1(i)*cdr_1(i);
end

for i=mk1(7)+1:mk1(8)
    drcost_1(8)=drcost_1(8)+pdr_1(i)*cdr_1(i);
end

for i=mk1(8)+1:mk1(9)
    drcost_1(9)=drcost_1(9)+pdr_1(i)*cdr_1(i);
end

for i=mk1(9)+1:mk1(10)
    drcost_1(10)=drcost_1(10)+pdr_1(i)*cdr_1(i);
end


drcost_2=zeros(1,m);
for i=1:mk2(1)
    drcost_2(1)=drcost_2(1)+pdr_2(i)*cdr_2(i);
end

for i=mk2(1)+1:mk2(2)
    drcost_2(2)=drcost_2(2)+pdr_2(i)*cdr_2(i);
end

for i=mk2(2)+1:mk2(3)
    drcost_2(3)=drcost_2(3)+pdr_2(i)*cdr_2(i);
end

for i=mk2(3)+1:mk2(4)
    drcost_2(4)=drcost_2(4)+pdr_2(i)*cdr_2(i);
end

for i=mk2(4)+1:mk2(5)
    drcost_2(5)=drcost_2(5)+pdr_2(i)*cdr_2(i);
end

for i=mk2(5)+1:mk2(6)
    drcost_2(6)=drcost_2(6)+pdr_2(i)*cdr_2(i);
end

for i=mk2(6)+1:mk2(7)
    drcost_2(7)=drcost_2(7)+pdr_2(i)*cdr_2(i);
end

for i=mk2(7)+1:mk2(8)
    drcost_2(8)=drcost_2(8)+pdr_2(i)*cdr_2(i);
end

for i=mk2(8)+1:mk2(9)
    drcost_2(9)=drcost_2(9)+pdr_2(i)*cdr_2(i);
end

for i=mk2(9)+1:mk2(10)
    drcost_2(10)=drcost_2(10)+pdr_2(i)*cdr_2(i);
end


drcost_3=zeros(1,m);
for i=1:mk3(1)
    drcost_3(1)=drcost_3(1)+pdr_3(i)*cdr_3(i);
end

for i=mk3(1)+1:mk3(2)
    drcost_3(2)=drcost_3(2)+pdr_3(i)*cdr_3(i);
end

for i=mk3(2)+1:mk3(3)
    drcost_3(3)=drcost_3(3)+pdr_3(i)*cdr_3(i);
end

for i=mk3(3)+1:mk3(4)
    drcost_3(4)=drcost_3(4)+pdr_3(i)*cdr_3(i);
end

for i=mk3(4)+1:mk3(5)
    drcost_3(5)=drcost_3(5)+pdr_3(i)*cdr_3(i);
end

for i=mk3(5)+1:mk3(6)
    drcost_3(6)=drcost_3(6)+pdr_3(i)*cdr_3(i);
end

for i=mk3(6)+1:mk3(7)
    drcost_3(7)=drcost_3(7)+pdr_3(i)*cdr_3(i);
end

for i=mk3(7)+1:mk3(8)
    drcost_3(8)=drcost_3(8)+pdr_3(i)*cdr_3(i);
end

for i=mk3(8)+1:mk3(9)
    drcost_3(9)=drcost_3(9)+pdr_3(i)*cdr_3(i);
end

for i=mk3(9)+1:mk3(10)
    drcost_3(10)=drcost_3(10)+pdr_3(i)*cdr_3(i);
end


PA_1b=zeros(t,m);
PA_2b=zeros(t,m);
PA_3b=zeros(t,m);
PA_1B=zeros(t,m);
PA_2B=zeros(t,m);
PA_3B=zeros(t,m);
for j = 1:t
for i=0:RI_PA(4)-1
    PA_1b(j,i+1)=R_PA(j,RI_PA(1)+i);
    PA_2b(j,i+1)=R_PA(j,RI_PA(2)+i);
    PA_3b(j,i+1)=R_PA(j,RI_PA(3)+i);
end


    PA_1B(j,:)=sort(PA_1b(j,:),'descend');
    PA_2B(j,:)=sort(PA_2b(j,:),'descend');
    PA_3B(j,:)=sort(PA_3b(j,:),'descend');
end


%% アグリゲータ入札価格
lambdaA_1B=zeros(1,m);
lambdaA_2B=zeros(1,m);
lambdaA_3B=zeros(1,m);
for i=0:RI_lambdaA(4)-1
    lambdaA_1B(i+1)=R_lambdaA(RI_lambdaA(1)+i);
    lambdaA_2B(i+1)=R_lambdaA(RI_lambdaA(2)+i);
    lambdaA_3B(i+1)=R_lambdaA(RI_lambdaA(3)+i);
end

DR1=0;
DR2=0;
DR3=0;
for i=0:RI_PDR(4)-1
    DR1=DR1+cdr_1(i+1)*R_PDR(RI_PDR(1)+i);
    DR2=DR2+cdr_2(i+1)*R_PDR(RI_PDR(2)+i);
    DR3=DR3+cdr_3(i+1)*R_PDR(RI_PDR(3)+i);
end
obA=R_alpha(RI_alpha(1))*AC1+R_alpha(RI_alpha(2))*AC2+R_alpha(RI_alpha(3))*AC3-DR1-DR2-DR3;

fprintf('obA %.3f\n fx %.3f\n',obA,f*x);

swfA=0;
swfG=0;
swfD=0;
for i=0:RI_PA(4)-1
    swfA=swfA+R_lambdaA(RI_lambdaA(1)+i)*R_PA(RI_PA(1)+i)+R_lambdaA(RI_lambdaA(2)+i)*R_PA(RI_PA(2)+i)+R_lambdaA(RI_lambdaA(3)+i)*R_PA(RI_PA(3)+i);
end
for i=0:RI_PA(4)-1
    swfG=swfG+lambdaG_1(i+1)*R_PG(RI_PG(1)+i)+lambdaG_2(i+1)*R_PG(RI_PG(2)+i)+lambdaG_3(i+1)*R_PG(RI_PG(3)+i);
end
for i=0:RI_PA(4)-1
    swfD=swfD+lambdaD_1(i+1)*R_PD(RI_PD(1)+i)+lambdaD_2(i+1)*R_PD(RI_PD(2)+i)+lambdaD_3(i+1)*R_PD(RI_PD(3)+i);
end
swf=swfD-swfG-swfA;
% fprintf('社会的余剰 %.3f\n',swf);


social1=-(R_rhomin(RI_rhomin(1))*fmax_1+R_rhomin(RI_rhomin(2))*fmax_2+R_rhomin(RI_rhomin(3))*fmax_3)-(R_rhomax(RI_rhomax(1))*fmax_1+R_rhomax(RI_rhomax(2))*fmax_2+R_rhomax(RI_rhomax(3))*fmax_3);


social2A_1=0;
social2A_1=social2A_1+R_phiAmax(RI_phiAmax(1))*pa_1(1);
for i=1:RI_phiAmax(4)-1
    social2A_1=social2A_1+R_phiAmax(RI_phiAmax(1)+i)*(pa_1(i+1)-pa_1(i-1));
end
social2G_1=0;
social2G_1=social2G_1+R_phiGmax(RI_phiGmax(1))*pg_1(1);
for i=1:RI_phiGmax(4)-1
    social2G_1=social2G_1+R_phiGmax(RI_phiGmax+i)*(pg_1(i)-pg_1(i-1));
end
social2D_1=0;
social2D_1=social2D_1+R_phiDmax(RI_phiDmax(1)+n)*pg_1(n);
for i=0:RI_phiDmax(4)-2
    social2D_1=social2D_1+R_phiDmax(RI_phiDmax(1)+i)*(pd_1(i)-pd_1(i+1));
end


social2A_2=0;
social2A_2=social2A_2+R_phiAmax(RI_phiAmax(2))*pa_2(1);
for i=1:RI_phiAmax(4)-1
    social2A_2=social2A_2+R_phiAmax(RI_phiAmax(2)+i)*(pa_2(i)-pa_2(i-1));
end
social2G_2=0;
social2G_2=social2G_2+R_phiGmax(RI_phiGmax(2))*pg_2(1);
for i=1:RI_phiGmax(4)-1
    social2G_2=social2G_2+R_phiGmax(RI_phiGmax(2)+i)*(pg_2(i)-pg_2(i-1));
end
social2D_2=0;
social2D_2=social2D_2+R_phiDmax(RI_phiDmax(2)+n)*pg_2(n);
for i=0:RI_phiDmax(4)-2
    social2D_2=social2D_2+R_phiDmax(RI_phiDmax(2)+i)*(pd_2(i)-pd_2(i+1));
end


social2A_3=0;
social2A_3=social2A_3+R_phiAmax(RI_phiAmax(3))*pa_3(1);
for i=1:RI_phiAmax(4)-1
    social2A_3=social2A_3+R_phiAmax(RI_phiAmax(3)+i)*(pa_3(i)-pa_3(i-1));
end
social2G_3=0;
social2G_3=social2G_3+R_phiGmax(RI_phiGmax(3))*pg_3(1);
for i=1:RI_phiGmax(4)-1
    social2G_3=social2G_3+R_phiGmax(RI_phiGmax(3)+i)*(pg_3(i)-pg_3(i-1));
end
social2D_3=0;
social2D_3=social2D_3+R_phiDmax(RI_phiDmax(3)+n)*pg_3(n);
for i=0:RI_phiDmax(4)-2
    social2D_3=social2D_3+R_phiDmax(RI_phiDmax(3)+i)*(pd_3(i)-pd_3(i+1));
end

swf2=social1-(social2A_1+social2A_2+social2A_3+social2G_1+social2G_2+social2G_3+social2D_1+social2D_2+social2D_3);

fprintf('社会的余剰 %.3f\n',-swf2);

%%アグリゲータ入札価格設定
flambdaA_1=zeros(1,m);
flambdaA_2=zeros(1,m);
flambdaA_3=zeros(1,m);

for i=1:m
if R_PA(RI_PA(1)+i)==0 && R_lambdaA(RI_lambdaA(1)+i) < drcost_1(i)
    flambdaA_1(i)=drcost_1(i);
end
end

for i=1:m
if  PA_1B(i)==0 && R_lambdaA(RI_lambdaA(1)+i) > drcost_1(i)
    flambdaA_1(i)=R_lambdaA(RI_lambdaA(1)+i);
end
end

if round(PA_1B(1)) == round(pa_1(1))
    flambdaA_1(1)=drcost_1(1);
end
for i=2:m
if round(PA_1B(i)) == round(pa_1(i)-pa_1(i-1))
    flambdaA_1(i)=drcost_1(i);
end
end

if  PA_1B(1) < pa_1(1) && PA_1B(1)~=0
    flambdaA_1(1)=R_lambdaA(RI_lambdaA(1))-10^(-6);
end
for i=2:m
if  PA_1B(i) < pa_1(i)-pa_1(i-1) && PA_1B(i)~=0
    flambdaA_1(i)=R_lambdaA(RI_lambdaA(1)+i)-10^(-6);
end
end
flambdaA_1(m)=drcost_1(m);



for i=1:m
if PA_2B(i)==0 && R_lambdaA(RI_lambdaA(2)+i) < drcost_2(i)
    flambdaA_2(i)=drcost_2(i);
end
end

for i=1:m
if  PA_2B(i)==0 && R_lambdaA(RI_lambdaA(2)+i) > drcost_2(i)
    flambdaA_2(i)=R_lambdaA(RI_lambdaA(2)+i);
end
end

if round(PA_2B(1)) == round(pa_2(1))
    flambdaA_2(1)=drcost_2(1);
end
for i=2:m
if round(PA_2B(i)) == round(pa_2(i)-pa_2(i-1))
    flambdaA_2(i)=drcost_2(i);
end
end

if  PA_2B(1) < pa_2(1) && PA_2B(1)~=0
    flambdaA_2(1)=R_lambdaA(RI_lambdaA(2)+1)-10^(-6);
end
for i=2:m
if  PA_2B(i) < pa_2(i)-pa_2(i-1) && PA_2B(i)~=0
    flambdaA_2(i)=R_lambdaA(RI_lambdaA(2)+i)-10^(-6);
end
end
flambdaA_2(m)=drcost_2(m);



for i=1:m
if PA_3B(i)==0 && R_lambdaA(RI_lambdaA(3)+i) < drcost_3(i)
    flambdaA_3(i)=drcost_3(i);
end
end

for i=1:m
if  PA_3B(i)==0 && R_lambdaA(RI_lambdaA(3)+i) > drcost_3(i)
    flambdaA_3(i)=R_lambdaA(RI_lambdaA(3)+i);
end
end

if round(PA_3B(1)) == round(pa_3(1))
    flambdaA_3(1)=drcost_3(1);
end
for i=2:m
if round(PA_3B(i)) == round(pa_3(i)-pa_3(i-1))
    flambdaA_3(i)=drcost_3(i);
end
end

if  PA_3B(1) < pa_3(1) && PA_3B(1)~=0
    flambdaA_3(1)=R_lambdaA(RI_lambdaA(3)+1)-10^(-6);
end
for i=2:m
if  PA_3B(i) < pa_3(i)-pa_3(i-1) && PA_3B(i)~=0
    flambdaA_3(i)=R_lambdaA(RI_lambdaA(3)+i)-10^(-6);
end
end
flambdaA_3(m)=drcost_3(m);

ofD_1=sort(lambdaD_1,'ascend');
ofD_2=sort(lambdaD_2,'ascend');
ofD_3=sort(lambdaD_3,'ascend');
figure('Name','Node1');
stairs(pd_1(1,:),ofD_1(1,:))
hold on
stairs(pg_1(1,:),lambdaG_1(1,:))
 stairs(pa_1(1,:),flambdaA_1)
hold off
xlabel('入札量')
ylabel('入札価格')

figure('Name','Node2');
stairs(pd_2(1,:),ofD_2(1,:))
hold on
stairs(pg_2(1,:),lambdaG_2(1,:))
stairs(pa_2(1,:),flambdaA_2)
hold off
xlabel('入札量')
ylabel('入札価格')

figure('Name','Node3');
stairs(pd_3(1,:),ofD_3(1,:))
hold on
stairs(pg_3(1,:),lambdaG_3(1,:))
stairs(pa_3(1,:),flambdaA_3)
hold off
xlabel('入札量')
ylabel('入札価格')
