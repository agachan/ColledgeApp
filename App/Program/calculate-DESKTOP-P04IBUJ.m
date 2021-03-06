%% ファイル説明
% 計算を行う
% Author:Aga Tomohiro
% Date: 2021/0924

clearvars -except PASS
%% データ取得パスを取得する
cd functions
SAVE_FOLDER = getTime('Result-');
CAL_PASS = strcat(PASS,'\Program\functions\calculate'); 
GET_PASS = strcat(PASS,'\Datas\Params');
SAVE_PASS = strcat(PASS,'\Datas\Results');
GETDATA_PASS = getDatas(GET_PASS, SAVE_PASS, SAVE_FOLDER);
%% データの読み取り
cd(GETDATA_PASS)
fprintf("データ一覧\n")
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

%% 変数の削除と階層を\Phase1\Program\functions\calculateに変更する．
cd(CAL_PASS)
clearvars chr col GET_PASS i j List row str
%% 関数の設定
clear coordinates3
clear coordinates1
clear diagonal
clear doubleDiagonal
clear matrix2vector
clear matrix2vectorD
clear substitution
clear array
clear barray
clear farray
clear verticalArray
clear besideArray


%% 列の設定
NEXTROW = 1;
[NEXTROW, alpha_top     ,alpha_size   ] = coordinates3(1 ,NEXTROW ,'alpha_1'  ,'alpha_2'  ,'alpha_3'  ,t);
[NEXTROW, PA_top        ,PA_size      ] = coordinates3(m ,NEXTROW ,'PA_1'     ,'PA_2'     ,'PA_3'     ,t);
[NEXTROW, PDR_top       ,PDR_size     ] = coordinates3(N ,NEXTROW ,'PDR_1'    ,'PDR_2'    ,'PDR_3'    ,t);
[NEXTROW, Ppv_top       ,Ppv_size     ] = coordinates3(pv,NEXTROW ,'Ppv_1'    ,'Ppv_2'    ,'Ppv_3'    ,t);
[NEXTROW, lambdaA_top   ,lambdaA_size ] = coordinates3(m ,NEXTROW ,'lambdaA_1','lambdaA_2','lambdaA_3',t);
[NEXTROW, PG_top        ,PG_size      ] = coordinates3(o ,NEXTROW ,'PG_1'     ,'PG_2'     ,'PG_3'     ,t);
[NEXTROW, PD_top        ,PD_size      ] = coordinates3(n ,NEXTROW ,'PD_1'     ,'PD_2'     ,'PD_3'     ,t);
[NEXTROW, theta_top     ,theta_size   ] = coordinates3(1 ,NEXTROW ,'theta_1'  ,'theta_2'  ,'theta_3'  ,t);
[NEXTROW, gamma_top     ,gamma_size   ] = coordinates1(1 ,NEXTROW ,'gamma'                            ,t);
[NEXTROW, rhomin_top    ,rhomin_size  ] = coordinates3(1 ,NEXTROW ,'rhomin_1' ,'rhomin_2' ,'rhomin_3' ,t);
[NEXTROW, rhomax_top    ,rhomax_size  ] = coordinates3(1 ,NEXTROW ,'rhomax_1' ,'rhomax_2' ,'rhomax_3' ,t);
[NEXTROW, phiAmin_top   ,phiAmin_size ] = coordinates3(m ,NEXTROW ,'phiAmin_1','phiAmin_2','phiAmin_3',t);
[NEXTROW, phiAmax_top   ,phiAmax_size ] = coordinates3(m ,NEXTROW ,'phiAmax_1','phiAmax_2','phiAmax_3',t);
[NEXTROW, phiGmin_top   ,phiGmin_size ] = coordinates3(o ,NEXTROW ,'phiGmin_1','phiGmin_2','phiGmin_3',t);
[NEXTROW, phiGmax_top   ,phiGmax_size ] = coordinates3(o ,NEXTROW ,'phiGmax_1','phiGmax_2','phiGmax_3',t);
[NEXTROW, phiDmin_top   ,phiDmin_size ] = coordinates3(n ,NEXTROW ,'phiDmin_1','phiDmin_2','phiDmin_3',t);
[NEXTROW, phiDmax_top   ,phiDmax_size ] = coordinates3(n ,NEXTROW ,'phiDmax_1','phiDmax_2','phiDmax_3',t);
[NEXTROW, umin_top      ,umin_size    ] = coordinates3(1 ,NEXTROW ,'u_min1'   ,'u_min2'   ,'u_min3'   ,t);
[NEXTROW, umax_top      ,umax_size    ] = coordinates3(1 ,NEXTROW ,'u_max1'   ,'u_min2'   ,'u_min3'   ,t);
[NEXTROW, uAmin_top     ,uAmin_size   ] = coordinates3(m ,NEXTROW ,'u_Amin1'  ,'u_Amin2'  ,'u_Amin3'  ,t);
[NEXTROW, uAmax_top     ,uAmax_size   ] = coordinates3(m ,NEXTROW ,'u_Amax1'  ,'u_Amin2'  ,'u_Amin3'  ,t);
[NEXTROW, uGmin_top     ,uGmin_size   ] = coordinates3(o ,NEXTROW ,'u_Gmin1'  ,'u_Gmin2'  ,'u_Gmin3'  ,t);
[NEXTROW, uGmax_top     ,uGmax_size   ] = coordinates3(o ,NEXTROW ,'u_Gmax1'  ,'u_Gmin2'  ,'u_Gmin3'  ,t);
[NEXTROW, uDmin_top     ,uDmin_size   ] = coordinates3(n ,NEXTROW ,'u_Dmin1'  ,'u_Dmin2'  ,'u_Dmin3'  ,t);
[NEXTROW, uDmax_top     ,uDmax_size   ] = coordinates3(n ,NEXTROW ,'u_Dmax1'  ,'u_Dmin2'  ,'u_Dmin3'  ,t);

