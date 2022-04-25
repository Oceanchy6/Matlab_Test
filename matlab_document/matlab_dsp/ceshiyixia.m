clear
N=128;%信号样本数
n=1:N;
f1=0.1;f2=0.3;
xn=10*sin(2*pi*f1*n+pi/3)+2*sin(2*pi*f2*n+pi/4);
f1gj=zeros(1,100);           %储存100次估计中每次的估计值
f2gj=zeros(1,100);
a1=zeros(1,100);             %储存每一个SNR所对应的频率估计值
a2=zeros(1,100);
var1=zeros(1,100);           %储存每一个SNR所对应的频率估计的方差
var2=zeros(1,100);
bia1=zeros(1,100);           %储存每一个SNR所对应的频率估计的偏差
bia2=zeros(1,100);
mse1=zeros(1,100);           %储存每一个SNR所对应的频率估计的均方误差
mse2=zeros(1,100);
half_Wn=zeros(1,N);
%采用自相关估计信号的频率
for snr=1:400
    sum1=0;sum2=0;    
    for cishu=1:100
    yn=awgn(xn,(snr/10)-30);        %SNR的变化范围是-30~10
    Rn=xcorr(yn);
    Wn=abs(fft(Rn));
    for i=1:N
    half_Wn(i)=Wn(i);               %取功率谱前N个点
    end
    [a,b] = findpeaks(half_Wn,'SortStr','descend');%利用寻峰函数降序排列找出估计的频率，其中数组b的第一项和第二项便是得到估计值
    f1gj(cishu)=b(1)/(2*N);         %将估计的频率正整数值转换为真实值
    sum1=sum1+f1gj(cishu);          %将100次估计值求和
    f2gj(cishu)=b(2)/(2*N);
    sum2=sum2+f2gj(cishu);
    end
    avef1=sum1/100;                 %求得100次估计值的平均值，即在该SNR下所得的频率估计
    avef2=sum2/100;
    s1=0;s2=0;
    for i=1:100
        s1=(f1gj(i)-avef1).^2+s1;   %利用s1求和为后面的求方差做准备
        s2=(f2gj(i)-avef2).^2+s2;
    end
    var1(snr)=s1/100;               %求该SNR下所得的频率估计方差
    var2(snr)=s2/100;
    bia1(snr)=f1-avef1;             %求该SNR下所得的频率估计偏差
    bia2(snr)=f2-avef2;
    a1(snr)=avef1;                  %储存该SNR下所得的频率估计值
    a2(snr)=avef2;
    mse1(snr)=var1(snr)+((bia1(snr)).^2);   %求该SNR下所得的频率估计的均方误差
    mse2(snr)=var2(snr)+((bia2(snr)).^2);
end
figure(1)                           %作图，实线代表f1的估计值随SNR的变化关系；
                                    %虚线代表f2的估计值随SNR的变化关系；
s=1:400;
plot(s/10-30,a1,'-b');
hold on
plot(s/10-30,a2,'-r');
%axis([0,snr,0,0.35]);
title('估计值随SNR的变换关系');
xlabel('SNR');
ylabel('估计值');
legend('guji(f1)', 'guji(f2)');
%采用fft估计信号的频率

figure(2)                           %作图，实线代表f1的mse随SNR的变化关系；
s=1:400;                            %虚线代表f2的mse随SNR的变化关系；
plot(s/10-30,mse1,'-b');
hold on
plot(s/10-30,mse2,'-r');
title('估计值的MSE随SNR的变换关系');
xlabel('SNR');
ylabel('MSE');
legend('mse(f1)', 'mse(f2)');