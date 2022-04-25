clear
f1=0.1;
f2=0.3;
N=120;
n=[0:N];
yn=10*sin(2*pi*f1*n+1/3*pi)+2*sin(2*pi*f2*n+1/4*pi);

index_f1=zeros(1,500);        %存储f1所有的估计频率
index_f2=zeros(1,500);        %存储f2所有的估计频率
MSE_f1=zeros(1,501);         %存储f1所有方差
MSE_f2=zeros(1,501);         %存储f2所有方差

k=1;
for snr=-50:0.1:0   %501个信噪比SNR
    for  j=1:500         %做500次估计
      xn_1=awgn(yn,snr);
      Xk=fft(xn_1,N);
      Xk_1=abs(Xk);
      [m,indexf1]=max(Xk_1);
      indexf1=(indexf1-1)/N;  %第一根谱线是频率为0的，应减去
      index_f1(j)=indexf1;
    %-------下面是f2的估计------------
      Xk_1(Xk_1==max(Xk_1))=0; %使用布尔数组引用矩阵中所有等于某值的元素，然后将其赋值为0。
      [m,indexf2]=max(Xk_1);
      indexf2=(indexf2-1)/N; 
      index_f2(j)=indexf2;
    end
    f1_guji(k)=mean(index_f1);
    MSE_f1(k)=var(index_f1);
    f2_guji(k)=mean(index_f2);
    MSE_f2(k)=var(index_f2);
    k=k+1;
end

snr=-50:0.1:0;
subplot(221);
plot(snr,MSE_f1);  %f1的寻找
subplot(222);
plot(snr,f1_guji);
title('f1的有关图像');


subplot(223);
plot(snr,MSE_f2);  %f2的寻找
subplot(224);
plot(snr,f2_guji);
title('f2的有关图像');