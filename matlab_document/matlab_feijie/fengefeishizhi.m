clear all;
clc;
tic
for q =1:1
    str1 = num2str(q);
    %jpg数据格式的存储路径
    str2 = 'I:\LIDC_feijie\0001-0050\LIDC-IDRI-000';
    str3 ='\*.jpg';
    str4 ='\';
    %分割好肺实质后的图片存储路径
    str5='I:\LIDC_feijie\0001-0050_fenge\000';
    str_imagedir = strcat(str2,str1,str3);
    str_dirname = strcat(str2,str1,str4);
    str_write= strcat(str5,str1,str4);
    %disp(str_imagedir)
    %disp(str_dirname)
    %disp(str_write)7
    imagelist = dir(str_imagedir);

    for i = 1:length(imagelist)
        name = imagelist(i).name;
        dirname = [str_dirname,name];
%B=imread(dirname);%读取原图像
% B=rgb2gray(A);%将原图像转换为灰度图像
    A=imread(dirname);
    B=rgb2gray(A);
%subplot(2,2,1),imshow(B,[]),title('DICOM图像导入后显示');
% figure,imshow(B),title('图像导入后显示');
%====================================================
    min(min(B));
    max(max(B));
    t=graythresh(B);%计算阈值t
    C=im2bw(B,t);%根据阈值二值化图像
% figure(),imshow(C,[]),title('显示二值化图像');
% C=bwareaopen(C,6000);%去除面积小于T的部分（气管）。%%%%%%%%%在肺实质比较大的时候，而且操作床特殊分段构造，面积为10000

    D=imfill(C,4,'holes');%对二值化后的图像填充肺实质

% figure(),imshow(D,[]),title('显示填充肺实质图像');
    E=D-C;%得到肺实质的图像E
% figure(),imshow(E,[]),title('显示肺实质的图像');
    F=imfill(E,8,'holes');%填充肺实质空洞
%  FMask=bwareaopen(F,1000);%去除面积小于T的部分（气管）。%%%%%%%%%在肺实质比较大的时候，而且操作床特殊分段构造，面积为4600
    FMask=bwareaopen(F,6000);%去除面积小于T的部分（气管）。%%%%%%%%%在肺实质比较大的时候，而且操作床特殊分段构造，面积为4600
%  figure(),imshow(FMask,[]),title('显示掩摸');%得到掩膜

%-------------------------分开左右肺----------------------------------------
    r_ball=90;%可变的，取值为10/15,越小越细致
    se_ball=strel('ball',r_ball,10);%椭圆体半径10，高度10
    r_disk=ceil(r_ball/6);%圆整r_ball/6得到大于或等于它的最接近整数。ceil取整
        if r_disk==0;
            r_disk=1;%最小为1
        end
    se_erode=strel('disk',r_disk,0); %圆形半径
    mask=imopen(FMask,1);%开操作
% figure(),imshow(mask,[]);

    L=bwlabel(FMask);   %数学形态重建，基于膨胀运算，用掩摸对二值图像标记，将图像分成多个区域
%stat = regionprops(FMask);%,计算图像区域特征，区域连通，object为二值图像，
    [row,col]=size(B);
%im2bw，Convert image to binary image, based on threshold
%im2bw默认threshold0.5，得到512*512空矩阵
    mask_leftlung=im2bw(zeros(row,col));%左肺掩膜
    mask_rightlung=im2bw(zeros(row,col));%右肺掩膜
        for i=1:row
            for j=1:col
                if L(i,j)==1 %如果是左肺
                    mask_leftlung(i,j)=1;% 分开左右肺，肺是白色的
                end
                if L(i,j)==2
                    mask_rightlung(i,j)=1;
                end
            end
        end

% figure(),imshow(mask_leftlung,[]);title('左肺掩摸显示')
% figure(),imshow(mask_rightlung,[]);title('右肺掩摸显示')

%----------------------对左肺修补-------------------------------------------
    object1=1-mask_leftlung; %左肺反向
