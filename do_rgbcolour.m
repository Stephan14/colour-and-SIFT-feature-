function [ hist ] = do_rgbcolour( file )
%DO_RGBCOLOUR is used to get colour feature of a picture
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Input:
%file --- the absolute path of a picture
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Output:
%hist --- a vector to show colour feature
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
picture = imread(file);  
picR = picture(:,:,1);  
picG = picture(:,:,2);  
picB = picture(:,:,3);  
  
  
figure,imshow(picture)                   
title('原始图像')
  
  
% ∂˛£¨ªÊ÷∆÷±∑ΩÕº  
[m,n]=size(picR);                            %≤‚¡øÕºœÒ≥ﬂ¥Á≤Œ ˝  
rhist=zeros(1,256);                          %‘§¥¥Ω®¥Ê∑≈ª“∂»≥ˆœ÷∏≈¬ µƒœÚ¡ø 
bhist=zeros(1,256); 
ghist=zeros(1,256); 

for k=0:255      
    rhist(k+1)=length(find(picR==k))/(m*n);     %º∆À„√øº∂ª“∂»≥ˆœ÷µƒ∏≈¬ £¨Ω´∆‰¥Ê»Îrhist÷–œ‡”¶Œª÷√
    ghist(k+1)=length(find(picG==k))/(m*n);
    bhist(k+1)=length(find(picB==k))/(m*n);   
end  
figure,bar(0:255,rhist,'r')                   %绘制直方图
title('R像直方图')
xlabel('灰度值')
ylabel('出现概率')
figure,bar(0:255,ghist,'g')
title('G像直方图')
xlabel('灰度值')
ylabel('出现概率')
figure,bar(0:255,bhist,'b')
title('B像直方图')
xlabel('灰度值')
ylabel('出现概率')
hist = [reshape(rhist',1,256),reshape(ghist',1,256),reshape(bhist',1,256)]; %Ω´÷±∑ΩÕº∆¥Ω”≥… 256*3 µƒœÚ¡ø°£  

end

