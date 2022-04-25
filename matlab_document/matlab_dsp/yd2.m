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
wdelay0=rand(1,L)*2*pi; %多径信号相位
x=cos(2*pi*f*t);
for i=1:L
 wdelay(i,:)=cos(2*pi*fdelay(i)*t); %每径时延
 s(i,:)=decay*cos(2*pi*f*t+wdelay(i,:)+wdelay0(i)); %每径接收信号
end
y=sum(s)/sqrt(L);
figure(1);
subplot(211);
plot(t,x);
xlabel('t/s');
ylabel('x(t)');
title('单频信号时域图');
axis([0 2 -1.5 1.5]);
subplot(212);
f1=abs(fft(x,1024));
plot(0:100/1024:100-100/1024,f1);
xlabel('f/Hz');ylabel('H(f)');title('单频信号频域图');
axis([0 30 0 500]);
figure(2);
subplot(211);
plot(t,y);
xlabel('t/s');
ylabel('y(t)');
title('经过 20 径后信号时域图');
subplot(212);
f2=abs(fft(y,1024));
plot(0:100/1024:100-100/1024,f2);
xlabel('f/Hz');
ylabel('H(f)');
title('经过 20 径后信号频域图');
axis([0 30 0 500]);