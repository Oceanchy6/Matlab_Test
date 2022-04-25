clc
clear
N=256;            %采样点数为256
p=70;             %阶数p取为N/4与N/3之间最好
f1=0.1;
f2=0.3;
n=1:N;
xn=10*sin(2*pi*f1*n+pi/3)+2*sin(2*pi*f2*n+pi/4);

ef=zeros(p+1,N);
eb=zeros(p+1,N);    
a=zeros(p,p);        %存储不同阶数的AR模型系数
k=zeros(1,p+1);      %存储各阶反射系数
f1_shuzu=zeros(1,100);     %每个信噪比下的f1的100次估计频率值
f2_shuzu=zeros(1,100);     %每个信噪比下的f2的100次估计频率值
f1_aver=zeros(1,401);       %不同信噪比下的f1的估计频率的平均值
f2_aver=zeros(1,401);       %不同信噪比下的f2的估计频率的平均值
f1_mse=zeros(1,401);        %不同信噪比下的f1的均方误差
f2_mse=zeros(1,401);        %不同信噪比下的f2的均方误差

t=1;
%采用burg算法进行功率谱估计，进而估计频率f1、f2。
for snr=-10:0.1:30        %401个信噪比SNR
    for  cishu=1:100            %做100次估计
        yn=awgn(xn,snr);      %向信号xn中添加加性高斯白噪声

        ef(1,:)=yn;     %零阶预测误差等于信号值
        eb(1,:)=yn;   

        %通过Burg算法直接计算的出K反射系数
        for m=2:p+1                 %m=2时是一阶
            k_f=ef(m-1,:);
            k_b=eb(m-1,:);
            k_f=k_f(m:N);
            k_b=k_b(m-1:N-1);
            k(m)=-2*sum(k_f.*k_b)/sum(k_f.^2+k_b.^2);

            for  n=m:N
                ef(m,n)=ef(m-1,n)+k(m)*eb(m-1,n-1);
                eb(m,n)=eb(m-1,n-1)+k(m)*ef(m-1,n);
            end
        end

        %1阶AR模型的系数和预测误差功率
        a(1,1)=k(2);
        G2=zeros(1,p);
        R0=sum(conj(yn(1:N)).*yn(1:N))/N; %求得自相关函数第一项的值
        G2(1)=R0*(1-a(1,1)^2);              %计算1阶预测是的最小预测误差功率
        %2至p阶AR模型的系数和预测误差功率
        for m=2:p
            a(m,m)=k(m+1);
            for i=1:m-1
                a(m,i)=a(m-1,i)+k(m+1)*a(m-1,m-i);
            end
            G2(m)=G2(m-1)*(1-a(m,m)^2);
        end
        %p阶AR模型的系数
        A=zeros(1,p);
        for i=1:p
            A(i)=a(p,i);
        end
        %通过freqz(B,A，N)函数求频率特性H，
        [H,w]=freqz(G2(p)^0.5,[1,A],N);  
        Hf=abs(H);              %H为包含离散系统对应区间N个频率等分点的频率特性
        Sx=Hf.^2;               %对应的功率谱密度,%G2为Rx（0）与累加项的和，故令初值为R（1）即Rx（0)
        f=w/(2*pi);
        [pks,locs]=findpeaks(Sx,'SortStr','descend','minpeakdistance',10);
        f1_shuzu(cishu)=locs(2)/(2*N);  
        f2_shuzu(cishu)=locs(1)/(2*N);
    end
    f1_aver(t)=mean(f1_shuzu);  %对100次估计的f1向量取平均值
    f2_aver(t)=mean(f2_shuzu);  %对100次估计得f2向量取平均值
    f1_mse(t)=var(f1_shuzu)+(f1-f1_aver(t)).^2; 
    %求该SNR下所得的频率估计的均方误差
    f2_mse(t)=var(f2_shuzu)+(f2-f2_aver(t)).^2;
    t=t+1;
end
figure(1)           %绘制图一为f1,f2估计值随信snr的变化情况
snr=-10:0.1:30;
plot(snr,f1_aver,'--');
hold on
plot(snr,f2_aver);
%tit1e('估计值随SNR的变换关系');
xlabel('snr');
ylabel('频率估计值');
legend('虚线为f1频率估计图像','实线为f2频率估计图像');
 
figure(2)       %绘制图2为f1,f2的均方误差mse随信snr的变化情况
plot(snr,f1_mse,'--');  
hold on
plot(snr,f2_mse);
%tit1e('估计值的MsE随SNR的变换关系');
xlabel('snr');
ylabel('mse');
legend('虚线为f1的mse','实线为f2的mse');
