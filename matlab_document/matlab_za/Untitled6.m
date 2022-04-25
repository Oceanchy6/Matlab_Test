N=10;
n=0:N-1;    
xn=10*sin(2*pi*f1*n+1/3*pi)+2*sin(2*pi*f2*n+1/4*pi);
R=xcorr(xn);           %N点离散信号自相关有2N-1个点
Xk_1=abs(fft(R));
L=length(Xk_1);
L1=0:L-1;
subplot(1,3,1)
stem(L1,Xk_1,'.')
title('自相关的fft');

subplot(1,3,2)
Xk_2=abs(fft(xn,L));
n2=0:length(Xk_2)-1;
stem(n2,Xk_2,'.')
title('信号fft的模');

subplot(1,3,3)
Xk_3=fft(xn,L).*conj(fft(xn,L));
n3=0:length(Xk_2)-1;
stem(n3,Xk_3,'.')
title('信号fft的模的平方');