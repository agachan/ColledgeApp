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
lambdaG = cat(2,lambdaG_1,lambdaG_2,lambdaG_3);
lambdaD = cat(2,lambdaD_1,lambdaD_2,lambdaD_3);
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
LMP1(j,1) = R_alpha(j,RI_alpha(1));
LMP2(j,1) = R_alpha(j,RI_alpha(2));
LMP3(j,1) = R_alpha(j,RI_alpha(3));
end

for j = 1:t
TIME(j,1) = j;
f1(j,1)=Bs(1)*(R_theta(j,RI_theta(1))-R_theta(j,RI_theta(2)));
f2(j,1)=Bs(2)*(R_theta(j,RI_theta(1))-R_theta(j,RI_theta(3)));
f3(j,1)=Bs(3)*(R_theta(j,RI_theta(2))-R_theta(j,RI_theta(3)));
end

%% AC,GC,DC アグリゲータ，発電事業者，需要
[AC,AC1,AC2,AC3] = makeC(R_PA,RI_PA,t);
[GC,GC1,GC2,GC3] = makeC(R_PG,RI_PG,t);
[DC,DC1,DC2,DC3] = makeC(R_PD,RI_PD,t);


%% 需要家調達量ブロック
clear makeMK
mk1 = makeMK(pa_1,pdr_1,RI_PDR(4),RI_PA(4),t);
mk2 = makeMK(pa_2,pdr_2,RI_PDR(4),RI_PA(4),t);
mk3 = makeMK(pa_3,pdr_3,RI_PDR(4),RI_PA(4),t);
%%
clear makeDCOST
drcost_1 = makeDCOST(pdr_1,cdr_1,RI_PA(4),mk1,t);
drcost_2 = makeDCOST(pdr_2,cdr_2,RI_PA(4),mk2,t);
drcost_3 = makeDCOST(pdr_3,cdr_3,RI_PA(4),mk3,t);

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


clear makeSWF
swfA=makeSWF(R_PA,RI_PA,R_lambdaA,t);
swfG=makeSWF(R_PG,RI_PG,lambdaG,t);
swfD=makeSWF(R_PD,RI_PD,lambdaD,t);
swf=swfD-swfG-swfA;
% fprintf('社会的余剰 %.3f\n',swf);



clear makeSOCIAL
social2A_1 = makeSOCIAL(R_phiAmax,RI_phiAmax,pa_1,t);
social2G_1 = makeSOCIAL(R_phiGmax,RI_phiGmax,pg_1,t);
social2D_1 = makeSOCIAL(R_phiDmax,RI_phiDmax,pd_1,t);
social2A_2 = makeSOCIAL(R_phiAmax,RI_phiAmax,pa_2,t);
social2G_2 = makeSOCIAL(R_phiGmax,RI_phiGmax,pg_2,t);
social2D_2 = makeSOCIAL(R_phiDmax,RI_phiDmax,pd_2,t);
social2A_3 = makeSOCIAL(R_phiAmax,RI_phiAmax,pa_3,t);
social2G_3 = makeSOCIAL(R_phiGmax,RI_phiGmax,pg_3,t);
social2D_3 = makeSOCIAL(R_phiDmax,RI_phiDmax,pd_3,t);
%% アグリゲータ入札価格設定
flambdaA_1 = makeFLAMBDA(R_lambdaA,RI_lambdaA,PA_1B,drcost_1,pa_1,1,t);
flambdaA_2 = makeFLAMBDA(R_lambdaA,RI_lambdaA,PA_2B,drcost_2,pa_2,2,t);
flambdaA_3 = makeFLAMBDA(R_lambdaA,RI_lambdaA,PA_3B,drcost_3,pa_3,3,t);
ofD_1 = zeros(j,size(lambdaD_1,2));
ofD_2 = zeros(j,size(lambdaD_2,2));
ofD_3 = zeros(j,size(lambdaD_3,2));
for j = 1:t
ofD_1(j,:)=sort(lambdaD_1(j,:),'ascend');
ofD_2(j,:)=sort(lambdaD_2(j,:),'ascend');
ofD_3(j,:)=sort(lambdaD_3(j,:),'ascend');
end

