clc;
clear;
%%
%ʵ��3-1

%�����Ա����Լ�Ƶ���Ա���������
n1 = 0:3;
n2 = 4:7;
M1 = 8;
M2 = 16;
%���캯��x1(n)��x2(n)��x3(n)
xn1 = [ones(1,4)];
xn2 = [n1+1, 8-n2];
xn3 = [4-n1, n2-3];

%�任����ΪN=8��FFT
Xk1_8 = fft(xn1,8);
Xk2_8 = fft(xn2,8);
Xk3_8 = fft(xn3,8);
%����Ƶ����Ա������
tempk1_8 = 0:length(Xk1_8)-1;
tempk2_8 = 0:length(Xk2_8)-1;
tempk3_8 = 0:length(Xk3_8)-1;
%����Ƶ����Ա�������Լ�Ƶ���Ա�������������Ա���w/pi�ķ�Χ
k1_8 = (2/M1)*tempk1_8; % (K*2PI)/N/PI ��һ������
k2_8 = (2/M1)*tempk2_8;
k3_8 = (2/M1)*tempk2_8;

%�任����ΪN=16��FFT
Xk1_16 = fft(xn1,16);
Xk2_16 = fft(xn2,16);
Xk3_16 = fft(xn3,16);
%����Ƶ����Ա������
tempk1_16 = 0:length(Xk1_16)-1;
tempk2_16 = 0:length(Xk2_16)-1;
tempk3_16 = 0:length(Xk3_16)-1;
%����Ƶ����Ա�������Լ�Ƶ���Ա�������������Ա���w/pi�ķ�Χ
k1_16 = (2/M2)*tempk1_16;
k2_16 = (2/M2)*tempk2_16;
k3_16 = (2/M2)*tempk2_16;

%��ͼ
figure(1);

subplot(3,2,1);
stem(k1_8,abs(Xk1_8),'.');      
xlabel('\omega/\pi');
ylabel('|Xk1_8|');
title('�任����ΪN=8��x1(n)�ķ�Ƶ��������');

subplot(3,2,2);
stem(k1_16,abs(Xk1_16),'.');    
xlabel('\omega/\pi');
ylabel('|Xk1_16|');
title('�任����ΪN=16��x1(n)�ķ�Ƶ��������');

subplot(3,2,3);
stem(k2_8,abs(Xk2_8),'.');
xlabel('\omega/\pi');
ylabel('|Xk2_8|');
title('�任����ΪN=8��x2(n)�ķ�Ƶ��������');

subplot(3,2,4);
stem(k2_16,abs(Xk2_16),'.');
xlabel('\omega/\pi');
ylabel('|Xk2_16|');
title('�任����ΪN=16��x2(n)�ķ�Ƶ��������');

subplot(3,2,5);
stem(k3_8,abs(Xk3_8),'.');
xlabel('\omega/\pi');
ylabel('|Xk3_8|');
title('�任����ΪN=8��x3(n)�ķ�Ƶ��������');

subplot(3,2,6);
stem(k3_16,abs(Xk3_16),'.');
xlabel('\omega/\pi');
ylabel('|Xk3_16|');
title('�任����ΪN=16��x3(n)�ķ�Ƶ��������');

%%
%ʵ��3-2

%�����Ա����Լ�Ƶ���Ա���������
n = 0:15;   %ʵ��ԭ�����������ں��������������������ڵĳ�����FFT����x4(n)��Ҫ���õ��Ա�������Ϊ0��7����������������Ϊ8����x5(n)��Ҫ���õ��Ա�������Ϊ0��15����������������Ϊ16����ȡ����С���������Ա�������Ϊ0��15
M1 = 8;
M2 = 16;

%���캯��x4(n)��x5(n)
xn4 = cos(pi*n/4);
xn5 = cos(pi*n/4)+cos(pi*n/8);

%�任����ΪN=8��FFT
Xk4_8 = fft(xn4,8);
Xk5_8 = fft(xn5,8);
%����Ƶ����Ա������
tempk4_8 = 0:length(Xk4_8)-1;
tempk5_8 = 0:length(Xk5_8)-1;
%����Ƶ����Ա�������Լ�Ƶ���Ա�������������Ա���w/pi�ķ�Χ
k4_8 = (2/M1)*tempk4_8;
k5_8 = (2/M1)*tempk5_8;

%�任����ΪN=16��FFT
Xk4_16 = fft(xn4,16);
Xk5_16 = fft(xn5,16);
%����Ƶ����Ա������
tempk4_16 = 0:length(Xk4_16)-1;
tempk5_16 = 0:length(Xk5_16)-1;
%����Ƶ����Ա�������Լ�Ƶ���Ա�������������Ա���w/pi�ķ�Χ
k4_16 = (2/M2)*tempk4_16;
k5_16 = (2/M2)*tempk5_16;

%��ͼ
figure(2);

subplot(2,2,1);
stem(k4_8,abs(Xk4_8),'.');      %����ʧ�棬��Ϊx4(n) = cos(pi/4*n)����Ϊ8����ʱ�۲�ʱ��Ϊ8����С������
xlabel('\omega/\pi');
ylabel('|Xk4_8|');
title('�任����ΪN=8��x4(n)�ķ�Ƶ��������');

