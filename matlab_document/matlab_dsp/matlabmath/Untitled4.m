%ʱ�����������֤���� exp2a.m 
Tp=64/1000;%�۲�ʱ�� Tp=64 ΢��
%���� M ���������� x(n) 
% Fs=1000; T=1/Fs; 
Fs=1000; T=1/Fs; 
M=Tp*Fs; n=0:M-1; 
A=444.128; alph=pi*50*2^0.5; omega=pi*50*2^0.5; 
xnt=A*exp(-alph*n*T).*sin(omega*n*T); 
Xk=T*fft(xnt,M);%M �� FFT[xnt)] 
yn='xa(nT)';subplot(3,2,1); 
tstem(xnt,yn); % �����Ա��ͼ���� tstem ��������ͼ
box on; title('(a) Fs=1000Hz'); 
k=0:M-1; fk=k/Tp; 
subplot(3,2,2); plot(fk,abs(Xk)); 
title('(a) T*FT[xa(nT)],Fs=1000Hz'); 
xlabel('f(Hz)'); ylabel(' ���� '); 
axis([0,Fs,0,1.2*max(abs(Xk))])