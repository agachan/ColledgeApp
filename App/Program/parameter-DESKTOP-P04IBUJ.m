%% ファイル説明
% パラメータの設定を行う
% Author:Aga Tomohiro
% Date: 2021/0924
clearvars -except PASS
%% 実行階層をProgram/functions/parameterに変更する
FUNCTIONS_PASS = strcat(PASS,'\Program\functions');
PARAMETER_PASS = strcat(FUNCTIONS_PASS,'\parameter');
SAVE_PASS = strcat(PASS,'\Datas\Params');

cd(FUNCTIONS_PASS)
SAVE_FOLDER = getTime('Param-');
cd(PARAMETER_PASS)
%% 実行規模の定数を策定
m=10;%アグリゲータの入札ブロック数
o=10;%発電業者の入札ブロック数%
n=10;%負荷の入札ブロック数
N=1000;%需要家人数
t = 48;
pv=1;%PV発電機数
l=3;%ノードの数
M=1e+30;

%% pdrを生成
pdr_1 = pdr(t,N,0.02);
pdr_2 = pdr(t,N,0.02);
pdr_3 = pdr(t,N,0.02);

%% lambdaG, lambdaD pa, pg, pdを生成
% 初期化する
lambdaG_1 = zeros(t,n);
lambdaG_2 = zeros(t,n);
lambdaG_3 = zeros(t,n);

lambdaD_1 = zeros(t,n);
lambdaD_2 = zeros(t,n);
lambdaD_3 = zeros(t,n);

pa_1 = zeros(t,m);
pa_2 = zeros(t,m);
pa_3 = zeros(t,m);

pg_1 = zeros(t,o);
pg_2 = zeros(t,o);
pg_3 = zeros(t,o);

pd_1 = zeros(t,n);
pd_2 = zeros(t,n);
pd_3 = zeros(t,n);

% ２次元配列にする
for i = 1:t
    lambdaG_1(i,:) = lambdaG(n,2);
    lambdaG_2(i,:) = lambdaG(n,2);
    lambdaG_3(i,:) = lambdaG(n,2);
    
    lambdaD_1(i,:) = lambdaD(n, 19, 1);
    lambdaD_2(i,:) = lambdaD(n, 19, 1);
    lambdaD_3(i,:) = lambdaD(n, 19, 1);
    
    pa_1(i,:) = pa(m, pdr_1(i,:));
    pa_2(i,:) = pa(m, pdr_2(i,:));
    pa_3(i,:) = pa(m, pdr_3(i,:));
    
    pg_1(i,:) = pg(o,1,1.5);
    pg_2(i,:) = pg(o,1,1.5); 
    pg_3(i,:) = pg(o,1,1.5);
    
    pd_1(i,:) = pd(n,30,3);
    pd_2(i,:) = pd(n,30,3);
    pd_3(i,:) = pd(n,30,3);
end

%% cdrを生成
cdr_1 = cdr(t,lambdaG_1,N,10);
cdr_2 = cdr(t,lambdaG_2,N,10);
cdr_3 = cdr(t,lambdaG_3,N,10);

%% B[s]を生成
Bs(1)=100;
Bs(2)=125;
Bs(3)=150;

%% 送電容量
fmax_1=1;
fmax_2=2;
fmax_3=2;

%% 風力発電上限
ppv_1=zeros(1,pv);
ppv_2=zeros(1,pv);
ppv_3=zeros(1,pv);

%% 保存の実行許可
RUN = input('Are You Redy To Save Datas [Y/N]---->','s');
if strcmp(RUN,'Y')
    %% パラメータを保存する
    save('params.mat','m','n','o','N','M','pv','l','t')
    save('Bs.mat','Bs')
    save('fmax.mat','fmax_1','fmax_2','fmax_3')
    save('ppv.mat','ppv_1','ppv_2','ppv_3')
    save('pa.mat','pa_1','pa_2','pa_3')
    save('pg.mat','pg_1','pg_2','pg_3')
    save('pd.mat','pd_1','pd_2','pd_3')
    save('cdr.mat','cdr_1','cdr_2','cdr_3')
    save('pdr.mat','pdr_1','pdr_2','pdr_3')
    save('lambdaG.mat','lambdaG_1','lambdaG_2','lambdaG_3')
    save('lambdaD.mat','lambdaD_1','lambdaD_2','lambdaD_3')
    %% フォルダ名の取得，作成，移動
    movefile('*.mat',SAVE_FOLDER)
    movefile(SAVE_FOLDER, SAVE_PASS)
    disp('Success! You can create New Params')
else
    disp('Stopped Save Data')
end
%% 実行階層をPhase1に戻す
cd(PASS)