subplot(2,2,2);
stem(k4_16,abs(Xk4_16),'.');    %����ʧ�棬��Ϊx4(n) = cos(pi/4*n)����Ϊ8����ʱ�۲�ʱ��Ϊ16����С������
xlabel('\omega/\pi');
ylabel('|Xk4_16|');
title('�任����ΪN=16��x4(n)�ķ�Ƶ��������');

subplot(2,2,3);
stem(k5_8,abs(Xk5_8),'.');      %��ʧ�棬��Ϊx5(n) = cos(pi/4*n)+cos(pi/8*n)����Ϊ16����ʱ�۲�ʱ��Ϊ8��С������
xlabel('\omega/\pi');
ylabel('|Xk5_8|');
title('�任����ΪN=8��x5(n)�ķ�Ƶ��������');

subplot(2,2,4);
stem(k5_16,abs(Xk5_16),'.');    %����ʧ�棬��Ϊx5(n) = cos(pi/4*n)+cos(pi/8*n)����Ϊ16����ʱ�۲�ʱ��Ϊ16����С������
xlabel('\omega/\pi');
ylabel('|Xk5_16|');
title('�任����ΪN=16��x5(n)�ķ�Ƶ��������');

%%
%ʵ��3-3

%�����Ա����Լ�Ƶ���Ա���������
n = 0:63;   %ʵ��ԭ�����������ں��������������������ڵĳ�����FFT������Ϊ0.5s,��x6(n)��Ҫ���õ��Ա�������Ϊ0��31�������������ֱ任�������Ϊ64������Ҫ���Ա�������Ϊ0��63
t = 1/64*n; %��Ӧ��ʱ���еĳ���������t

Fs=64; T = 1/Fs;

M1 = 16;
M2 = 32;
M3 = 64;

n1 = 0:M1-1;
n2 = 0:M2-1;
n3 = 0:M3-1;

%���캯��x6(n)
xn6_1 = cos(8*pi*n1*T)+cos(16*pi*n1*T)+cos(20*pi*n1*T);
xn6_2 = cos(8*pi*n2*T)+cos(16*pi*n2*T)+cos(20*pi*n2*T);
xn6_3 = cos(8*pi*n3*T)+cos(16*pi*n3*T)+cos(20*pi*n3*T);

%FFT�ı任����N=16,32,64��Ӧ��Xk
Xk6_16 = fft(xn6_1,16);Xk6_16 = fftshift(Xk6_16);
Xk6_32 = fft(xn6_2,32);Xk6_32 = fftshift(Xk6_32);
Xk6_64 = fft(xn6_3,64);Xk6_64 = fftshift(Xk6_64);


%����Ƶ����Ա������
tempk6_16 = 0:length(Xk6_16)-1;
tempk6_32 = 0:length(Xk6_32)-1;
tempk6_64 = 0:length(Xk6_64)-1;

%����Ƶ����Ա�������Լ�Ƶ���Ա�������������Ա���w/pi�ķ�Χ
k6_16 = (2/M1)*tempk6_16;
k6_32 = (2/M2)*tempk6_32;
k6_64 = (2/M3)*tempk6_64;

Tp1 = M1*T; F1 = 1/Tp1; 
k1 = -M1/2 : M1/2-1; fk1 = k1 *F1;

Tp2 = M2*T; F2 = 1/Tp2; 
k2 = -M2/2 : M2/2-1; fk2 = k2 *F2;

Tp3 = M3*T; F3 = 1/Tp3; 
k3 = -M3/2 : M3/2-1; fk3 = k3 *F3;

%��ͼ
figure(3);

subplot(3,1,1);
stem(fk1,abs(Xk6_16),'.');    %��ʧ�棬��Ϊx6(n)����Ϊ32����ʱ�۲�ʱ��Ϊ16��С������
xlabel('f/Hz');
ylabel('|Xk6_16|');
title('�任����ΪN=16��x6(n)�ķ�Ƶ��������');
axis([-M1*F1/2-1, M1*F1/2-1, 0, 1.2*max(abs(Xk6_16))]);

subplot(3,1,2);
stem(fk2,abs(Xk6_32),'.');    %����ʧ�棬��Ϊx6(n)����Ϊ32����ʱ�۲�ʱ��Ϊ32����С������
xlabel('f/Hz');
ylabel('|Xk6_32|');
title('�任����ΪN=32��x6(n)�ķ�Ƶ��������');
axis([-M2*F2/2-1, M2*F2/2-1, 0, 1.2*max(abs(Xk6_32))]);

subplot(3,1,3);
stem(fk3,abs(Xk6_64),'.');    %����ʧ�棬��Ϊx6(n)����Ϊ32����ʱ�۲�ʱ��Ϊ64����С������
xlabel('f/Hz');
ylabel('|Xk6_64|');
title('�任����ΪN=64��x6(n)�ķ�Ƶ��������');
axis([-M3*F3/2-1, M3*F3/2-1, 0, 1.2*max(abs(Xk6_64))]);