obA=R_alpha(RI_alpha(1))*AC1+R_alpha(RI_alpha(2))*AC2+R_alpha(RI_alpha(3))*AC3-DR1-DR2-DR3;
social1=-(R_rhomin(RI_rhomin(1))*fmax_1+R_rhomin(RI_rhomin(2))*fmax_2+R_rhomin(RI_rhomin(3))*fmax_3)-(R_rhomax(RI_rhomax(1))*fmax_1+R_rhomax(RI_rhomax(2))*fmax_2+R_rhomax(RI_rhomax(3))*fmax_3);
swf2=-(social1-(social2A_1+social2A_2+social2A_3+social2G_1+social2G_2+social2G_3+social2D_1+social2D_2+social2D_3));
fx = zeros(j,1);
fx(1,1) = f*x;
%% fprintf('アグリゲータ%.3f\n発電事業者%.3f\n需要%.3f\n',AC,GC,DC);
for j = 1:t    
    fprintf('\n----------t=%d----------\n',j)
    fprintf('f1 %.3f\nf2 %.3f\nf3 %.3f\n',f1(j,1),f2(j,1),f3(j,1));
    fprintf('LMP1 %.3f\nLMP2 %.3f\nLMP3 %.3f\n',LMP1(j,1),LMP2(j,1),LMP3(j,1));
    fprintf('AC1 %.3f GC1 %.3f DC1 %.3f \n',AC1(j,1),GC1(j,1),DC1(j,1));
    fprintf('AC2 %.3f GC2 %.3f DC2 %.3f \n',AC2(j,1),GC2(j,1),DC2(j,1));
    fprintf('AC3 %.3f GC3 %.3f DC3 %.3f \n',AC3(j,1),GC3(j,1),DC3(j,1));
    fprintf('obA %.3f\n',obA(j,1))
    fprintf('社会的余剰 %.3f\n',swf2(j,1));
    fprintf('\n------------------------\n')
end
fprintf('fx %.3f\n',fx(1,1))
T = table(LMP1,LMP2,LMP3,f1,f2,f3,AC1,GC1,DC1,AC2,GC2,DC2,AC3,GC3,DC3,obA,swf2,fx,...
    'RowNames',string(TIME));
writetable(T,strcat(RESULT_PASS,'\OUTPUT.xlsx'),'WriteRowNames',true)


%% グラフの表示と保存
cd(RESULT_PASS)
for j = 1:t
    
    FOLDERNAME = strcat('FIG(t=',int2str(j),')');
    FOLDERPASS = strcat(RESULT_PASS,'\',FOLDERNAME);
    FILENAME1 = strcat(FOLDERPASS,'\Node1(t=',int2str(j),').png');
    FILENAME2 = strcat(FOLDERPASS,'\Node2(t=',int2str(j),').png');
    FILENAME3 = strcat(FOLDERPASS,'\Node3(t=',int2str(j),').png');
    mkdir(FOLDERNAME)
        figure('Name','Node1');
        stairs(pd_1(j,:),ofD_1(j,:))
        hold on
            stairs(pg_1(j,:),lambdaG_1(j,:))
            stairs(pa_1(j,:),flambdaA_1(j,:))
        hold off
    xlabel('入札量')
    ylabel('入札価格')
    saveas(gcf,FILENAME1);
    
    figure('Name','Node2');
    stairs(pd_2(j,:),ofD_2(j,:))
    hold on
    stairs(pg_2(j,:),lambdaG_2(j,:))
    stairs(pa_2(j,:),flambdaA_2(j,:))
    hold off
    xlabel('入札量')
    ylabel('入札価格')
    saveas(gcf,FILENAME2);

    figure('Name','Node3');
    stairs(pd_3(j,:),ofD_3(j,:))
    hold on
    stairs(pg_3(j,:),lambdaG_3(j,:))
    stairs(pa_3(j,:),flambdaA_3(j,:))
    hold off
    xlabel('入札量')
    ylabel('入札価格')
    saveas(gcf,FILENAME3);
    
    close all
end
cd(PASS)