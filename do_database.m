function [ output_args ] = do_database(file,rgbhist,frames,descr )
%DO_DATABASE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
conn = database('project','cdb_outerroot','(19951227)','com.mysql.jdbc.Driver','jdbc:mysql://182.254.128.241:7707/project');

res = exec(conn,['select id from pictures where url = ' file]);
res = fetch(res);
picture_id = res.Data;

set('AutoComm','off');
%������ɫ����
innsert(conn,);
commit(conn);
remainder = mod(size(frames,2),2);
for index= 1 : 2 : (size(frames,2)-remainder)
    
    commit(conn);
end

close(conn);
end

