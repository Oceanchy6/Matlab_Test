clear
f1=0.1;
f2=0.3;
N=128;
n=0:N;
xn=10*sin(2*pi*f1*n+1/3*pi)+2*sin(2*pi*f2*n+1/4*pi);
f1_shuzu=zeros(1,400);     %每个信噪比下的f1的400次估计频率值
f2_shuzu=zeros(1,400);     %每个信噪比下的f2的400次估计频率值
f1_aver=zeros(1,401);       %不同信噪比下的f1的估计频率的平均值
f2_aver=zeros(1,401);       %不同信噪比下的f2的估计频率的平均值
f1_mse=zeros(1,401);        %不同信噪比下的f1的均方误差
f2_mse=zeros(1,401);        %不同信噪比下的f2的均方误差
 
i=1;
for snr=-30:0.1:10        %401个信噪比SNR
    for  j=1:400            %做400次估计
      yn=awgn(xn,snr);      %向信号xn中添加加性高斯白噪声
      rn=xcorr(yn);         %对信号yn进行自相关运算
      Wn=abs(fft(rn));
      for k=1:N
         half_Wn(k)=Wn(k);               %取功率谱前N个点
      end
      
    [pks,locs]=findpeaks(half_Wn,'SortStr','descend','minpeakdistance',10);
%寻峰且规定相邻峰值间隔并降序排列
    f1_shuzu(j)=locs(1)/(2*N);                      
%将估计的频率正整数值转换为真实值
    f2_shuzu(j)=locs(2)/(2*N);
    end
    
    f1_aver(i)=mean(f1_shuzu);  %对400次估计的f1向量取平均值
    f2_aver(i)=mean(f2_shuzu);  %对400次估计得f2向量取平均值
    f1_mse(i)=var(f1_shuzu)+(f1-f1_aver(i)).^2; 
%求该SNR下所得的频率估计的均方误差
    f2_mse(i)=var(f2_shuzu)+(f2-f2_aver(i)).^2;
    i=i+1;
end 
figure(1)           %绘制图一为f1,f2估计值随信snr的变化情况
snr=-30:0.1:10;
plot(snr,f1_aver);
hold on
plot(snr,f2_aver);
xlabel('snr');
ylabel('频率估计值');
legend('下面为f1频率估计图像','上面为f2频率估计图像');
 
figure(2)       %绘制图2为f1,f2的均方误差mse随信snr的变化情况
plot(snr,f1_mse);  
hold on
plot(snr,f2_mse);
xlabel('snr');
ylabel('mse');
legend('左边为f1的mse','右边为f2的mse');