clear
N=128;%信号样本数
n=1:N;
f1=0.1;f2=0.3;
xn=10*sin(2*pi*f1*n+pi/3)+2*sin(2*pi*f2*n+pi/4);
f1z=zeros(1,100);
f2z=zeros(1,100);
a1=zeros(1,100);
a2=zeros(1,100);
var1=zeros(1,100);
var2=zeros(1,100);
bia1=zeros(1,100);
bia2=zeros(1,100);
mse1=zeros(1,100);
mse2=zeros(1,100);

for snr=1:100
    sum1=0;sum2=0;    
 for cishu=1:100
    yn=awgn(xn,snr/10,'measured');
    Rn=xcorr(yn);
    Wn=abs(fft(Rn));
    f1gj=1;
    for i=1:50   
        if (Wn(i)>=Wn(f1gj))
            f1gj=i;
        end
    end
    f1z(cishu)=f1gj/256;
    sum1=sum1+f1z(cishu);
    avef1=sum1/100;
    
    f2gj=50;
    for i=50:100
        
        if (Wn(i)>=Wn(f2gj))
            f2gj=i;
        end
    end
    f2z(cishu)=f2gj/256;
    sum2=sum2+f2z(cishu);
    avef2=sum2/100;
      
end
    s1=0;s2=0;
    for i=1:100
        s1=(f1z(i)-avef1).^2+s1;
        s2=(f2z(i)-avef2).^2+s2;
    end
    var1(snr)=s1/100;
    var2(snr)=s2/100;
    bia1(snr)=f1-avef1;
    bia2(snr)=f2-avef2;
    a1(snr)=avef1;
    a2(snr)=avef2;
    d=mean(a1);
     e=mean(a2);
    mse1(snr)=var1(snr)+((bia1(snr)).^2);
    mse2(snr)=var2(snr)+((bia2(snr)).^2);
end
figure(1)
s=1:100;
plot(s/10,a1,'-b');
hold on
plot(s/10,a2,'-r');
%axis([0,snr,0,0.35]);
xlabel('SNR');
ylabel('guji');
legend('guji(f1)', 'guji(f2)');

figure(2)
s=1:100;
plot(s/10,mse1,'-b');
hold on
plot(s/10,mse2,'-r');
xlabel('SNR');
ylabel('MSE');
legend('mse(f1)', 'mse(f2)');