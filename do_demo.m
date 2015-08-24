
% This m-file demoes the usage of SIFT functions. It generates SIFT keypionts and descriptors for one input image. 
% Author: Yantao Zheng. Nov 2006.  For Project of CS5240


% Add subfolder path.

clc;
clear;

img1_dir = 'demo-data\';

%img1_file = 'beaver11.bmp';
img1_file = 'image1.jpg'





I1_rgb = imread([img1_dir img1_file]) ; 
I1_rgb =imresize(I1_rgb, [240 320]);%��ͼ�������Ŵ���

rgbhist = do_rgbcolour([img1_dir img1_file]);

%fprintf('CS5240 -- SIFT: Match image: Computing frames and descriptors.\n') ;
[frames,descr,gss,dogss ] = do_sift( [img1_dir img1_file], 'Verbosity', 1, 'NumOctaves', 4, 'Threshold',  0.1/3/2 ) ; %0.04/3/2



figure(1) ; clf ; plotss(dogss) ; colormap gray ;  %��ʾ���
drawnow ;

figure(2) ; clf ;
imshow(I1_rgb) ; axis image ;

hold on ;
h=plotsiftframe( frames ) ; 
set(h,'LineWidth',1,'Color','g') ;
