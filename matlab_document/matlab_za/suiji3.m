close all;
N=1024;
m=200;
F1=zeros(1,m);
F2=zeros(1,m);
for i=1:m
n=linspace(1,1024,N); %�������1��1024����N����
f=n/N;
w=randn(1,N);  %���ɾ�ֵΪ0������Ϊ1�ĸ�˹������
x(n)=10*sin(2*pi*0.1*n+pi/3)+2*sin(2*pi*0.3*n+pi/4);
y(n)=x(n)+i*w;
X=fft(x(n),N); %����x�Ŀ��ٸ���Ҷ�任
Ps(i)=sum((x(n)-mean(x(n))).^2);%signal power
Pn(i)=sum((y(n)-x(n)).^2);   %noise power
SNR(i)=10*log10(Ps/Pn);
p=X(1:N);
pm=max(p(f<0.5));
i1=find(p==pm);
f1=f(i1);
F1(i)=f1;
pm2=max(p(f>0.5));
i2=find(p==pm2);
f2=f(i2);
F2(i)=f2;
MSE1(i)=mse(F1);
MSE2(i)=mse(F2);
end
figure(1)
plot(SNR,MSE1,'g-')
xlabel('�����SNR/dB');
ylabel('f1���Ƶľ������MSE1');
title('f1���Ƶľ������������ȹ�ϵ');
figure(2)
plot(SNR,MSE2,'b-')
xlabel('�����SNR/dB');
ylabel('f2���Ƶľ������MSE2');
title('f2���Ƶľ������������ȹ�ϵ');
grid on;