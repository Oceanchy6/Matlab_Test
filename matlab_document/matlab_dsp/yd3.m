echo on
clear;
K=10;%���ŵ��� 10 
N=2*K;% �任����20
T=100;
a=rand(1,36);
a=sign(a-0.5);
b=reshape(a,9,4); %9������
% ���� 16QAM �ĸ�����Ԫ���е�����
XXX=2*b(:,1)+b(:,2)+j*(2*b(:,3)+b(:,4)); 
XX=XXX';
X=[0 XX 0 conj(XX(9:-1:1))]; 
xt=zeros(1,101);
%���ɳ�������s(k)��ʽ��13����
for t=0:100
for k=0:N-1
xt(1,t+1)=xt(1,t+1)+ X(k+1)*exp(1i*(2*pi/T)*(k)*(t))/sqrt(20);
echo off
end
end
echo on
xn=zeros(1,N);
%��Ԫ���е� IDFT
for n=0:N-1
 for k=0:N-1
                  xn(n+1)=xn(n+1)+ X(k+1)*exp(1i*(2*pi/K)*n*k)/sqrt(20);
                 echo off
 end
end
echo on
pause %����������� x(t) plot([0:100],abs(xt))
% ���� xn �� x(t)���������Ĳ��
for n=0:N-1
d(n+1)=xt(T/N*n+1)-xn(1+n); echo off
end
echo on
e=norm(d); Y=zeros(1,10); for k=1:9
for n=0:N-1
Y(1,k+1)=Y(1,k+1)+ xn(n+1)*exp(-j*(2*pi/K)*n*k)/sqrt(20);
echo off
end
end
echo on
dd=Y(1:10)-X(1:10);
ee=norm(dd);