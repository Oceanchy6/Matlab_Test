f1=0.1;
f2=0.3;
N=128;
M=100;
n=[0:N-1];
m=[0:M-1];
xn=10*sin(2*pi*f1*n+1/3*pi)+2*sin(2*pi*f2*n+1/4*pi);
Xk=fft(xn,N);
Yk=fft(xn,M);
subplot(211);
stem(n/N,abs(Xk),'.')  %取Xk的模值
xlabel('频率');
ylabel('|Xk|');
title('变换区间为N=128的xn的离散傅里叶变换');
subplot(212);
stem(m/M,abs(Yk),'.')  %取Xk的模值
xlabel('频率');
ylabel('|Yk|');
title('变换区间为N=100的yn的离散傅里叶变换');
