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
stem(n/N,abs(Xk),'.')  %ȡXk��ģֵ
xlabel('Ƶ��');
ylabel('|Xk|');
title('�任����ΪN=128��xn����ɢ����Ҷ�任');
subplot(212);
stem(m/M,abs(Yk),'.')  %ȡXk��ģֵ
xlabel('Ƶ��');
ylabel('|Yk|');
title('�任����ΪN=100��yn����ɢ����Ҷ�任');
