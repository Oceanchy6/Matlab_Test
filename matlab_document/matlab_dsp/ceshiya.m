clc
clear
N=256;            %采样点数为256
p=70;             %阶数p取为N/4与N/3之间最好
f1=0.1;
f2=0.3;
n=1:N;
xn=10*sin(2*pi*f1*n+pi/3)+2*sin(2*pi*f2*n+pi/4);
A=zeros(p,p);                   %存储矩阵系数矩阵
B=zeros(p,1);                   %存储系统函数参数
C=zeros(p,1);                   %存储p个xn自相关函数

f1_shuzu=zeros(1,100);     %每个信噪比下的f1的100次估计频率值
f2_shuzu=zeros(1,100);     %每个信噪比下的f2的100次估计频率值
f1_aver=zeros(1,401);       %不同信噪比下的f1的估计频率的平均值
f2_aver=zeros(1,401);       %不同信噪比下的f2的估计频率的平均值
f1_mse=zeros(1,401);        %不同信噪比下的f1的均方误差
f2_mse=zeros(1,401);        %不同信噪比下的f2的均方误差

t=1;
%采用Yule-Walker方程进行功率谱估计，进而估计频率f1、f2。
for snr=-30:0.1:10        %401个信噪比SNR
for  cishu=1:100            %做100次估计
    yn=awgn(xn,snr);      %向信号xn中添加加性高斯白噪声
    R=xcorr(yn,'biased');           %xn有偏的自相关函数
    Rx=zeros(1,p+1);
    for i=1:p+1
        Rx(i)=R(N+i-1);       %其中索引从1开始，故用Rx（1）-Rx（p+1）代表从0到p      
    end
    for i=1:p
        for j=1:p
            m=abs(i-j);
            A(i,j)=Rx(m+1);         %构造矩阵系数矩阵
        end
    end
    for i=1:p
        C(i,1)=-Rx(i+1);
    end
    B=A\C;                          %矩阵求逆的系统函数参数

    a=zeros(1,p);
    for i=1:p
        a(i)=B(i,1);                %系统函数参数赋予a向量
    end

    G2=R(1);                        %G2为Rx（0）与累加项的和，故令初值为R（1）即Rx（0)

    for i=1:p
        G2=G2+a(i)*Rx(i+1);         %系统增益的平方
    end
     %通过freqz(B,A，N)函数求频谱特性，B和A分别对应系统函数H(z)的分子分母多项式的系数向量
    [H,w]=freqz(G2^0.5,[1,a],N);    
    Hf=abs(H);              %H为包含离散系统对应区间N个频率等分点的频率特性
    Sx=Hf.^2;               %对应的功率谱密度,%G2为Rx（0）与累加项的和，故令初值为R（1）即Rx（0)
    f=w/(2*pi);
    [pks,locs]=findpeaks(Sx,'SortStr','descend','minpeakdistance',10);
    f1_shuzu(cishu)=locs(1)/(2*N);  
    f2_shuzu(cishu)=locs(2)/(2*N);
end
i=1;
    f1_aver(t)=mean(f1_shuzu);  %对100次估计的f1向量取平均值
    f2_aver(t)=mean(f2_shuzu);  %对100次估计得f2向量取平均值
    f1_mse(t)=var(f1_shuzu)+(f1-f1_aver(t)).^2; 
%求该SNR下所得的频率估计的均方误差
    f2_mse(t)=var(f2_shuzu)+(f2-f2_aver(t)).^2;
    t=t+1;
end
figure(1)           %绘制图一为f1,f2估计值随信snr的变化情况
snr=-30:0.1:10;
plot(snr,f1_aver);
hold on
plot(snr,f2_aver);
%tit1e('估计值随SNR的变换关系');
xlabel('snr');
ylabel('频率估计值');
legend('下面为f1频率估计图像','上面为f2频率估计图像');
 
figure(2)       %绘制图2为f1,f2的均方误差mse随信snr的变化情况
plot(snr,f1_mse);  
hold on
plot(snr,f2_mse);
%tit1e('估计值的MsE随SNR的变换关系');
xlabel('snr');
ylabel('mse');
legend('左边为f1的mse','右边为f2的mse');