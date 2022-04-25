%实验内容 (3) 模拟周期信号谱分析 ================= 
figure(4) 
Fs=64;T=1/Fs; 
N=16;n=0:N-1; %FFT的变换区间 N=16 
x6nT=cos(8*pi*n*T)+cos(16*pi*n*T)+cos(20*pi*n*T); 
%对 x6(t)16 点采样
X6k16=fft(x6nT); %计算 x6nT 的 16 点 DFT 
X6k16=fftshift(X6k16); %将零频率移到频谱中心
Tp=N*T;F=1/Tp; %频率分辨率 F 
k=-N/2:N/2-1;fk=k*F; 
%产生 16 点 DFT对应的采样点频率（以零频率为中心）
subplot(3,1,1);stem(fk,abs(X6k16),'.'); 
box on %绘制 8 点 DFT的幅频特性图
title('(6a) 16 点|DFT[x_6(nT)]|');xlabel('f(Hz)'); 
%%%%%%%%% 
%%%%%%%%% 
ylabel(' 幅度 '); 
axis([-N*F/2-1,N*F/2-1,0,1.2*max(abs(X6k16))]) 
N=32;n=0:N-1; %FFT的变换区间 N=16 
x6nT=cos(8*pi*n*T)+cos(16*pi*n*T)+cos(20*pi*n*T); 
%对 x6(t)32 点采样
X6k32=fft(x6nT); %计算 x6nT 的 32 点 DFT 
X6k32=fftshift(X6k32); %将零频率移到频谱中心
Tp=N*T;F=1/Tp; %频率分辨率 F 
k=-N/2:N/2-1; 
fk=k*F; 
%产生 16 点 DFT对应的采样点频率（以零频率为中心）
subplot(3, 1, 2);stem(fk, abs(X6k32), '.'); 
box on %绘制 8 点 DFT的幅频特性图
title('(6b) 32 点 |DFT[x_6(nT)]|'); 
xlabel('f(Hz)');ylabel(' 幅度 '); 
axis([-N*F/2-1, N*F/2-1,0, 1.2*max(abs(X6k32))]) 
N=64;n=0:N-1; %FFT的变换区间 N=16 
x6nT=cos(8*pi*n*T)+cos(16*pi*n*T)+cos(20*pi*n*T); 
%对 x6(t)64 点采样
X6k64=fft(x6nT); %计算 x6nT 的 64 点 DFT 
X6k64=fftshift(X6k64); %将零频率移到频谱中心
Tp=N*T;F=1/Tp; %频率分辨率 F 
k=-N/2:N/2-1;fk=k*F; 
%产生 16 点 DFT对应的采样点频率（以零频率为中心）
subplot(3,1,3);stem(fk,abs(X6k64),'.'); 
box on%绘制 8 点 DFT的幅频特性图
title('(6a) 64 点|DFT[x_6(nT)]|'); 
xlabel('f(Hz)');ylabel(' 幅度 '); 
axis([-N*F/2-1,N*F/2-1,0, 1.2*max(abs(X6k64))])