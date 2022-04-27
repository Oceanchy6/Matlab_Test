%% 基本灰度变换
%参看下面的链接
%https://blog.csdn.net/csdnssb1/article/details/116333924
% %% 基础操作
% % 选中想要进行注释的语句后,在键盘上按“Ctrl+R”,可以看到选中的语句已经被注释了。
% % 如果想要取消多行语句的注释,首先选中想取消的语句,然后在键盘上按“Ctrl+T”

% %% 直方图处理

% close all; 
% clear; 
% clc;
% image=imread('lenna.png');%读入图片。
% [height,width]=size(image);%测量图片的高度和宽度。
% num_pixel=zeros(1,256);%创建一个单行256列的空矩阵，来统计各灰度值k的像素个数。
% for i=1:height
%  for j=1:width
%      k=image(i,j);%k为灰度值，i和j表示图片像素点的坐标
%      num_pixel(k+1)=num_pixel(k+1)+1;%由于数组的下标是从1开始计数，而灰度值K是从0开始的，到255结束。
%  end
% end
%  
%  
% %显示num_pixel的直方图。
% figure;
% subplot(111),bar(num_pixel);%这里我用bar函数绘制直方图，用imhist函数也可以绘制
%  
%  
% %归一化操作，归一化即正则化
% P=zeros(1,256);
% for i=1:256
%   P(i)=num_pixel(i)/(height*width);%计算每个灰度值的概率。
% end
%  
%  
% %显示P的直方图,和未归一化的直方图进行比较。
% figure;
% subplot(121),bar(num_pixel);
% subplot(122),bar(P);
%  
%  
% cum_pixel=cumsum(P);%计算灰度累计分布频率（求积分），就是我们之前说的那个变换函数的展开式。
% cum_pixel=uint8((256-1).*cum_pixel+0.5);%先将各灰度的累计频率乘以（L-1），再进行四舍五入化整，以使得均衡化后图像的灰度级与归一化前的原始图像一致。
%  
%  
% %显示cum_pixel的直方图，并和之前的直方图进行比较。
% figure;
% subplot(131),bar(num_pixel);
% subplot(132),bar(P);
% subplot(133),bar(cum_pixel);
%  
%  
% out_image=uint8(zeros(height,width));%创建一个新的空矩阵，用来储存均衡化后的灰度值数据
% for i=1:height
%    for j=1:width
%      out_image(i,j)=cum_pixel(image(i,j));%在这里的image（i，j）为索引值，起索引的作用。
%    end
% end
%  
%  
% figure;
% imshowpair(image,out_image,'montage');
% %利用imshowpair函数将原图和均衡化的数据进行比较，为了显示相同大小的多张图片，我们这里使用‘montage’（蒙太奇）的手法。

% %% 两种方法一样
% close all; 
% clear; 
% clc; 
%  
% % 首先读入灰度图像，并提取图像的高度和宽度
% image = imread('lenna.png'); 
% [height, width] = size(image); 
%  
% % 然后统计每个灰度的像素值的累计数目
% NumPixel = zeros(1,256);  % 建立一个256列的行向量，以统计各灰度级的像素个数
% for i = 1 : height
%    for j = 1 : width
%        k = image(i,j);  % k是像素点(i,j)的灰度值
%        % 因为NumPixel数组的下标是从1开始的，但是图像像素的取值范围是0~255
%        % 所以用NumPixel(k+1)
%        NumPixel(k+1) = NumPixel(k+1) + 1;  % 对应灰度值像素点数量加1 
%    end
% end
%  
% % % 这里我们将数组NumPixel显示出来，以观测效果
% % figure;
% % subplot(121), imshow(image);
% % subplot(122), bar(NumPixel);  % 灰度图像的直方图可以正确显示出来
%  
% % 接下来，将频数值算为频率
% ProbPixel = zeros(1,256); % 统计各灰度级出现的频率
% for i = 1 : 256
%     ProbPixel(i) = NumPixel(i) / (height * width);
% end
%  
% % % 这里我们将数组ProbPixel显示出来，以观测效果
% % figure;
% % subplot(121), imshow(image);
% % subplot(122), bar(ProbPixel);  % 灰度图像的归一化直方图可以正确显示出来
%  
% % 再用函数cumsum()来计算累积分布函数（CDF），并将频率（取值范围是0~1）映射到0~255的无符号整数
% CumPixel = cumsum(ProbPixel);  % 这里的数组CumPixel大小也是1×256
% CumPixel = uint8((256-1) .* CumPixel + 0.5); 
%  
% % % 这里我们将数组CumPixel显示出来，以观测效果
% % figure;
% % subplot(121), imshow(image);
% % subplot(122), bar(CumPixel);  % 数组CumPixel可以正确显示出来 
%  
% % 在下列用作直方图均衡化实现的赋值语句右端，image(i,j)被用来作为CumPixel的索引
% % 例如，image(i,j)=120，则从CumPixel中取出第120个值作为image(i,j)的新像素值
% outImage = uint8(zeros(height, width));  % 预分配数组
% for i = 1 : height
%    for j = 1 : width
%       outImage(i,j) = CumPixel(image(i,j));
%    end
% end
%  
% % 显示直方图均衡化前后的图像，可以发现，与调用函数histeq()的效果一致
% imshowpair(image, outImage, 'montage'); 

