clear;
%% メインファイルのあるディレクトリに移動する

PASS = 'C:\Users\阿河智浩\OneDrive - Hiroshima University\LaboPublic\student\2021\B4\阿河\卒業研究\App';
cd(PASS)
% 実行内容を決定する
% disp('Whitch process do you want to do?');
% disp('「A」-- Setting Parameter');
% disp('「B」-- Calculate');
% select = input('Please Select[A or B]---->','s');
select = 'B';
cd Program
%% 実行内容を振り分ける
if strcmp(select,'A')
    run('parameter.m');
elseif strcmp(select,'B')
%     % 実行内容を決定する
%     disp('Whitch process do you want to do?');
%     disp('「ALL  」-- [A]');
%     disp('「FIRST」-- [F]');
%     disp('「LAST 」-- [L]');
%     RUNDATA = input('Please Select[A / F / L]---->','s');
    
    run('calculate.m');
    run('output.m');
else
    disp('Cannot Run')
end

%% 実行階層をPhase1に戻す
cd(PASS)