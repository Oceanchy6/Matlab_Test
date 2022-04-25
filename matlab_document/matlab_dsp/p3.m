clc;
clear;
%%
%实验3-1

%定义自变量以及频域自变量修正量
n1 = 0:3;
n2 = 4:7;
M1 = 8;
M2 = 16;
%构造函数x1(n)、x2(n)、x3(n)
xn1 = [ones(1,4)];
xn2 = [n1+1, 8-n2];
xn3 = [4-n1, n2-3];

%变换区间为N=8的FFT
Xk1_8 = fft(xn1,8);
Xk2_8 = fft(xn2,8);
Xk3_8 = fft(xn3,8);
%计算频域的自变量序号
tempk1_8 = 0:length(Xk1_8)-1;
tempk2_8 = 0:length(Xk2_8)-1;
tempk3_8 = 0:length(Xk3_8)-1;
%根据频域的自变量序号以及频域自变量修正量求得自变量w/pi的范围
k1_8 = (2/M1)*tempk1_8; % (K*2PI)/N/PI 归一化处理
k2_8 = (2/M1)*tempk2_8;
k3_8 = (2/M1)*tempk2_8;

%变换区间为N=16的FFT
Xk1_16 = fft(xn1,16);
Xk2_16 = fft(xn2,16);
Xk3_16 = fft(xn3,16);
%计算频域的自变量序号
tempk1_16 = 0:length(Xk1_16)-1;
tempk2_16 = 0:length(Xk2_16)-1;
tempk3_16 = 0:length(Xk3_16)-1;
%根据频域的自变量序号以及频域自变量修正量求得自变量w/pi的范围
k1_16 = (2/M2)*tempk1_16;
k2_16 = (2/M2)*tempk2_16;
k3_16 = (2/M2)*tempk2_16;

%画图
figure(1);

subplot(3,2,1);
stem(k1_8,abs(Xk1_8),'.');      
xlabel('\omega/\pi');
ylabel('|Xk1_8|');
title('变换区间为N=8的x1(n)的幅频特性曲线');

subplot(3,2,2);
stem(k1_16,abs(Xk1_16),'.');    
xlabel('\omega/\pi');
ylabel('|Xk1_16|');
title('变换区间为N=16的x1(n)的幅频特性曲线');

subplot(3,2,3);
stem(k2_8,abs(Xk2_8),'.');
xlabel('\omega/\pi');
ylabel('|Xk2_8|');
title('变换区间为N=8的x2(n)的幅频特性曲线');

subplot(3,2,4);
stem(k2_16,abs(Xk2_16),'.');
xlabel('\omega/\pi');
ylabel('|Xk2_16|');
title('变换区间为N=16的x2(n)的幅频特性曲线');

subplot(3,2,5);
stem(k3_8,abs(Xk3_8),'.');
xlabel('\omega/\pi');
ylabel('|Xk3_8|');
title('变换区间为N=8的x3(n)的幅频特性曲线');

subplot(3,2,6);
stem(k3_16,abs(Xk3_16),'.');
xlabel('\omega/\pi');
ylabel('|Xk3_16|');
title('变换区间为N=16的x3(n)的幅频特性曲线');

%%
%实验3-2

%定义自变量以及频域自变量修正量
n = 0:15;   %实验原理：对于周期函数，必须是整数倍周期的长度做FFT，故x4(n)需要采用的自变量区间为0：7或其整数倍（周期为8），x5(n)需要采用的自变量区间为0：15及其整数倍（周期为16），取其最小公倍数后自变量区间为0：15
M1 = 8;
M2 = 16;

%构造函数x4(n)、x5(n)
xn4 = cos(pi*n/4);
xn5 = cos(pi*n/4)+cos(pi*n/8);

%变换区间为N=8的FFT
Xk4_8 = fft(xn4,8);
Xk5_8 = fft(xn5,8);
%计算频域的自变量序号
tempk4_8 = 0:length(Xk4_8)-1;
tempk5_8 = 0:length(Xk5_8)-1;
%根据频域的自变量序号以及频域自变量修正量求得自变量w/pi的范围
k4_8 = (2/M1)*tempk4_8;
k5_8 = (2/M1)*tempk5_8;

%变换区间为N=16的FFT
Xk4_16 = fft(xn4,16);
Xk5_16 = fft(xn5,16);
%计算频域的自变量序号
tempk4_16 = 0:length(Xk4_16)-1;
tempk5_16 = 0:length(Xk5_16)-1;
%根据频域的自变量序号以及频域自变量修正量求得自变量w/pi的范围
k4_16 = (2/M2)*tempk4_16;
k5_16 = (2/M2)*tempk5_16;

%画图
figure(2);