% %% 注意：直接调用MATLAB函数histeq()也可以直接直方图的
% close all; 
% clear; 
% clc; 
%  
% I = imread('lenna.png');
% % figure,imshow(I);
%  
% % 分别提取R、G、B三个分量
% R = I(:, :, 1); 
% G = I(:, :, 2); 
% B = I(:, :, 3); 
%  
% % 分别对三个分量进行直方图均衡化
% R = histeq(R, 256); 
% G = histeq(G, 256); 
% B = histeq(B, 256); 
%  
% J = I;
% J(:, :, 1) = R; 
% J(:, :, 2) = G; 
% J(:, :, 3) = B; 
%  
% imshowpair(I, J, 'montage'); 

%% 接下来，我们在HSV空间对V分量进行直方图均衡化处理。
%% 这里的代码可以采用调用MATLAB函数histeq()的方式，但是我们使用自行编码的方式进行处理。
% 关于HSV空间的定义 参看：https://blog.csdn.net/u013066730/article/details/103893273
close all; 
clear; 
clc; 
 
I = imread('lenna.png'); 
 
% 将RGB空间转换为HSV空间
hsvImage = rgb2hsv(I); 
 
% 提取V分量
v = hsvImage(:, :, 3);  % 这里的v是double类型的矩阵
 
% 以下代码与前面介绍基本一致，这里不再做过多注释
[height, width] = size(v); 
 
v = uint8(v .* 255 + 0.5); % 这里的0.5有必要加上，以免矩阵v中出现0
 
N = zeros(1, 256); 
for i = 1 : height
   for j = 1 : width
      k = v(i,j);
      N(k+1) = N(k+1) + 1; 
   end
end
 
ProbPixel = zeros(1, 256);
for i = 1 : 256
    ProbPixel(i) = N(i) / (height * width); 
end
 
CumPixel = cumsum(ProbPixel);
CumPixel = uint8(255 .* CumPixel + 0.5); % 四舍五入
 
for i = 1 : height
   for j = 1 : width
      v(i,j) = CumPixel(v(i,j));  % 这里的v(i,j)不能为0，否则数组索引出错
   end
end
 
v = im2double(v); 
hsvImage(:, :, 3) = v; 
outImage = hsv2rgb(hsvImage); 
 
imshowpair(I, outImage, 'montage');

%{
总结：
如果一幅图像整体偏暗或者偏亮，那么直方图均衡化的方法很适用。
但直方图均衡化是一种全局处理方式，它对处理的数据不加选择，
可能会增加背景干扰信息的对比度并且降低有用信号的对比度（
如果图像某些区域对比度很好，而另一些区域对比度不好，那采用直方图均衡化就不一定适用）。
此外，均衡化后图像的灰度级减少，某些细节将会消失；某些图像（如直方图有高峰），
经过均衡化后对比度不自然的过分增强。针对直方图均衡化的缺点，已经有局部的直方图均衡化方法出现。
%}

