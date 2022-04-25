clear
f1=0.1;
f2=0.3;
N=128;
n=0:N;
xn=10*sin(2*pi*f1*n+1/3*pi)+2*sin(2*pi*f2*n+1/4*pi);
f1_shuzu=zeros(1,400);     %ÿ��������µ�f1��400�ι���Ƶ��ֵ
f2_shuzu=zeros(1,400);     %ÿ��������µ�f2��400�ι���Ƶ��ֵ
f1_aver=zeros(1,401);       %��ͬ������µ�f1�Ĺ���Ƶ�ʵ�ƽ��ֵ
f2_aver=zeros(1,401);       %��ͬ������µ�f2�Ĺ���Ƶ�ʵ�ƽ��ֵ
f1_mse=zeros(1,401);        %��ͬ������µ�f1�ľ������
f2_mse=zeros(1,401);        %��ͬ������µ�f2�ľ������
 
i=1;
for snr=-30:0.1:10        %401�������SNR
    for  j=1:400            %��400�ι���
      yn=awgn(xn,snr);      %���ź�xn����Ӽ��Ը�˹������
      rn=xcorr(yn);         %���ź�yn�������������
      Wn=abs(fft(rn));
      for k=1:N
         half_Wn(k)=Wn(k);               %ȡ������ǰN����
      end
      
    [pks,locs]=findpeaks(half_Wn,'SortStr','descend','minpeakdistance',10);
%Ѱ���ҹ涨���ڷ�ֵ�������������
    f1_shuzu(j)=locs(1)/(2*N);                      
%�����Ƶ�Ƶ��������ֵת��Ϊ��ʵֵ
    f2_shuzu(j)=locs(2)/(2*N);
    end
    
    f1_aver(i)=mean(f1_shuzu);  %��400�ι��Ƶ�f1����ȡƽ��ֵ
    f2_aver(i)=mean(f2_shuzu);  %��400�ι��Ƶ�f2����ȡƽ��ֵ
    f1_mse(i)=var(f1_shuzu)+(f1-f1_aver(i)).^2; 
%���SNR�����õ�Ƶ�ʹ��Ƶľ������
    f2_mse(i)=var(f2_shuzu)+(f2-f2_aver(i)).^2;
    i=i+1;
end 
figure(1)           %����ͼһΪf1,f2����ֵ����snr�ı仯���
snr=-30:0.1:10;
plot(snr,f1_aver);
hold on
plot(snr,f2_aver);
xlabel('snr');
ylabel('Ƶ�ʹ���ֵ');
legend('����Ϊf1Ƶ�ʹ���ͼ��','����Ϊf2Ƶ�ʹ���ͼ��');
 
figure(2)       %����ͼ2Ϊf1,f2�ľ������mse����snr�ı仯���
plot(snr,f1_mse);  
hold on
plot(snr,f2_mse);
xlabel('snr');
ylabel('mse');
legend('���Ϊf1��mse','�ұ�Ϊf2��mse');