clear
f1=0.1;
f2=0.3;
N=128;
n=0:N;
yn=10*sin(2*pi*f1*n+1/3*pi)+2*sin(2*pi*f2*n+1/4*pi);
f1_shuzu=zeros(1,400);        %ÿ��������µ�f1��400�ι���Ƶ��ֵ
f2_shuzu=zeros(1,400);        %ÿ��������µ�f2��400�ι���Ƶ��ֵ
f1_aver=zeros(1,401);         %��ͬ������µ�f1�Ĺ���Ƶ�ʵ�ƽ��ֵ
f2_aver=zeros(1,401);         %��ͬ������µ�f2�Ĺ���Ƶ�ʵ�ƽ��ֵ
f1_mse=zeros(1,401);          %��ͬ������µ�f1�ľ������
f2_mse=zeros(1,401);          %��ͬ������µ�f2�ľ������

i=1;
for snr=-40:0.1:0   %401�������SNR
    for  j=1:400         %��400�ι���
      xn_1=awgn(yn,snr);
      Xk=abs(fft(xn_1,N));
      
      f1g=1;
      for m=1:20 
        if (Xk(m)>=Xk(f1g))
            f1g=m;
        end
      end
      f1_shuzu(j)=f1g/N;
      
    f2g=21;
      for m=21:64
        if (Xk(m)>=Xk(f2g))
            f2g=m;
        end
      end
      f2_shuzu(j)=f2g/N;
    end
    f1_aver(i)=mean(f1_shuzu);
    f1_mse(i)=var(f1_shuzu)+(f1-f1_aver(i)).^2;
    f2_aver(i)=mean(f2_shuzu);
    f2_mse(i)=var(f2_shuzu)+(f2-f2_aver(i)).^2;
    i=i+1;
end

figure(1)
snr=-40:0.1:0;
plot(snr,f1_aver);
hold on
plot(snr,f2_aver);
xlabel('snr');
ylabel('Ƶ�ʹ���ֵ');
legend('����Ϊf2Ƶ�ʹ���ͼ��','����Ϊf1Ƶ�ʹ���ͼ��');