subplot(2,2,1);
stem(k4_8,abs(Xk4_8),'.');      %不会失真，因为x4(n) = cos(pi/4*n)周期为8，此时观测时间为8，不小于周期
xlabel('\omega/\pi');
ylabel('|Xk4_8|');
title('变换区间为N=8的x4(n)的幅频特性曲线');

subplot(2,2,2);
stem(k4_16,abs(Xk4_16),'.');    %不会失真，因为x4(n) = cos(pi/4*n)周期为8，此时观测时间为16，不小于周期
xlabel('\omega/\pi');
ylabel('|Xk4_16|');
title('变换区间为N=16的x4(n)的幅频特性曲线');

subplot(2,2,3);
stem(k5_8,abs(Xk5_8),'.');      %会失真，因为x5(n) = cos(pi/4*n)+cos(pi/8*n)周期为16，此时观测时间为8，小于周期
xlabel('\omega/\pi');
ylabel('|Xk5_8|');
title('变换区间为N=8的x5(n)的幅频特性曲线');

subplot(2,2,4);
stem(k5_16,abs(Xk5_16),'.');    %不会失真，因为x5(n) = cos(pi/4*n)+cos(pi/8*n)周期为16，此时观测时间为16，不小于周期
xlabel('\omega/\pi');
ylabel('|Xk5_16|');
title('变换区间为N=16的x5(n)的幅频特性曲线');

%%
%实验3-3

%定义自变量以及频域自变量修正量
n = 0:63;   %实验原理：对于周期函数，必须是整数倍周期的长度做FFT，周期为0.5s,故x6(n)需要采用的自变量区间为0：31或其整数倍，又变换区间最大为64，故需要的自变量区间为0：63
t = 1/64*n; %对应在时域中的抽样点序列t

Fs=64; T = 1/Fs;

M1 = 16;
M2 = 32;
M3 = 64;

n1 = 0:M1-1;
n2 = 0:M2-1;
n3 = 0:M3-1;

%构造函数x6(n)
xn6_1 = cos(8*pi*n1*T)+cos(16*pi*n1*T)+cos(20*pi*n1*T);
xn6_2 = cos(8*pi*n2*T)+cos(16*pi*n2*T)+cos(20*pi*n2*T);
xn6_3 = cos(8*pi*n3*T)+cos(16*pi*n3*T)+cos(20*pi*n3*T);

%FFT的变换区间N=16,32,64对应的Xk
Xk6_16 = fft(xn6_1,16);Xk6_16 = fftshift(Xk6_16);
Xk6_32 = fft(xn6_2,32);Xk6_32 = fftshift(Xk6_32);
Xk6_64 = fft(xn6_3,64);Xk6_64 = fftshift(Xk6_64);


%计算频域的自变量序号
tempk6_16 = 0:length(Xk6_16)-1;
tempk6_32 = 0:length(Xk6_32)-1;
tempk6_64 = 0:length(Xk6_64)-1;

%根据频域的自变量序号以及频域自变量修正量求得自变量w/pi的范围
k6_16 = (2/M1)*tempk6_16;
k6_32 = (2/M2)*tempk6_32;
k6_64 = (2/M3)*tempk6_64;

Tp1 = M1*T; F1 = 1/Tp1; 
k1 = -M1/2 : M1/2-1; fk1 = k1 *F1;

Tp2 = M2*T; F2 = 1/Tp2; 
k2 = -M2/2 : M2/2-1; fk2 = k2 *F2;

Tp3 = M3*T; F3 = 1/Tp3; 
k3 = -M3/2 : M3/2-1; fk3 = k3 *F3;

%画图
figure(3);

subplot(3,1,1);
stem(fk1,abs(Xk6_16),'.');    %会失真，因为x6(n)周期为32，此时观测时间为16，小于周期
xlabel('f/Hz');
ylabel('|Xk6_16|');
title('变换区间为N=16的x6(n)的幅频特性曲线');
axis([-M1*F1/2-1, M1*F1/2-1, 0, 1.2*max(abs(Xk6_16))]);

subplot(3,1,2);
stem(fk2,abs(Xk6_32),'.');    %不会失真，因为x6(n)周期为32，此时观测时间为32，不小于周期
xlabel('f/Hz');
ylabel('|Xk6_32|');
title('变换区间为N=32的x6(n)的幅频特性曲线');
axis([-M2*F2/2-1, M2*F2/2-1, 0, 1.2*max(abs(Xk6_32))]);

subplot(3,1,3);
stem(fk3,abs(Xk6_64),'.');    %不会失真，因为x6(n)周期为32，此时观测时间为64，不小于周期
xlabel('f/Hz');
ylabel('|Xk6_64|');
title('变换区间为N=64的x6(n)的幅频特性曲线');
axis([-M3*F3/2-1, M3*F3/2-1, 0, 1.2*max(abs(Xk6_64))]);
