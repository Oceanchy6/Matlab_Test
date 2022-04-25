clc
clear
N=256;            %��������Ϊ256
p=70;             %����pȡΪN/4��N/3֮�����
f1=0.1;
f2=0.3;
n=1:N;
xn=10*sin(2*pi*f1*n+pi/3)+2*sin(2*pi*f2*n+pi/4);

ef=zeros(p+1,N);
eb=zeros(p+1,N);    
a=zeros(p,p);        %�洢��ͬ������ARģ��ϵ��
k=zeros(1,p+1);      %�洢���׷���ϵ��
f1_shuzu=zeros(1,100);     %ÿ��������µ�f1��100�ι���Ƶ��ֵ
f2_shuzu=zeros(1,100);     %ÿ��������µ�f2��100�ι���Ƶ��ֵ
f1_aver=zeros(1,401);       %��ͬ������µ�f1�Ĺ���Ƶ�ʵ�ƽ��ֵ
f2_aver=zeros(1,401);       %��ͬ������µ�f2�Ĺ���Ƶ�ʵ�ƽ��ֵ
f1_mse=zeros(1,401);        %��ͬ������µ�f1�ľ������
f2_mse=zeros(1,401);        %��ͬ������µ�f2�ľ������

t=1;
%����burg�㷨���й����׹��ƣ���������Ƶ��f1��f2��
for snr=-10:0.1:30        %401�������SNR
    for  cishu=1:100            %��100�ι���
        yn=awgn(xn,snr);      %���ź�xn����Ӽ��Ը�˹������

        ef(1,:)=yn;     %���Ԥ���������ź�ֵ
        eb(1,:)=yn;   

        %ͨ��Burg�㷨ֱ�Ӽ���ĳ�K����ϵ��
        for m=2:p+1                 %m=2ʱ��һ��
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

        %1��ARģ�͵�ϵ����Ԥ������
        a(1,1)=k(2);
        G2=zeros(1,p);
        R0=sum(conj(yn(1:N)).*yn(1:N))/N; %�������غ�����һ���ֵ
        G2(1)=R0*(1-a(1,1)^2);              %����1��Ԥ���ǵ���СԤ������
        %2��p��ARģ�͵�ϵ����Ԥ������
        for m=2:p
            a(m,m)=k(m+1);
            for i=1:m-1
                a(m,i)=a(m-1,i)+k(m+1)*a(m-1,m-i);
            end
            G2(m)=G2(m-1)*(1-a(m,m)^2);
        end
        %p��ARģ�͵�ϵ��
        A=zeros(1,p);
        for i=1:p
            A(i)=a(p,i);
        end
        %ͨ��freqz(B,A��N)������Ƶ������H��
        [H,w]=freqz(G2(p)^0.5,[1,A],N);  
        Hf=abs(H);              %HΪ������ɢϵͳ��Ӧ����N��Ƶ�ʵȷֵ��Ƶ������
        Sx=Hf.^2;               %��Ӧ�Ĺ������ܶ�,%G2ΪRx��0�����ۼ���ĺͣ������ֵΪR��1����Rx��0)
        f=w/(2*pi);
        [pks,locs]=findpeaks(Sx,'SortStr','descend','minpeakdistance',10);
        f1_shuzu(cishu)=locs(2)/(2*N);  
        f2_shuzu(cishu)=locs(1)/(2*N);
    end
    f1_aver(t)=mean(f1_shuzu);  %��100�ι��Ƶ�f1����ȡƽ��ֵ
    f2_aver(t)=mean(f2_shuzu);  %��100�ι��Ƶ�f2����ȡƽ��ֵ
    f1_mse(t)=var(f1_shuzu)+(f1-f1_aver(t)).^2; 
    %���SNR�����õ�Ƶ�ʹ��Ƶľ������
    f2_mse(t)=var(f2_shuzu)+(f2-f2_aver(t)).^2;
    t=t+1;
end
figure(1)           %����ͼһΪf1,f2����ֵ����snr�ı仯���
snr=-10:0.1:30;
plot(snr,f1_aver,'--');
hold on
plot(snr,f2_aver);
%tit1e('����ֵ��SNR�ı任��ϵ');
xlabel('snr');
ylabel('Ƶ�ʹ���ֵ');
legend('����Ϊf1Ƶ�ʹ���ͼ��','ʵ��Ϊf2Ƶ�ʹ���ͼ��');
 
figure(2)       %����ͼ2Ϊf1,f2�ľ������mse����snr�ı仯���
plot(snr,f1_mse,'--');  
hold on
plot(snr,f2_mse);
%tit1e('����ֵ��MsE��SNR�ı任��ϵ');
xlabel('snr');
ylabel('mse');
legend('����Ϊf1��mse','ʵ��Ϊf2��mse');
