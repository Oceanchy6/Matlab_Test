%ʵ������ (3) ģ�������ź��׷��� ================= 
figure(4) 
Fs=64;T=1/Fs; 
N=16;n=0:N-1; %FFT�ı任���� N=16 
x6nT=cos(8*pi*n*T)+cos(16*pi*n*T)+cos(20*pi*n*T); 
%�� x6(t)16 �����
X6k16=fft(x6nT); %���� x6nT �� 16 �� DFT 
X6k16=fftshift(X6k16); %����Ƶ���Ƶ�Ƶ������
Tp=N*T;F=1/Tp; %Ƶ�ʷֱ��� F 
k=-N/2:N/2-1;fk=k*F; 
%���� 16 �� DFT��Ӧ�Ĳ�����Ƶ�ʣ�����Ƶ��Ϊ���ģ�
subplot(3,1,1);stem(fk,abs(X6k16),'.'); 
box on %���� 8 �� DFT�ķ�Ƶ����ͼ
title('(6a) 16 ��|DFT[x_6(nT)]|');xlabel('f(Hz)'); 
%%%%%%%%% 
%%%%%%%%% 
ylabel(' ���� '); 
axis([-N*F/2-1,N*F/2-1,0,1.2*max(abs(X6k16))]) 
N=32;n=0:N-1; %FFT�ı任���� N=16 
x6nT=cos(8*pi*n*T)+cos(16*pi*n*T)+cos(20*pi*n*T); 
%�� x6(t)32 �����
X6k32=fft(x6nT); %���� x6nT �� 32 �� DFT 
X6k32=fftshift(X6k32); %����Ƶ���Ƶ�Ƶ������
Tp=N*T;F=1/Tp; %Ƶ�ʷֱ��� F 
k=-N/2:N/2-1; 
fk=k*F; 
%���� 16 �� DFT��Ӧ�Ĳ�����Ƶ�ʣ�����Ƶ��Ϊ���ģ�
subplot(3, 1, 2);stem(fk, abs(X6k32), '.'); 
box on %���� 8 �� DFT�ķ�Ƶ����ͼ
title('(6b) 32 �� |DFT[x_6(nT)]|'); 
xlabel('f(Hz)');ylabel(' ���� '); 
axis([-N*F/2-1, N*F/2-1,0, 1.2*max(abs(X6k32))]) 
N=64;n=0:N-1; %FFT�ı任���� N=16 
x6nT=cos(8*pi*n*T)+cos(16*pi*n*T)+cos(20*pi*n*T); 
%�� x6(t)64 �����
X6k64=fft(x6nT); %���� x6nT �� 64 �� DFT 
X6k64=fftshift(X6k64); %����Ƶ���Ƶ�Ƶ������
Tp=N*T;F=1/Tp; %Ƶ�ʷֱ��� F 
k=-N/2:N/2-1;fk=k*F; 
%���� 16 �� DFT��Ӧ�Ĳ�����Ƶ�ʣ�����Ƶ��Ϊ���ģ�
subplot(3,1,3);stem(fk,abs(X6k64),'.'); 
box on%���� 8 �� DFT�ķ�Ƶ����ͼ
title('(6a) 64 ��|DFT[x_6(nT)]|'); 
xlabel('f(Hz)');ylabel(' ���� '); 
axis([-N*F/2-1,N*F/2-1,0, 1.2*max(abs(X6k64))])