f1=0.1;
f2=0.3;
N=115;
n=[0:N];
yn=10*sin(2*pi*f1*n+1/3*pi)+2*sin(2*pi*f2*n+1/4*pi);

index_f1=zeros(1,500);        %�洢f1���еĹ���Ƶ��
index_f2=zeros(1,500);        %�洢f2���еĹ���Ƶ��
MSE_f1=zeros(1,501);         %�洢f1���з���
MSE_f2=zeros(1,501);         %�洢f2���з���

k=1;
for SNR=-50:0.1:0   %501�������SNR
    i=1;
    for  j=1:500         %��500�ι���
      xn_1=awgn(yn,SNR);
      Xk=fft(xn_1,N);
      Xk_1=abs(Xk);
      for re=60:
      [m,indexf1]=max(Xk_1);
      indexf1=(indexf1-1)/N;  %��һ��������Ƶ��Ϊ0�ģ�Ӧ��ȥ
      index_f1(i)=indexf1;
    %-------������f2�Ĺ���------------
      Xk_1(Xk_1==max(Xk_1))=0; %ʹ�ò����������þ��������е���ĳֵ��Ԫ�أ�Ȼ���丳ֵΪ0��
      [m,indexf2]=max(Xk_1);
      indexf2=(indexf2-1)/N; 
      index_f2(i)=indexf2;
      i=i+1;
    end
    f1_guji(k)=mean(index_f1);
    MSE_f1(k)=var(index_f1);
    f2_guji(k)=mean(index_f2);
    MSE_f2(k)=var(index_f2);
    k=k+1;
end

SNR=-50:0.1:0;  
figure(1),plot(SNR,MSE_f1);  %f1��Ѱ��
hold on;                  %������ͼ������һ��ͼ����
plot(SNR,f1_guji);
title('f1���й�ͼ��');
legend('������f1������ȡ�������ͼ��','������f1������ȡ�������ͼ');

figure(2),plot(SNR,MSE_f2);  %f2��Ѱ��
hold on;
plot(SNR,f2_guji);
title('f2���й�ͼ��');
legend('������f2������ȡ�������ͼ��','������f2������ȡ�������ͼ');