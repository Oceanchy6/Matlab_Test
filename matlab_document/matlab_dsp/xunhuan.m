echo on
clear;
K=10;%���ŵ��� 10 
N=2*K;% �任����20
T=100;
a=rand(1,36);
a=sign(a-0.5);       %������Ԫ
b=reshape(a,9,4);    % a��4�����һ��Ϊһ����Ԫ
% ����16QAM �ĸ�����Ԫ���е�����
XXX=2*b(:,1)+b(:,2)+j*(2*b(:,3)+b(:,4));     %b����ÿһ������λ����Ӧ16QAM��һ������
XX=XXX';
X=[0 XX 0 conj(XX(9:-1:1))];               %Bn'    
xt=zeros(1,101);

%���ɳ������� ��ʽ��13����
for t=0:100
 for k=0:N-1 
    xt(1,t+1)=xt(1,t+1)+ X(k+1)*exp(j*(2*pi/T)*k*t)/sqrt(N); 
 echo off
 end
end
echo on     
xn=zeros(1,N);
%��Ԫ����Bn'�� IDFT
for n=0:N-1
 for k=0:N-1
    xn(n+1)=xn(n+1)+ X(k+1)*exp(j*(2*pi/N)*n*k)/sqrt(N);
    xn_shift=[xn(N-3:N),xn];
    xn_shift(1:4)=[];
    xn=xn_shift;
   echo off
 end
end    
%����x(t)��������x(k)
echo on
pause %����������� x(t)
figure(1)
plot([0:100],abs(xt))
title('OFDM�źŵĻָ��ź�')
figure(2)
stem([0:N-1],abs(xn),'.')
title('OFDM�źŵĲ����ź�')
% ���� xn �� x(t)���������Ĳ��
for n=0:N-1
 d(n+1)=xt(T/N*n+1)-xn(1+n);
 echo off
end
echo on
e=norm(d)      %����

%DFT
Y=zeros(1,10);
for k=1:9        %Y(1)=0����
 for n=0:N-1
    Y(1,k+1)=Y(1,k+1)+ xn(n+1)*exp(-j*(2*pi/N)*n*k)/sqrt(N);
 echo off
 end
end

echo on
dd=Y(1:10)-X(1:10);
ee=norm(dd)