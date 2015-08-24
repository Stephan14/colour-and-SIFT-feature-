function [ output_args ] = do_database(file,rgbhist,frames,descr )
%DO_DATABASE 此处显示有关此函数的摘要
%   此处显示详细说明
conn = database('project','cdb_outerroot','(19951227)','com.mysql.jdbc.Driver','jdbc:mysql://182.254.128.241:7707/project');

res = exec(conn,['select id from pictures where url = ' file]);
res = fetch(res);
picture_id = res.Data;

set('AutoComm','off');
%插入颜色特征
innsert(conn,);
commit(conn);
remainder = mod(size(frames,2),2);
for index= 1 : 2 : (size(frames,2)-remainder)
    
    commit(conn);
end

close(conn);
end