% figure();imshow(object1,[]);title('左肺反向后显示')
    object2=imopen(object1,se_ball);%开操作，椭圆体半径30，高度10
% figure();imshow(object2,[]);title('反向左肺模糊重影图显示')   %得到反向左肺模糊重影图
    leftmask1=1-object2;%左肺模糊重影图  
% figure();imshow(leftmask1,[]);title('左肺模糊重影图显示')

    leftmask2=im2bw(leftmask1,0.5);%根据阈值0.5将图像生成二值图像
%figure();imshow(leftmask2,[]);title('左肺清晰二值图像显示')
%%得到左肺清晰的二值图像，支气管消去了，结节的毛刺也消除，结节变小；对左肺进行了修补
    leftmask3=imfill(leftmask2,'hole');  %填充左肺实质空洞
% figure();imshow(leftmask3,[]),title('填充左肺实质后显示'); %只是填充了左肺实质，得到不平滑的左肺图像  
    leftmask4=imerode(leftmask3,se_erode);%腐蚀左肺操作，肺结节大了点，平滑作用
% figure();imshow(leftmask4,[]),title('leftlungmask');%得到平滑效果图像

%---------------------补回空洞----------------------------------------------
    ConvHull=bwconvhull(leftmask4,'object');%对左肺掩摸求凸壳
%figure();imshow(ConvHull,[]),title('凸壳图像');
    DIF_ConvHull=ConvHull-leftmask4;%将补的缺口部分取出来
%figure();imshow(DIF_ConvHull,[]),title('与左肺原图差值图像');
    BW1 = bwconncomp(DIF_ConvHull);%利用连通域分析左肺凸壳
    stats = regionprops(BW1, 'Area','Eccentricity');%获得每个连通域得面积、离心率
    idx = find([stats.Area] > 80 & [stats.Eccentricity] < 0.8); 
% % % % BW2 = ismember(labelmatrix(BW1), idx);%取出符合要求的区域
% % % % figure();imshow(BW2,[]),title('左肺所需要补的部分显示');
% % % % leftmask5=BW2+leftmask4;%将符合要求的区域“补”到左肺掩摸中
%figure();imshow(leftmask5,[]),title('显示最终的左肺掩摸');
%---------------------对右肺修补--------------------------------------------
    object1=1-mask_rightlung; %反转右肺轮廓
    %figure();imshow(object1,[]);title('右肺反向后显示')
    object2=imopen(object1,se_ball);%开操作
 %figure();imshow(object2,[]);title('反向右肺模糊重影图显示')   %得到反向右肺模糊重影图
    rightmask1=1-object2;%得到右肺模糊掩膜，反转回来，实质为白色
 %figure();imshow(rightmask1,[]);title('右肺模糊重影图显示')

    rightmask2=im2bw(rightmask1,0.5);%右肺转换为二值图像
 %figure();imshow(rightmask2,[]);title('右肺清晰二值图像显示')
    rightmask3=imfill(rightmask2,'hole');%填充右肺实质空洞
 %figure();imshow(rightmask3,[]),title('填充右肺实质后显示');
    rightmask4=imerode(rightmask3,se_erode);%腐蚀操作，平滑作用
%  figure();imshow(rightmask4,[]),title('rightlungmask');
 
% % %  lungmask=im2bw(leftmask5+rightmask4);%将左右肺合并，得到全肺掩膜
    lungmask=im2bw(leftmask4+rightmask4);%将左右肺合并，得到全肺掩膜
    lung=immultiply(lungmask,B);%相与,得到的是灰度值从0到max-min+1的灰度图像
 %dicomwrite(lung,'E:\1_毕业设计\images_CT\S60\I00');%dicomwrite()函数将lung（从源图像提取出来的肺实质）图像保存为dicom文件格式，方便下次使用
 %subplot(2,2,2),imshow(lung,[]),title('提取的肺实质');
 %figure;imshow(lung,[]),title('提取的肺实质');
%name = + name;
    feishizhi = [str_write,name];
    imwrite(lung,feishizhi);
%break
    end
end    