%% パラメータ設定
% Bsの組み合わせの設定
NEQ1Bs = [-Bs(1)  Bs(1)  0    ; 
        -Bs(2)  0      Bs(2);
         0     -Bs(3)  Bs(3)];
NEQ2Bs = [Bs(1) -Bs(1) 0;
         -Bs(1) Bs(1) 0; 
         Bs(2) 0 -Bs(2);
         -Bs(2) 0 Bs(2);
         0 Bs(3) -Bs(3);
         0 -Bs(3) Bs(3)];
EQ1Bs = [-Bs(1)-Bs(2) Bs(1) Bs(2)      ; 
         Bs(1) -Bs(1)-Bs(3) Bs(3)      ;
         Bs(2) Bs(3) -Bs(2)-Bs(3)];
EQ3Bs = [Bs(1)+Bs(2) -Bs(1) -Bs(2); 
         -Bs(1) Bs(1)+Bs(3) -Bs(3);
         -Bs(2) -Bs(3) Bs(2)+Bs(3)];     
EQ2Bs = [ Bs(1) Bs(2) 0    ; 
         -Bs(1) 0     Bs(3);
          0    -Bs(2) -Bs(3)];
      
NEQrhomin = [1 0 0;0 0 0;0 1 0;0 0 0;0 0 1;0 0 0];
NEQrhomax = [0 0 0;1 0 0;0 0 0;0 1 0;0 0 0;0 0 1];
      
      
% パラメータ行列をベクトルに変換する
pa      = matrix2vector(pa_1     ,pa_2     ,pa_3     );
pg      = matrix2vector(pg_1     ,pg_2     ,pg_3     );
pd      = matrix2vector(pd_1     ,pd_2     ,pd_3     );
cdr     = matrix2vector(cdr_1    ,cdr_2    ,cdr_3    );
pdr     = matrix2vector(pdr_1    ,pdr_2    ,pdr_3    );
lambdaG = matrix2vector(lambdaG_1,lambdaG_2,lambdaG_3);
lambdaD = matrix2vector(lambdaD_1,lambdaD_2,lambdaD_3);

