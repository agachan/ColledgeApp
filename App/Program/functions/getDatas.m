function PASS = getDatas(GET_PASS, SAVE_PASS, SAVE_FOLDER)
%GETDATALIST この関数の概要をここに記述
%   詳細説明をここに記述
    cd(SAVE_PASS)
    mkdir(SAVE_FOLDER)
    USEDPARAMES_SAVE_PASS = strcat(SAVE_PASS,'\',SAVE_FOLDER);
    
    cd(GET_PASS)
    fprintf("データ一覧\n")
    List = ls;
    col = size(List,1)-2;
    row = size(List,2);
    dataList = strings(1,col);
    for i = 1:col
        GET_PASS = '';
        for j = 1:row
            GET_PASS = strcat(GET_PASS,List(i+2,j));
        end
        str = convertCharsToStrings(GET_PASS);
        fprintf('%d  %s\n',i,str)
        dataList(1,i) = str;
    end
    str = input('Please Select Data---->','s');
%     str = '';
    num = str2num(str);
    selectDATA = dataList(1,num);
    data = append("Used",selectDATA);
    copyfile(selectDATA,data)
    movefile(data,USEDPARAMES_SAVE_PASS)
    
    PASS = strcat(USEDPARAMES_SAVE_PASS,'\',data);
    
end

