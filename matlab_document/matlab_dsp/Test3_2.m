%ʵ������ (2) ���������׷��� =================== 
N=8;n=0:N-1; %FFT�ı任���� N=8 
x4n=cos(pi*n/4); 
x5n=cos(pi*n/4)+cos(pi*n/8); 
X4k8=fft(x4n); %���� x4n �� 8 �� DFT 
X5k8=fft(x5n); %���� x5n �� 8 �� DFT 
N=16;n=0:N-1; %FFT�ı任���� N=16 
x4n=cos(pi*n/4); 
x5n=cos(pi*n/4)+cos(pi*n/8); 
X4k16=fft(x4n); %���� x4n �� 16 �� DFT 
X5k16=fft(x5n); %���� x5n �� 16 �� DFT 
figure(3) 
subplot(2,2,1);mstem(X4k8); 
%���� 8 �� DFT�ķ�Ƶ����ͼ
title('(4a) 8 �� DFT[x_4(n)]'); 
xlabel(' ��/ ��');ylabel(' ���� '); 
axis([0,2,0,1.2*max(abs(X4k8))]) 
subplot(2,2,3);mstem(X4k16); 
%���� 16 �� DFT�ķ�Ƶ����ͼ
title('(4b)16 �� DFT[x_4(n)]'); 
xlabel(' ��/ ��');ylabel(' ���� '); 
axis([0,2,0,1.2*max(abs(X4k16))]) 
subplot(2,2,2);mstem(X5k8); 
%���� 8 �� DFT�ķ�Ƶ����ͼ
title('(5a) 8 �� DFT[x_5(n)]');xlabel(' ��/�� '); 
ylabel(' ���� '); 
axis([0,2,0,1.2*max(abs(X5k8))]) 
subplot(2,2,4);mstem(X5k16); 
%���� 16 �� DFT�ķ�Ƶ����ͼ
title('(5b)16 �� DFT[x_5(n)]');xlabel(' ��/ ��'); 
ylabel(' ���� '); 
axis([0,2,0,1.2*max(abs(X5k16))])