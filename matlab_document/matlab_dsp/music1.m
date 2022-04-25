clear all;
N=128;
M=2;
f1=0.1;
f2=0.3;
n=0:N-1;

R=zeros(N,N);%����ؾ���
xn=exp(-j*(2*pi*f1*n+pi/4))+exp(-j*(2*pi*f2*n+pi/3));%ָ����������sin��x�����Һ���
snr=10;                 %snrΪ�����
yn=awgn(xn,snr);
Xk=xcorr(yn);%��yn��ȡ�����
%������ؾ���
for i=1:N
    for z=1:N
        if(i>=z) 
            R(i,z)=Xk(i-z+N);
        else
            R(i,z)=conj(Xk(z-i+N));
        end    
    end
end
[EV,D]=eig(R);%����ֵ�ֽ� ��DΪ����ֵ����Խ����ϵ�ֵ��Ϊ����ֵ��matlab���Զ���˳���ŷ�
En=EV(:,1:N-2);  %�����ӿռ�
C=1001;%cΪw��ȡֵ����
w=linspace(0,1,C);%wΪ[0,1]ȡ1001��ֵ
P=zeros(1,C);
for i=1:C
    a=exp(-j*w(i)*2*pi*(0:N-1)');%aΪNά������e��w��
    b=a';%��a����ת��
    P(i)=1/sum(  abs((b*En)).^2  );%�������ƹ����׵ĺ���P��i��
end
plot(w,P);
xlabel('w/2/pi')%x��
ylabel('��һ�������� (dB)')%y��
title('music����');