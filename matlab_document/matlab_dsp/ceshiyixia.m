clear
N=128;%�ź�������
n=1:N;
f1=0.1;f2=0.3;
xn=10*sin(2*pi*f1*n+pi/3)+2*sin(2*pi*f2*n+pi/4);
f1gj=zeros(1,100);           %����100�ι�����ÿ�εĹ���ֵ
f2gj=zeros(1,100);
a1=zeros(1,100);             %����ÿһ��SNR����Ӧ��Ƶ�ʹ���ֵ
a2=zeros(1,100);
var1=zeros(1,100);           %����ÿһ��SNR����Ӧ��Ƶ�ʹ��Ƶķ���
var2=zeros(1,100);
bia1=zeros(1,100);           %����ÿһ��SNR����Ӧ��Ƶ�ʹ��Ƶ�ƫ��
bia2=zeros(1,100);
mse1=zeros(1,100);           %����ÿһ��SNR����Ӧ��Ƶ�ʹ��Ƶľ������
mse2=zeros(1,100);
half_Wn=zeros(1,N);
%��������ع����źŵ�Ƶ��
for snr=1:400
    sum1=0;sum2=0;    
    for cishu=1:100
    yn=awgn(xn,(snr/10)-30);        %SNR�ı仯��Χ��-30~10
    Rn=xcorr(yn);
    Wn=abs(fft(Rn));
    for i=1:N
    half_Wn(i)=Wn(i);               %ȡ������ǰN����
    end
    [a,b] = findpeaks(half_Wn,'SortStr','descend');%����Ѱ�庯�����������ҳ����Ƶ�Ƶ�ʣ���������b�ĵ�һ��͵ڶ�����ǵõ�����ֵ
    f1gj(cishu)=b(1)/(2*N);         %�����Ƶ�Ƶ��������ֵת��Ϊ��ʵֵ
    sum1=sum1+f1gj(cishu);          %��100�ι���ֵ���
    f2gj(cishu)=b(2)/(2*N);
    sum2=sum2+f2gj(cishu);
    end
    avef1=sum1/100;                 %���100�ι���ֵ��ƽ��ֵ�����ڸ�SNR�����õ�Ƶ�ʹ���
    avef2=sum2/100;
    s1=0;s2=0;
    for i=1:100
        s1=(f1gj(i)-avef1).^2+s1;   %����s1���Ϊ������󷽲���׼��
        s2=(f2gj(i)-avef2).^2+s2;
    end
    var1(snr)=s1/100;               %���SNR�����õ�Ƶ�ʹ��Ʒ���
    var2(snr)=s2/100;
    bia1(snr)=f1-avef1;             %���SNR�����õ�Ƶ�ʹ���ƫ��
    bia2(snr)=f2-avef2;
    a1(snr)=avef1;                  %�����SNR�����õ�Ƶ�ʹ���ֵ
    a2(snr)=avef2;
    mse1(snr)=var1(snr)+((bia1(snr)).^2);   %���SNR�����õ�Ƶ�ʹ��Ƶľ������
    mse2(snr)=var2(snr)+((bia2(snr)).^2);
end
figure(1)                           %��ͼ��ʵ�ߴ���f1�Ĺ���ֵ��SNR�ı仯��ϵ��
                                    %���ߴ���f2�Ĺ���ֵ��SNR�ı仯��ϵ��
s=1:400;
plot(s/10-30,a1,'-b');
hold on
plot(s/10-30,a2,'-r');
%axis([0,snr,0,0.35]);
title('����ֵ��SNR�ı任��ϵ');
xlabel('SNR');
ylabel('����ֵ');
legend('guji(f1)', 'guji(f2)');
%����fft�����źŵ�Ƶ��

figure(2)                           %��ͼ��ʵ�ߴ���f1��mse��SNR�ı仯��ϵ��
s=1:400;                            %���ߴ���f2��mse��SNR�ı仯��ϵ��
plot(s/10-30,mse1,'-b');
hold on
plot(s/10-30,mse2,'-r');
title('����ֵ��MSE��SNR�ı任��ϵ');
xlabel('SNR');
ylabel('MSE');
legend('mse(f1)', 'mse(f2)');