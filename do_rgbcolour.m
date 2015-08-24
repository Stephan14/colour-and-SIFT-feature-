function [ hist ] = do_rgbcolour( file )
%DO_RGBCOLOUR 此处显示有关此函数的摘要
%   此处显示详细说明
picture = imread(file);  
picR = picture(:,:,1);  
picG = picture(:,:,2);  
picB = picture(:,:,3);  
  
  
figure,imshow(picR)                   
title('R分量的图像')  
  
  
% 二，绘制直方图  
[m,n]=size(picR);                            %测量图像尺寸参数  
rhist=zeros(1,256);                          %预创建存放灰度出现概率的向量 
bhist=zeros(1,256); 
ghist=zeros(1,256); 

for k=0:255      
    rhist(k+1)=length(find(picR==k))/(m*n);     %计算每级灰度出现的概率，将其存入rhist中相应位置
    ghist(k+1)=length(find(picG==k))/(m*n);
    bhist(k+1)=length(find(picB==k))/(m*n);   
end  
figure,bar(0:255,rhist,'r')                   %绘制直方图   
title('R像直方图')  
xlabel('灰度值')  
ylabel('出现概率')  
%%  
  
 
figure,bar(0:255,ghist,'g')                  
title('R像直方图')  
xlabel('灰度值')  
ylabel('出现概率')  
  
  
%%  



figure,bar(0:255,bhist,'b')                   
title('R像直方图')  
xlabel('灰度值')  
ylabel('出现概率')  
hist = [reshape(rhist',1,256),reshape(ghist',1,256),reshape(bhist',1,256)]; %将直方图拼接成 256*3 的向量。  

end

