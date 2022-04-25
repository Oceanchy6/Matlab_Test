clc;
close all;
clear all;
A=1;
f=10;
decay=0.8; 
dt=0.01; 
t=0:dt:10;
L=20;
fdelay=2*rand(1,L);
wdelay0=rand(1,L)*2*pi; %�ྶ�ź���λ
x=cos(2*pi*f*t);
for i=1:L
 wdelay(i,:)=cos(2*pi*fdelay(i)*t); %ÿ��ʱ��
 s(i,:)=decay*cos(2*pi*f*t+wdelay(i,:)+wdelay0(i)); %ÿ�������ź�
end
y=sum(s)/sqrt(L);
figure(1);
subplot(211);
plot(t,x);
xlabel('t/s');
ylabel('x(t)');
title('��Ƶ�ź�ʱ��ͼ');
axis([0 2 -1.5 1.5]);
subplot(212);
f1=abs(fft(x,1024));
plot(0:100/1024:100-100/1024,f1);
xlabel('f/Hz');ylabel('H(f)');title('��Ƶ�ź�Ƶ��ͼ');
axis([0 30 0 500]);
figure(2);
subplot(211);
plot(t,y);
xlabel('t/s');
ylabel('y(t)');
title('���� 20 �����ź�ʱ��ͼ');
subplot(212);
f2=abs(fft(y,1024));
plot(0:100/1024:100-100/1024,f2);
xlabel('f/Hz');
ylabel('H(f)');
title('���� 20 �����ź�Ƶ��ͼ');
axis([0 30 0 500]);