% 差分のパラメータ行列をベクトルに変換する
difpa = matrix2vectorD(pa_1,pa_2,pa_3,1,'HEAD');
difpg = matrix2vectorD(pg_1,pg_2,pg_3,1,'HEAD');
difpd = matrix2vectorD(pd_1,pd_2,pd_3,1,'TAIL');

% サイズ分の繰り返しを生成する
paM  = repmat(M                          ,1,PA_size);
pgM  = repmat(M                          ,1,PG_size);
pdM  = repmat(M                          ,1,PD_size);
ppv  = repmat(cat(2,ppv_1,ppv_2,ppv_3)   ,1,t      );
fmax = repmat(cat(2,fmax_1,fmax_2,fmax_3),1,t      );
dfmax = repmat(cat(2,fmax_1,fmax_1,fmax_2,fmax_2,fmax_3,fmax_3),1,t);
%% サイズ設定
% 列のサイズ
ROWSIZE = NEXTROW-1;

% B行のサイズ
COLBMON = 8*(m+o+n)*l*t;
COLRHO  = 8*l*t;
COLlamA = ((m-1)+m)*l*t;
COLPDR  = 2*N      *l*t;
COLPpv  = 2*1      *l*t;   
BCOLSIZE = COLBMON+COLRHO+COLlamA+COLPDR+COLPpv;

% Aeq行のサイズ
COLLarge = 2*l*t;
COLTheta = 1*t;
COLAqMON = (m+o+n)*l*t;
COLGamma = l*t;
AeqCOLSIZE = COLLarge+COLTheta+COLAqMON+COLGamma;

