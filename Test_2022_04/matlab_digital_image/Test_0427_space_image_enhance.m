%% �����Ҷȱ任
%�ο����������
%https://blog.csdn.net/csdnssb1/article/details/116333924
% %% ��������
% % ѡ����Ҫ����ע�͵�����,�ڼ����ϰ���Ctrl+R��,���Կ���ѡ�е�����Ѿ���ע���ˡ�
% % �����Ҫȡ����������ע��,����ѡ����ȡ�������,Ȼ���ڼ����ϰ���Ctrl+T��

% %% ֱ��ͼ����

% close all; 
% clear; 
% clc;
% image=imread('lenna.png');%����ͼƬ��
% [height,width]=size(image);%����ͼƬ�ĸ߶ȺͿ�ȡ�
% num_pixel=zeros(1,256);%����һ������256�еĿվ�����ͳ�Ƹ��Ҷ�ֵk�����ظ�����
% for i=1:height
%  for j=1:width
%      k=image(i,j);%kΪ�Ҷ�ֵ��i��j��ʾͼƬ���ص������
%      num_pixel(k+1)=num_pixel(k+1)+1;%����������±��Ǵ�1��ʼ���������Ҷ�ֵK�Ǵ�0��ʼ�ģ���255������
%  end
% end
%  
%  
% %��ʾnum_pixel��ֱ��ͼ��
% figure;
% subplot(111),bar(num_pixel);%��������bar��������ֱ��ͼ����imhist����Ҳ���Ի���
%  
%  
% %��һ����������һ��������
% P=zeros(1,256);
% for i=1:256
%   P(i)=num_pixel(i)/(height*width);%����ÿ���Ҷ�ֵ�ĸ��ʡ�
% end
%  
%  
% %��ʾP��ֱ��ͼ,��δ��һ����ֱ��ͼ���бȽϡ�
% figure;
% subplot(121),bar(num_pixel);
% subplot(122),bar(P);
%  
%  
% cum_pixel=cumsum(P);%����Ҷ��ۼƷֲ�Ƶ�ʣ�����֣�����������֮ǰ˵���Ǹ��任������չ��ʽ��
% cum_pixel=uint8((256-1).*cum_pixel+0.5);%�Ƚ����Ҷȵ��ۼ�Ƶ�ʳ��ԣ�L-1�����ٽ����������뻯������ʹ�þ��⻯��ͼ��ĻҶȼ����һ��ǰ��ԭʼͼ��һ�¡�
%  
%  
% %��ʾcum_pixel��ֱ��ͼ������֮ǰ��ֱ��ͼ���бȽϡ�
% figure;
% subplot(131),bar(num_pixel);
% subplot(132),bar(P);
% subplot(133),bar(cum_pixel);
%  
%  
% out_image=uint8(zeros(height,width));%����һ���µĿվ�������������⻯��ĻҶ�ֵ����
% for i=1:height
%    for j=1:width
%      out_image(i,j)=cum_pixel(image(i,j));%�������image��i��j��Ϊ����ֵ�������������á�
%    end
% end
%  
%  
% figure;
% imshowpair(image,out_image,'montage');
% %����imshowpair������ԭͼ�;��⻯�����ݽ��бȽϣ�Ϊ����ʾ��ͬ��С�Ķ���ͼƬ����������ʹ�á�montage������̫�棩���ַ���

% %% ���ַ���һ��
% close all; 
% clear; 
% clc; 
%  
% % ���ȶ���Ҷ�ͼ�񣬲���ȡͼ��ĸ߶ȺͿ��
% image = imread('lenna.png'); 
% [height, width] = size(image); 
%  
% % Ȼ��ͳ��ÿ���Ҷȵ�����ֵ���ۼ���Ŀ
% NumPixel = zeros(1,256);  % ����һ��256�е�����������ͳ�Ƹ��Ҷȼ������ظ���
% for i = 1 : height
%    for j = 1 : width
%        k = image(i,j);  % k�����ص�(i,j)�ĻҶ�ֵ
%        % ��ΪNumPixel������±��Ǵ�1��ʼ�ģ�����ͼ�����ص�ȡֵ��Χ��0~255
%        % ������NumPixel(k+1)
%        NumPixel(k+1) = NumPixel(k+1) + 1;  % ��Ӧ�Ҷ�ֵ���ص�������1 
%    end
% end
%  
% % % �������ǽ�����NumPixel��ʾ�������Թ۲�Ч��
% % figure;
% % subplot(121), imshow(image);
% % subplot(122), bar(NumPixel);  % �Ҷ�ͼ���ֱ��ͼ������ȷ��ʾ����
%  
% % ����������Ƶ��ֵ��ΪƵ��
% ProbPixel = zeros(1,256); % ͳ�Ƹ��Ҷȼ����ֵ�Ƶ��
% for i = 1 : 256
%     ProbPixel(i) = NumPixel(i) / (height * width);
% end
%  
% % % �������ǽ�����ProbPixel��ʾ�������Թ۲�Ч��
% % figure;
% % subplot(121), imshow(image);
% % subplot(122), bar(ProbPixel);  % �Ҷ�ͼ��Ĺ�һ��ֱ��ͼ������ȷ��ʾ����
%  
% % ���ú���cumsum()�������ۻ��ֲ�������CDF��������Ƶ�ʣ�ȡֵ��Χ��0~1��ӳ�䵽0~255���޷�������
% CumPixel = cumsum(ProbPixel);  % ���������CumPixel��СҲ��1��256
% CumPixel = uint8((256-1) .* CumPixel + 0.5); 
%  
% % % �������ǽ�����CumPixel��ʾ�������Թ۲�Ч��
% % figure;
% % subplot(121), imshow(image);
% % subplot(122), bar(CumPixel);  % ����CumPixel������ȷ��ʾ���� 
%  
% % ����������ֱ��ͼ���⻯ʵ�ֵĸ�ֵ����Ҷˣ�image(i,j)��������ΪCumPixel������
% % ���磬image(i,j)=120�����CumPixel��ȡ����120��ֵ��Ϊimage(i,j)��������ֵ
% outImage = uint8(zeros(height, width));  % Ԥ��������
% for i = 1 : height
%    for j = 1 : width
%       outImage(i,j) = CumPixel(image(i,j));
%    end
% end
%  
% % ��ʾֱ��ͼ���⻯ǰ���ͼ�񣬿��Է��֣�����ú���histeq()��Ч��һ��
% imshowpair(image, outImage, 'montage'); 

% %% ע�⣺ֱ�ӵ���MATLAB����histeq()Ҳ����ֱ��ֱ��ͼ��
% close all; 
% clear; 
% clc; 
%  
% I = imread('lenna.png');
% % figure,imshow(I);
%  
% % �ֱ���ȡR��G��B��������
% R = I(:, :, 1); 
% G = I(:, :, 2); 
% B = I(:, :, 3); 
%  
% % �ֱ��������������ֱ��ͼ���⻯
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

%% ��������������HSV�ռ��V��������ֱ��ͼ���⻯����
%% ����Ĵ�����Բ��õ���MATLAB����histeq()�ķ�ʽ����������ʹ�����б���ķ�ʽ���д���
% ����HSV�ռ�Ķ��� �ο���https://blog.csdn.net/u013066730/article/details/103893273
close all; 
clear; 
clc; 
 
I = imread('lenna.png'); 
 
% ��RGB�ռ�ת��ΪHSV�ռ�
hsvImage = rgb2hsv(I); 
 
% ��ȡV����
v = hsvImage(:, :, 3);  % �����v��double���͵ľ���
 
% ���´�����ǰ����ܻ���һ�£����ﲻ��������ע��
[height, width] = size(v); 
 
v = uint8(v .* 255 + 0.5); % �����0.5�б�Ҫ���ϣ��������v�г���0
 
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
CumPixel = uint8(255 .* CumPixel + 0.5); % ��������
 
for i = 1 : height
   for j = 1 : width
      v(i,j) = CumPixel(v(i,j));  % �����v(i,j)����Ϊ0������������������
   end
end
 
v = im2double(v); 
hsvImage(:, :, 3) = v; 
outImage = hsv2rgb(hsvImage); 
 
imshowpair(I, outImage, 'montage');

%{
�ܽ᣺
���һ��ͼ������ƫ������ƫ������ôֱ��ͼ���⻯�ķ��������á�
��ֱ��ͼ���⻯��һ��ȫ�ִ���ʽ�����Դ�������ݲ���ѡ��
���ܻ����ӱ���������Ϣ�ĶԱȶȲ��ҽ��������źŵĶԱȶȣ�
���ͼ��ĳЩ����ԱȶȺܺã�����һЩ����ԱȶȲ��ã��ǲ���ֱ��ͼ���⻯�Ͳ�һ�����ã���
���⣬���⻯��ͼ��ĻҶȼ����٣�ĳЩϸ�ڽ�����ʧ��ĳЩͼ����ֱ��ͼ�и߷壩��
�������⻯��ԱȶȲ���Ȼ�Ĺ�����ǿ�����ֱ��ͼ���⻯��ȱ�㣬�Ѿ��оֲ���ֱ��ͼ���⻯�������֡�
%}

