
close all; 
clear; 
clc;
%% 高斯平滑
I = imread('feijie.jpg');
 figure, imshow(I);
 
 h3_5 = fspecial('gaussian', 3, 0.5); % sigma=0.5的3*3高斯模板
 I3_5 = imfilter(I, h3_5); % 高斯平滑
 figure, imshow(I3_5);
 
 h3_8 = fspecial('gaussian', 3, 0.8); % sigma=0.8的3*3高斯模板
 I3_8 = imfilter(I, h3_8);
 figure, imshow(I3_8);
 
 h3_18 = fspecial('gaussian', 3, 1.8) % sigma=1.8的3*3高斯模板，接近于平均模板
 I3_18 = imfilter(I, h3_18);
 figure, imshow(I3_18);
 
 h5_8 = fspecial('gaussian', 5, 0.8);
 I5_8 = imfilter(I, h5_8);
 figure, imshow(I5_8);
 
 imwrite(I5_8, 'baby5_8.bmp');
 h7_12 = fspecial('gaussian', 7, 1.2);
 I7_12 = imfilter(I, h7_12);
 figure, imshow(I7_12);
 
 imwrite(I7_12, 'baby7_12.bmp');
%% 中值平滑
%  I = imread('feijie.jpg');
%  figure, imshow(I);
%  
%  J = imnoise(I,'salt & pepper');%添加椒盐噪声
%  figure, imshow(J);
%  
%  w1 = [1 2 1;2 4 2;1 2 1] / 16;
%  J1 = imfilter(J,w1,'corr','replicate'); % 高斯平滑
%  figure, imshow(J1);
%  
%  w2 = [1 1 1;1 1 1;1 1 1] / 9;
%  J2 = imfilter(J,w2,'corr','replicate'); % 平均平滑
%  figure, imshow(J2);
%  
%  J3 = medfilt2(J,[3,3]); % 中值滤波
%  figure, imshow(J3);
%%  图像锐化之Robert交叉梯度
% I = imread('feijie.jpg');
%  figure, imshow(I);
%  
%  w1 = [-1 0;0 1];
%  w2 = [0 -1;1 0];
%  
%  G1 = imfilter(I,w1,'corr','replicate');
%  G2 = imfilter(I,w2,'corr','replicate');
%  G = abs(G1) + abs(G2);%计算Robert梯度
%  figure, imshow(G,[]);
%  figure, imshow(abs(G1),[]);
%  figure, imshow(abs(G2),[]);
%%  图像锐化之Soble梯度
% I = imread('feijie.jpg'); 
%  w1 = fspecial('sobel');
%  w2 = w1';
%  G1 = imfilter(I,w1);
%  G2 = imfilter(I,w2);
%  G = abs(G1) + abs(G2);%计算Robert梯度
%  figure, imshow(G1,[]);
%  figure, imshow(G2,[]);
%  figure, imshow(G,[]);
%%  图像锐化之基于二阶微分的拉普拉斯算子
%  I = imread('lenna.png');
%  I = double(I);
%  w1 = [0 -1 0;-1 4 -1;0 -1 0];      %w1模板
%  L1 = imfilter(I,w1,'corr','replicate');
%  w3 = [-1 -1 -1;-1 8 -1;-1 -1 -1];  %w3模板
%  L3 = imfilter(I,w2,'corr','replicate');
%  w5 = [1 4 1;4 -20 4;1 4 1];        %w5模板
%  L5 = imfilter(I,w3,'corr','replicate');
%  figure;
%  subplot(1,4,1),imshow(I);
%  title('原图像');
%  subplot(1,4,2),imshow(abs(L1),[]);
%  title('w1模板锐化');
%  subplot(1,4,3),imshow(abs(L3),[]);
%  title('w3模板锐化');
%  subplot(1,4,4),imshow(abs(L5),[]);
%  title('w5模板锐化');
%% 二维高斯分布图

% % 先限定三维图中的 x,y 轴坐标范围
% X = -4: 0.1: 4;
% Y = -4: 0.1: 4;
%  
% % 标准差
% sigma = 1;
%  
% [ XX, YY ] = meshgrid( X, Y );
% Z = XX.^2 +YY.^2;
%  
% Z = -Z / ( 2 * sigma^2 );
% Z = exp(Z) / ( 2 * pi * sigma^2 );
%  
% % 显示高斯函数的三维图
% figure;
% mesh(X, Y, Z); % 线框图
% x1=xlabel('x');        
% x2=ylabel('y');        
% x3=zlabel('G(x,y)');    
% % set(x1,'Rotation',30);    
% % set(x2,'Rotation',-30);    

