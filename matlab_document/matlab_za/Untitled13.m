clear;clc
N=128;%信号样本数
n=0:N-1;
f1=0.1;f2=0.3;
xn=1*sin(2*pi*f1*n+pi/3)+2*sin(2*pi*f2*n+pi/4);
R1n=zeros(1,2*N-1);
R2n=zeros(1,2*N-1);

for m=1:N
    sum1=0;
    for n=1:N-m+1
    sum1=sum1+xn(n).*xn(m+n-1);
    end
    R1n(N+m-1)=sum1/(N-m+1);
    R1n(N+1-m)=R1n(N+m-1);
end

R1nn=xcorr(xn,'unbiased');
figure(1);
subplot(211);
stem(R1n,'.');
subplot(2,1,2);
stem(R1nn,'.');

for m=1:N
    sum2=0;
    for n=1:N-m+1
    sum2=sum2+xn(n).*xn(m+n-1);
    end
    R2n(N+m-1)=sum2/N;
    R2n(N+1-m)=R2n(N+m-1);
end

R2nn=xcorr(xn,'biased');

figure(2);
subplot(211);
stem(R2n,'.');
subplot(2,1,2);
stem(R2nn,'.');