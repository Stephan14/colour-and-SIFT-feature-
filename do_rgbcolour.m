function [ hist ] = do_rgbcolour( file )
%DO_RGBCOLOUR �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
picture = imread(file);  
picR = picture(:,:,1);  
picG = picture(:,:,2);  
picB = picture(:,:,3);  
  
  
figure,imshow(picR)                   
title('R������ͼ��')  
  
  
% ��������ֱ��ͼ  
[m,n]=size(picR);                            %����ͼ��ߴ����  
rhist=zeros(1,256);                          %Ԥ������ŻҶȳ��ָ��ʵ����� 
bhist=zeros(1,256); 
ghist=zeros(1,256); 

for k=0:255      
    rhist(k+1)=length(find(picR==k))/(m*n);     %����ÿ���Ҷȳ��ֵĸ��ʣ��������rhist����Ӧλ��
    ghist(k+1)=length(find(picG==k))/(m*n);
    bhist(k+1)=length(find(picB==k))/(m*n);   
end  
figure,bar(0:255,rhist,'r')                   %����ֱ��ͼ   
title('R��ֱ��ͼ')  
xlabel('�Ҷ�ֵ')  
ylabel('���ָ���')  
%%  
  
 
figure,bar(0:255,ghist,'g')                  
title('R��ֱ��ͼ')  
xlabel('�Ҷ�ֵ')  
ylabel('���ָ���')  
  
  
%%  



figure,bar(0:255,bhist,'b')                   
title('R��ֱ��ͼ')  
xlabel('�Ҷ�ֵ')  
ylabel('���ָ���')  
hist = [reshape(rhist',1,256),reshape(ghist',1,256),reshape(bhist',1,256)]; %��ֱ��ͼƴ�ӳ� 256*3 ��������  

end

