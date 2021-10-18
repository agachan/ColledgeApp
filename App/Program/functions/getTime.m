function timeStr = getTime(str)
%GETTIME この関数の概要をここに記述
%   詳細説明をここに記述
now = datetime('now');
time = datestr(now,'yyyy_mm_dd_HH_MM_ss');
timeStr = strcat(str,time);
end
