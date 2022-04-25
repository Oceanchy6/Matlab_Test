clc
clear
N=256;            %��������Ϊ256
p=70;             %����pȡΪN/4��N/3֮�����
f1=0.1;
f2=0.3;
n=1:N;
xn=10*sin(2*pi*f1*n+pi/3)+2*sin(2*pi*f2*n+pi/4);
A=zeros(p,p);                   %�洢����ϵ������
B=zeros(p,1);                   %�洢ϵͳ��������
C=zeros(p,1);                   %�洢p��xn����غ���

f1_shuzu=zeros(1,100);     %ÿ��������µ�f1��100�ι���Ƶ��ֵ
f2_shuzu=zeros(1,100);     %ÿ��������µ�f2��100�ι���Ƶ��ֵ
f1_aver=zeros(1,401);       %��ͬ������µ�f1�Ĺ���Ƶ�ʵ�ƽ��ֵ
f2_aver=zeros(1,401);       %��ͬ������µ�f2�Ĺ���Ƶ�ʵ�ƽ��ֵ
f1_mse=zeros(1,401);        %��ͬ������µ�f1�ľ������
f2_mse=zeros(1,401);        %��ͬ������µ�f2�ľ������

t=1;
%����Yule-Walker���̽��й����׹��ƣ���������Ƶ��f1��f2��
for snr=-30:0.1:10        %401�������SNR
for  cishu=1:100            %��100�ι���
    yn=awgn(xn,snr);      %���ź�xn����Ӽ��Ը�˹������
    R=xcorr(yn,'biased');           %xn��ƫ������غ���
    Rx=zeros(1,p+1);
    for i=1:p+1
        Rx(i)=R(N+i-1);       %����������1��ʼ������Rx��1��-Rx��p+1�������0��p      
    end
    for i=1:p
        for j=1:p
            m=abs(i-j);
            A(i,j)=Rx(m+1);         %�������ϵ������
        end
    end
    for i=1:p
        C(i,1)=-Rx(i+1);
    end
    B=A\C;                          %���������ϵͳ��������

    a=zeros(1,p);
    for i=1:p
        a(i)=B(i,1);                %ϵͳ������������a����
    end

    G2=R(1);                        %G2ΪRx��0�����ۼ���ĺͣ������ֵΪR��1����Rx��0)

    for i=1:p
        G2=G2+a(i)*Rx(i+1);         %ϵͳ�����ƽ��
    end
     %ͨ��freqz(B,A��N)������Ƶ�����ԣ�B��A�ֱ��Ӧϵͳ����H(z)�ķ��ӷ�ĸ����ʽ��ϵ������
    [H,w]=freqz(G2^0.5,[1,a],N);    
    Hf=abs(H);              %HΪ������ɢϵͳ��Ӧ����N��Ƶ�ʵȷֵ��Ƶ������
    Sx=Hf.^2;               %��Ӧ�Ĺ������ܶ�,%G2ΪRx��0�����ۼ���ĺͣ������ֵΪR��1����Rx��0)
    f=w/(2*pi);
    [pks,locs]=findpeaks(Sx,'SortStr','descend','minpeakdistance',10);
    f1_shuzu(cishu)=locs(1)/(2*N);  
    f2_shuzu(cishu)=locs(2)/(2*N);
end
i=1;
    f1_aver(t)=mean(f1_shuzu);  %��100�ι��Ƶ�f1����ȡƽ��ֵ
    f2_aver(t)=mean(f2_shuzu);  %��100�ι��Ƶ�f2����ȡƽ��ֵ
    f1_mse(t)=var(f1_shuzu)+(f1-f1_aver(t)).^2; 
%���SNR�����õ�Ƶ�ʹ��Ƶľ������
    f2_mse(t)=var(f2_shuzu)+(f2-f2_aver(t)).^2;
    t=t+1;
end
figure(1)           %����ͼһΪf1,f2����ֵ����snr�ı仯���
snr=-30:0.1:10;
plot(snr,f1_aver);
hold on
plot(snr,f2_aver);
%tit1e('����ֵ��SNR�ı任��ϵ');
xlabel('snr');
ylabel('Ƶ�ʹ���ֵ');
legend('����Ϊf1Ƶ�ʹ���ͼ��','����Ϊf2Ƶ�ʹ���ͼ��');
 
figure(2)       %����ͼ2Ϊf1,f2�ľ������mse����snr�ı仯���
plot(snr,f1_mse);  
hold on
plot(snr,f2_mse);
%tit1e('����ֵ��MsE��SNR�ı任��ϵ');
xlabel('snr');
ylabel('mse');
legend('���Ϊf1��mse','�ұ�Ϊf2��mse');