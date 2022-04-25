%ʵ�������� exp3.m 
%�� FFT���ź���Ƶ�׷���
%clear all;close all 
%ʵ������ (1)================================ 
x1n=[ones(1,4)];% ������������ x1(n)=R4(n) 
M=8;xa=1:(M/2); xb=(M/2):-1:1; 
x2n=[xa,xb]; %��������Ϊ 8 �����ǲ����� x2(n) 
x3n=[xb,xa]; 
X1k8=fft(x1n,8); %���� x1n �� 8 �� DFT 
X1k16=fft(x1n,16); %���� x1n �� 16 �� DFT 
X2k8=fft(x2n,8); %���� x1n �� 8 �� DFT 
X2k16=fft(x2n,16); %���� x1n �� 16 �� DFT 
X3k8=fft(x3n,8); %���� x1n �� 8 �� DFT 
X3k16=fft(x3n,16); %���� x1n �� 16 �� DFT 
%���»��Ʒ�Ƶ��������
subplot(2,2,1);mstem(X1k8); 
%���� 8 �� DFT�ķ�Ƶ����ͼ
title('(1a) 8 �� DFT[x_1(n)]');xlabel(' ��/�� '); 
ylabel(' ���� '); 
axis([0,2,0,1.2*max(abs(X1k8))]) 
subplot(2,2,3);mstem(X1k16); 
%���� 16 �� DFT�ķ�Ƶ����ͼ
title('(1b)16 �� DFT[x_1(n)]');xlabel(' ��/ ��'); 
ylabel(' ���� '); 
axis([0,2,0,1.2*max(abs(X1k16))]) 
figure(2) 
subplot(2,2,1);mstem(X2k8); 
%���� 8 �� DFT�ķ�Ƶ����ͼ
title('(2a) 8 �� DFT[x_2(n)]');xlabel(' ��/�� '); 
ylabel(' ���� '); 
axis([0,2,0,1.2*max(abs(X2k8))]) 
subplot(2,2,2);mstem(X2k16); 
%���� 16 �� DFT�ķ�Ƶ����ͼ
title('(2b)16 �� DFT[x_2(n)]');xlabel(' ��/ ��'); 
ylabel(' ���� '); 
axis([0,2,0,1.2*max(abs(X2k16))]) 
subplot(2,2,3);mstem(X3k8); 
%���� 8 �� DFT�ķ�Ƶ����ͼ
title('(3a) 8 �� DFT[x_3(n)]');xlabel(' ��/�� '); 
ylabel(' ���� '); 
axis([0,2,0,1.2*max(abs(X3k8))]) 
subplot(2,2,4);mstem(X3k16); 
%���� 16 �� DFT�ķ�Ƶ����ͼ
title('(3b)16 �� DFT[x_3(n)]');xlabel(' ��/ ��'); 
ylabel(' ���� '); 
axis([0,2,0,1.2*max(abs(X3k16))])