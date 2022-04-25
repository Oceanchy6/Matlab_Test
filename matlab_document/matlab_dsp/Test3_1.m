%实验三程序 exp3.m 
%用 FFT对信号作频谱分析
%clear all;close all 
%实验内容 (1)================================ 
x1n=[ones(1,4)];% 产生序列向量 x1(n)=R4(n) 
M=8;xa=1:(M/2); xb=(M/2):-1:1; 
x2n=[xa,xb]; %产生长度为 8 的三角波序列 x2(n) 
x3n=[xb,xa]; 
X1k8=fft(x1n,8); %计算 x1n 的 8 点 DFT 
X1k16=fft(x1n,16); %计算 x1n 的 16 点 DFT 
X2k8=fft(x2n,8); %计算 x1n 的 8 点 DFT 
X2k16=fft(x2n,16); %计算 x1n 的 16 点 DFT 
X3k8=fft(x3n,8); %计算 x1n 的 8 点 DFT 
X3k16=fft(x3n,16); %计算 x1n 的 16 点 DFT 
%以下绘制幅频特性曲线
subplot(2,2,1);mstem(X1k8); 
%绘制 8 点 DFT的幅频特性图
title('(1a) 8 点 DFT[x_1(n)]');xlabel(' ω/π '); 
ylabel(' 幅度 '); 
axis([0,2,0,1.2*max(abs(X1k8))]) 
subplot(2,2,3);mstem(X1k16); 
%绘制 16 点 DFT的幅频特性图
title('(1b)16 点 DFT[x_1(n)]');xlabel(' ω/ π'); 
ylabel(' 幅度 '); 
axis([0,2,0,1.2*max(abs(X1k16))]) 
figure(2) 
subplot(2,2,1);mstem(X2k8); 
%绘制 8 点 DFT的幅频特性图
title('(2a) 8 点 DFT[x_2(n)]');xlabel(' ω/π '); 
ylabel(' 幅度 '); 
axis([0,2,0,1.2*max(abs(X2k8))]) 
subplot(2,2,2);mstem(X2k16); 
%绘制 16 点 DFT的幅频特性图
title('(2b)16 点 DFT[x_2(n)]');xlabel(' ω/ π'); 
ylabel(' 幅度 '); 
axis([0,2,0,1.2*max(abs(X2k16))]) 
subplot(2,2,3);mstem(X3k8); 
%绘制 8 点 DFT的幅频特性图
title('(3a) 8 点 DFT[x_3(n)]');xlabel(' ω/π '); 
ylabel(' 幅度 '); 
axis([0,2,0,1.2*max(abs(X3k8))]) 
subplot(2,2,4);mstem(X3k16); 
%绘制 16 点 DFT的幅频特性图
title('(3b)16 点 DFT[x_3(n)]');xlabel(' ω/ π'); 
ylabel(' 幅度 '); 
axis([0,2,0,1.2*max(abs(X3k16))])