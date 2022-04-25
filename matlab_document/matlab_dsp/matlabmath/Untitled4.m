%时域采样理论验证程序 exp2a.m 
Tp=64/1000;%观察时间 Tp=64 微秒
%产生 M 长采样序列 x(n) 
% Fs=1000; T=1/Fs; 
Fs=1000; T=1/Fs; 
M=Tp*Fs; n=0:M-1; 
A=444.128; alph=pi*50*2^0.5; omega=pi*50*2^0.5; 
xnt=A*exp(-alph*n*T).*sin(omega*n*T); 
Xk=T*fft(xnt,M);%M 点 FFT[xnt)] 
yn='xa(nT)';subplot(3,2,1); 
tstem(xnt,yn); % 调用自编绘图函数 tstem 绘制序列图
box on; title('(a) Fs=1000Hz'); 
k=0:M-1; fk=k/Tp; 
subplot(3,2,2); plot(fk,abs(Xk)); 
title('(a) T*FT[xa(nT)],Fs=1000Hz'); 
xlabel('f(Hz)'); ylabel(' 幅度 '); 
axis([0,Fs,0,1.2*max(abs(Xk))])