Aeq=sparse(AeqCOLSIZE,ROWSIZE);
aeq=zeros(AeqCOLSIZE,1);
B=sparse(BCOLSIZE,ROWSIZE);
b=zeros(BCOLSIZE,1);
f=zeros(1,ROWSIZE);
clearvars COLBMON COLRHO COLlamA COLPDR COLPDR COLPpv BCOLSIZE
clearvars COLLarge COLTheta COLAqMON COLGamma AeqCOLSIZE
ub(1:ROWSIZE) = inf;
lb(1:ROWSIZE) = -inf;
%% 不等式制約
fprintf('↓↓↓不等式制約↓↓↓\n')
NEXTCOL = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% -PDR < 0
fprintf('\n\n\n-----------------pdr-1-----------------\n-PDR < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,PDR_top,PDR_size,-1,'-PDR',1);

%% PDR < Bar(PDR)
fprintf('\n\n\n-----------------pdr-2-----------------\nPDR < Bar(PDR)\n------------------------------------\n')
b = barray(b,NEXTCOL,pdr,'Bar(PDR)');
[B, NEXTCOL] = diagonal(B,NEXTCOL,PDR_top,PDR_size, 1,'PDR',1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% -P(Bal+)<0
fprintf('\n\n\n-----------------ppv-1-----------------\n-P(Bal+)<0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,Ppv_top,Ppv_size,-1,'-P(Bal+)',1);

%% P(Bal+)<Ppv
fprintf('\n\n\n-----------------ppv-2-----------------\nP(Bal+)<Ppv\n------------------------------------\n')
b = barray(b,NEXTCOL,ppv,'Ppv');
[B, NEXTCOL] = diagonal(B,NEXTCOL,Ppv_top,Ppv_size, 1,'P(Bal+)',1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% -lambdaA < 0 
fprintf('\n\n\n-----------------lamA-1-----------------\n-lambdaA < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,lambdaA_top,lambdaA_size,-1,'-lambdaA',1);
%% -(lambdaA_u - lambdaA_v) < 0
fprintf('\n\n\n-----------------lamA-2-----------------\n-(lambdaA_u - lambdaA_v) < 0\n------------------------------------\n')
[B, NEXTCOL] = doubleDiagonal(B,NEXTCOL,lambdaA_top,lambdaA_size,1,-1,'-lambdaA',1,t,l);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% B(theta_u - theta_v) < fmax
fprintf('\n\n\n-----------------rho-5-----------------\nB(theta_u - theta_v) < fmax\n------------------------------------\n')
b = barray(b,NEXTCOL,fmax,'fmax');
[B,NEXTCOL]  = substitution(B,NEXTCOL,theta_top,NEQ1Bs,t,'B(theta_u-theta_v)',1);
%% -B(theta_u - theta_v) < fmax
fprintf('\n\n\n-----------------rho-6-----------------\n-B(theta_u - theta_v) < fmax\n------------------------------------\n')
b = barray(b,NEXTCOL,fmax,'fmax');
[B,NEXTCOL]  = substitution(B,NEXTCOL,theta_top,-NEQ1Bs,t,'-B(theta_u-theta_v)',1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% -PA < 0
fprintf('\n\n\n-----------------m-1-----------------\n-PA < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,PA_top,PA_size,-1,'-PA',1);
%% PA < pa
fprintf('\n\n\n-----------------m-2-----------------\nPA < pa\n------------------------------------\n')
b = barray(b,NEXTCOL,-difpa,'pa');
[B, NEXTCOL] = diagonal(B,NEXTCOL,PA_top,PA_size, 1,'PA',1);
%% -PG < 0
fprintf('\n\n\n-----------------n-1-----------------\n-PG < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,PG_top,PG_size,-1,'-PG',1);
%% PG < pg
fprintf('\n\n\n-----------------n-2-----------------\nPG < pg\n------------------------------------\n')
b = barray(b,NEXTCOL,-difpg,'pg');
[B, NEXTCOL] = diagonal(B,NEXTCOL,PG_top,PG_size, 1,'PG',1);
%% -PD < 0
fprintf('\n\n\n-----------------o-1-----------------\n-PD < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,PD_top,PD_size,-1,'-PD',1);
%% PD < pd
fprintf('\n\n\n-----------------o-2-----------------\nPD < pd\n------------------------------------\n')
b = barray(b,NEXTCOL,-difpd,'pd');
[B, NEXTCOL] = diagonal(B,NEXTCOL,PD_top,PD_size, 1,'PD',1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% B(theta_u - theta_v) + M*umin < M-fmax,-B(theta_u - theta_v) + M*umin < M-fmax
fprintf('\n\n\n-----------------rho-7-----------------\nB(theta_u - theta_v) + M*umin < fmax\n------------------------------------\n')
fprintf('\n\n\n-----------------rho-8-----------------\n-B(theta_u - theta_v) + M*umin < fmax\n------------------------------------\n')
b = barray(b,NEXTCOL,M-dfmax,'M-fmax');
[B,NEXTCOL]  = substitution(B,NEXTCOL,theta_top,NEQ2Bs,t,'B(theta_u-theta_v)',0);
[B, NEXTCOL] = diagonal(B,NEXTCOL,umin_top  , umin_size  , M,'umin'  ,1);
[B, NEXTCOL] = diagonal(B,NEXTCOL,umax_top  , umax_size  , M,'umax'  ,1);
%% rhomin - M*umin < 0,rhomax - M*umax < 0
fprintf('\n\n\n-----------------rho-3----------------\nrhomin - M*umin < 0\n------------------------------------\n')
fprintf('\n\n\n-----------------rho-4-----------------\nrhomax - M*umax < 0\n------------------------------------\n')
[B, NEXTCOL] = substitution(B,NEXTCOL,rhomin_top, NEQrhomin,t,'rhomin',0);
[B, NEXTCOL] = substitution(B,NEXTCOL,rhomax_top, NEQrhomax,t,'rhomax',0);
[B, NEXTCOL] = diagonal(B,NEXTCOL,umin_top  , umin_size  ,-M,'-M*umin'  ,1);
[B, NEXTCOL] = diagonal(B,NEXTCOL,umax_top  , umax_size  ,-M,'-M*umin'  ,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% phiAmin - M*u_Amin < 0
fprintf('\n\n\n-----------------m-5-----------------\nphiAmin - M*u_Amin < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,phiAmin_top, phiAmin_size,1,'phiAmin',0);
[B, NEXTCOL] = diagonal(B,NEXTCOL,uAmin_top  , uAmin_size  ,-M,'-M*u_Amin',1);
%% PA + M*u_Amin < M
fprintf('\n\n\n-----------------m-6-----------------\nPA + M*u_Amin < M\n------------------------------------\n')
b = barray(b,NEXTCOL,paM,'M');
[B, NEXTCOL] = diagonal(B,NEXTCOL,PA_top     , PA_size     , 1,'PA',0);
[B, NEXTCOL] = diagonal(B,NEXTCOL,uAmin_top  , uAmin_size  , M,'M*u_Amin',1);
%% phiAmax - M*u_Amax < 0
fprintf('\n\n\n-----------------m-7-----------------\nphiAmax - M*u_Amax < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,phiAmax_top, phiAmax_size, 1,'phiAmax',0);
[B, NEXTCOL] = diagonal(B,NEXTCOL,uAmax_top  , uAmax_size  ,-M,'-M*u_Amax',1);
%% -PA + M*u_Amax < M-pa
fprintf('\n\n\n-----------------m-8-----------------\n-PA + M*u_Amax < M-pa\n------------------------------------\n')
b = barray(b,NEXTCOL,paM - difpa,'M-pa');
[B, NEXTCOL] = diagonal(B,NEXTCOL,PA_top     , PA_size     ,-1,'-PA',0);
[B, NEXTCOL] = diagonal(B,NEXTCOL,uAmax_top  , uAmax_size  , M,'M*u_Amax',1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% phiGmin - M*u_Gmin < 0
fprintf('\n\n\n-----------------n-5-----------------\nphiGmin - M*u_Gmin < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,phiGmin_top, phiGmin_size,1,'phiGmin',0);
[B, NEXTCOL] = diagonal(B,NEXTCOL,uGmin_top  , uGmin_size  ,-M,'-M*u_Dmin',1);
%% PG + M*u_Gmin < M
fprintf('\n\n\n-----------------n-6-----------------\nphiGmin - M*u_Gmin < 0\n------------------------------------\n')
b = barray(b,NEXTCOL,pgM,'M');
[B, NEXTCOL] = diagonal(B,NEXTCOL,PG_top     , PG_size     , 1,'PG',0);
[B, NEXTCOL] = diagonal(B,NEXTCOL,uGmin_top  , uGmin_size  , M,'M*u_Gmin',1);
%% phiGmax - M*u_Dmax < 0
fprintf('\n\n\n-----------------n-7-----------------\nphiGmax - M*u_Dmax < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,phiGmax_top, phiGmax_size, 1,'phiGmax',0);
[B, NEXTCOL] = diagonal(B,NEXTCOL,uGmax_top  , uGmax_size  ,-M,'-M*u_Dmax',1);
%% -PG + M*u_Gmax < M-pg
fprintf('\n\n\n-----------------n-8-----------------\n-PG + M*u_Gmax < M-pg\n------------------------------------\n')
b = barray(b,NEXTCOL,pgM - difpg,'M-pg');
[B, NEXTCOL] = diagonal(B,NEXTCOL,PG_top     , PG_size     ,-1,'-PG',0);
[B, NEXTCOL] = diagonal(B,NEXTCOL,uGmax_top  , uGmax_size  , M,'M*u_Gmax',1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% phiDmin - M*u_Dmin < 0
fprintf('\n\n\n-----------------o-5-----------------\nphiDmin - M*u_Dmin < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,phiDmin_top, phiDmin_size,1,'phiDmin',0);
[B, NEXTCOL] = diagonal(B,NEXTCOL,uDmin_top  , uDmin_size  ,-M,'-M*u_Dmin',1);
%% PD + M*u_Dmin < M
fprintf('\n\n\n-----------------o-6-----------------\nPD + M*u_Dmin < M\n------------------------------------\n')
b = barray(b,NEXTCOL,pdM,'M');
[B, NEXTCOL] = diagonal(B,NEXTCOL,PD_top     , PD_size     , 1,'PD',0);
[B, NEXTCOL] = diagonal(B,NEXTCOL,uDmin_top  , uDmin_size  , M,'M*u_Dmin',1);
%% phiDmax - M*u_Dmax < 0
fprintf('\n\n\n-----------------o-7-----------------\nphiDmax - M*u_Dmax < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,phiDmax_top, phiDmax_size, 1,'phiDmax',0);
[B, NEXTCOL] = diagonal(B,NEXTCOL,uDmax_top  , uDmax_size  ,-M,'-M*u_Dmax',1);
%% -PD + M*u_Dmax < M-pd
fprintf('\n\n\n-----------------o-8-----------------\n-PD + M*u_Dmax < M-pd\n------------------------------------\n')
b = barray(b,NEXTCOL,pdM - difpd,'M-pd');
[B, NEXTCOL] = diagonal(B,NEXTCOL,PD_top     , PD_size     ,-1,'-PD',0);
[B, NEXTCOL] = diagonal(B,NEXTCOL,uDmax_top  , uDmax_size  , M,'M*u_Dmax',1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% -rhomin < 0
fprintf('\n\n\n-----------------rho-1-----------------\n-rhomin < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,rhomin_top,rhomin_size,-1,'-rhomin',1);
%% -rhomax < 0
fprintf('\n\n\n-----------------rho-2-----------------\n-rhomax < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,rhomax_top,rhomax_size,-1,'-rhomax',1);

%% -phiAmin < 0
fprintf('\n\n\n-----------------m-3-----------------\n-phiAmin < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,phiAmin_top, phiAmin_size,-1,'-phiAmin',1);

%% -phiAmax < 0
fprintf('\n\n\n-----------------m-4-----------------\n-phiAmax < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,phiAmax_top, phiAmax_size,-1,'-phiAmax',1);
%% -phiGmin < 0
fprintf('\n\n\n-----------------n-3-----------------\n-phiGmin < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,phiGmin_top, phiGmin_size,-1,'-phiGmin',1);

%% -phiGmax < 0
fprintf('\n\n\n-----------------n-4-----------------\n-phiGmax < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,phiGmax_top, phiGmax_size,-1,'-phiGmax',1);

%% -phiDmin < 0
fprintf('\n\n\n-----------------o-3-----------------\n-phiDmin < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,phiDmin_top, phiDmin_size,-1,'-phiDmin',1);

%% -phiDmax < 0
fprintf('\n\n\n-----------------o-4-----------------\n-phiDmax < 0\n------------------------------------\n')
[B, NEXTCOL] = diagonal(B,NEXTCOL,phiDmax_top, phiDmax_size,-1,'-phiDmax',1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 等式制約
fprintf('↓↓↓等式制約↓↓↓\n')
NEXTCOL = 1;
%% -PA + PDR - P(Bal+) = 0
fprintf('\n\n\n-----------------eq-1-----------------\n-PA + PDR + P(Bal+) = 0\n------------------------------------\n')

    [Aeq,NEXTCOL] = besideArray(Aeq,NEXTCOL,PA_top,PA_size  ,t,-1,'-PA    ',0);
    [Aeq,NEXTCOL] = besideArray(Aeq,NEXTCOL,PDR_top,PDR_size,1, 1,' PDR   ',0);
    [Aeq,NEXTCOL] = besideArray(Aeq,NEXTCOL,Ppv_top,Ppv_size,1, 1,'-P(Bal)',1);
%% PA + PG -PD - B(theata_u -theta_v) = 0
fprintf('\n\n\n-----------------eq-2-----------------\nPA + PG -PD - B(theata_u -theta_v) = 0\n------------------------------------\n')
    [Aeq,NEXTCOL]  = substitution(Aeq,NEXTCOL,theta_top,EQ1Bs,t,'B(theta_u -theta_v)',0);
    [Aeq,NEXTCOL] = besideArray(Aeq,NEXTCOL,PA_top,PA_size,t, 1,' PA',0);
    [Aeq,NEXTCOL] = besideArray(Aeq,NEXTCOL,PG_top,PG_size,t, 1,' PG',0);
    [Aeq,NEXTCOL] = besideArray(Aeq,NEXTCOL,PD_top,PD_size,t,-1,'-PD',1);
%% theta_(u=1) = 0
fprintf('\n\n\n-----------------eq-3-----------------\ntheta_(u=1) = 0\n------------------------------------\n')
    [Aeq,NEXTCOL]  = substitution(Aeq,NEXTCOL,theta_top+2,[1 0 0],t,'theta_(u=1)',1);
    
%% lambdaA - phiAmin + phiAmax - alpha_u = 0
fprintf('\n\n\n-----------------eq-4-----------------\nlambdaA - phiAmin + phiAmax - alpha_u = 0\n------------------------------------\n')
[Aeq,NEXTCOL] = verticalArray(Aeq,NEXTCOL,alpha_top,alpha_size,phiAmin_size,t,-1,'alpha_u',0);
[Aeq, NEXTCOL] = diagonal(Aeq,NEXTCOL,lambdaA_top, lambdaA_size, 1,'lambdaA',0);
[Aeq, NEXTCOL] = diagonal(Aeq,NEXTCOL,phiAmin_top, phiAmin_size,-1,'-phiAmin',0);
[Aeq, NEXTCOL] = diagonal(Aeq,NEXTCOL,phiAmax_top, phiAmax_size, 1,'phiAmax',1);
%% - phiGmin + phiDmax + alpha_u = -lambdaG
fprintf('\n\n\n-----------------eq-5-----------------\n- phiGmin + phiDmax - alpha_u = -lambdaG\n------------------------------------\n')
aeq = barray(aeq,NEXTCOL,-lambdaG,'-lambdaG');
[Aeq,NEXTCOL] = verticalArray(Aeq,NEXTCOL,alpha_top,alpha_size,phiGmin_size,t,-1,'alpha_u',0);
[Aeq, NEXTCOL] = diagonal(Aeq,NEXTCOL,phiGmin_top, phiGmin_size,-1,'-phiGmin',0);
[Aeq, NEXTCOL] = diagonal(Aeq,NEXTCOL,phiGmax_top, phiGmax_size, 1,'phiGmax',1);

%% - phiDmin + phiDmax + alpha_u = lambdaD 
fprintf('\n\n\n-----------------eq-6-----------------\n- phiDmin + phiDmax + alpha_u = lambdaD\n------------------------------------\n')
AlphaCOL = NEXTCOL;
aeq = barray(aeq,NEXTCOL,lambdaD,'lambdaD');
[Aeq,NEXTCOL] = verticalArray(Aeq,NEXTCOL,alpha_top,alpha_size,phiDmin_size,t,1,'alpha_u',0);
[Aeq, NEXTCOL] = diagonal(Aeq,NEXTCOL,phiDmin_top, phiDmin_size,-1,'-phiDmin',0);
[Aeq, NEXTCOL] = diagonal(Aeq,NEXTCOL,phiDmax_top, phiDmax_size, 1,'phiDmax',1);

%% B_uv(-alpha -rhomin + rhomax) + gamma = 0
fprintf('\n\n\n-----------------eq-7-----------------\nB_uv(-alpha -rhomin + rhomax) + gamma = 0\n------------------------------------\n')
[Aeq,NEXTCOL]  = substitution(Aeq,NEXTCOL,alpha_top ,EQ3Bs ,t,'B_uv(-alpha)',0);
[Aeq,NEXTCOL]  = substitution(Aeq,NEXTCOL,rhomin_top,-EQ2Bs ,t,'-rhomin',0);
[Aeq,NEXTCOL]  = substitution(Aeq,NEXTCOL,rhomax_top,EQ2Bs  ,t,'rhomax',0);
[Aeq,NEXTCOL]  = substitution(Aeq,NEXTCOL+2,gamma_top,1,t,'gamma',0);


%% 比較検討を行う
cd(strcat(PASS,'\Datas'))
load('Result.mat')
cd(CAL_PASS)

%% 目的関数
fprintf('↓↓↓目的関数↓↓↓\n')
f = farray(f,PDR_top,-p_cdr,'PDR');
f = farray(f,PG_top,-lambdaG,'PG');
f = farray(f,PD_top, lambdaD,'PD');
f = farray(f,rhomin_top,-fmax,'rhomin');
f = farray(f,rhomax_top,-fmax,'rhomax');
f = farray(f,phiAmax_top,2*difpa,'phiAmax');
f = farray(f,phiGmax_top,difpg,'phiGmax');
f = farray(f,phiDmax_top,difpd,'phiDmax');


%% Gurobi
clear model;
    model.A = sparse([Aeq;B]); 
    model.obj = f;
    model.rhs =[aeq;b];
    model.sense = [repmat('=',size(Aeq,1),1);repmat('<',size(B,1),1)];
    model.ub = ub;
    model.lb = lb;
    for i=1:umin_top-1
        model.vtype(i)='C';
    end
    for i=umin_top:ROWSIZE
        model.vtype(i)='B';
    end
    model.modelsense = 'max';

    clear params;
    params.outputflag = 0;
    result=gurobi(model,params);
    disp(result)
    x=result.x; 
    
%     
% 
% difF = f - p_f;
% difB = B - p_B;
% disp(difB)
% difb = b - p_b;
% difAeq = Aeq - p_Aeq;
% disp(difAeq)
% difaeq = aeq - p_aeq;
% nspB = full(B);
% nspAeq = full(Aeq);
% nsp_pAeq = full(p_Aeq);
% nspdifAeq = full(difAeq);
% difx = x - p_x;

clear saveFormat
[R_alpha,RI_alpha] = saveFormat(x,alpha_top,alpha_size,t);
[R_PA,RI_PA] = saveFormat(x,PA_top,PA_size,t);
[R_PG,RI_PG] = saveFormat(x,PG_top,PG_size,t);
[R_PD,RI_PD] = saveFormat(x,PD_top,PD_size,t);
[R_PDR,RI_PDR] = saveFormat(x,PDR_top,PDR_size,t);
[R_theta,RI_theta] = saveFormat(x,theta_top,theta_size,t);
[R_rhomin,RI_rhomin] = saveFormat(x,rhomin_top,rhomin_size,t);
[R_rhomax,RI_rhomax] = saveFormat(x,rhomax_top,rhomax_size,t);
[R_lambdaA,RI_lambdaA] = saveFormat(x,lambdaA_top,lambdaA_size,t);
[R_phiAmax,RI_phiAmax] = saveFormat(x,phiAmax_top,phiAmax_size,t);
[R_phiGmax,RI_phiGmax] = saveFormat(x,phiAmax_top,phiGmax_size,t);
[R_phiDmax,RI_phiDmax] = saveFormat(x,phiAmax_top,phiDmax_size,t);
RESULT_PASS = strcat(SAVE_PASS,'\',SAVE_FOLDER);
save(strcat(RESULT_PASS,'\Results.mat'),'x','f','result','R_alpha','RI_alpha','R_PA','RI_PA','R_PG','RI_PG','R_PD','RI_PD','R_PDR','RI_PDR','R_theta','RI_theta','R_rhomin','RI_rhomin','R_rhomax','RI_rhomax','R_lambdaA','RI_lambdaA','R_phiAmax','RI_phiAmax','R_phiGmax','RI_phiGmax','R_phiDmax','RI_phiDmax')

%% 実行階層をApp\Programに戻す
cd(strcat(PASS,'\Program'))