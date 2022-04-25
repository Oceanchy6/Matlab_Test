%实验内容 (2) 周期序列谱分析 =================== 
N=8;n=0:N-1; %FFT的变换区间 N=8 
x4n=cos(pi*n/4); 
x5n=cos(pi*n/4)+cos(pi*n/8); 
X4k8=fft(x4n); %计算 x4n 的 8 点 DFT 
X5k8=fft(x5n); %计算 x5n 的 8 点 DFT 
N=16;n=0:N-1; %FFT的变换区间 N=16 
x4n=cos(pi*n/4); 
x5n=cos(pi*n/4)+cos(pi*n/8); 
X4k16=fft(x4n); %计算 x4n 的 16 点 DFT 
X5k16=fft(x5n); %计算 x5n 的 16 点 DFT 
figure(3) 
subplot(2,2,1);mstem(X4k8); 
%绘制 8 点 DFT的幅频特性图
title('(4a) 8 点 DFT[x_4(n)]'); 
xlabel(' ω/ π');ylabel(' 幅度 '); 
axis([0,2,0,1.2*max(abs(X4k8))]) 
subplot(2,2,3);mstem(X4k16); 
%绘制 16 点 DFT的幅频特性图
title('(4b)16 点 DFT[x_4(n)]'); 
xlabel(' ω/ π');ylabel(' 幅度 '); 
axis([0,2,0,1.2*max(abs(X4k16))]) 
subplot(2,2,2);mstem(X5k8); 
%绘制 8 点 DFT的幅频特性图
title('(5a) 8 点 DFT[x_5(n)]');xlabel(' ω/π '); 
ylabel(' 幅度 '); 
axis([0,2,0,1.2*max(abs(X5k8))]) 
subplot(2,2,4);mstem(X5k16); 
%绘制 16 点 DFT的幅频特性图
title('(5b)16 点 DFT[x_5(n)]');xlabel(' ω/ π'); 
ylabel(' 幅度 '); 
axis([0,2,0,1.2*max(abs(X5k16))])