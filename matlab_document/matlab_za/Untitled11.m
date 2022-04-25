clc
clear
N=256;
p=80;
f1=0.1;
f2=0.3;
n=1:N;
wn=randn(1,N);
xn=10*sin(2*pi*f1*n+pi/3)+2*sin(2*pi*f2*n+pi/4)+wn;
ef=zeros(p+1,N);
eb=zeros(p+1,N);
k=zeros(1,p+1);       %反射系数集

ef(1,:)=xn;
eb(1,:)=xn;   %初始化零阶


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

R0=sum(conj(xn(1:N)).*xn(1:N))/N; 
a=zeros(p,p);  %系数矩阵
a(1,1)=k(2);
G2=zeros(1,p);
G2(1)=R0*(1-a(1,1)^2);  

for m=2:p
    a(m,m)=k(m+1);
    for i=1:m-1
        a(m,i)=a(m-1,i)+k(m+1)*a(m-1,m-i);
    end
    G2(m)=G2(m-1)*(1-a(m,m)^2);
end
A=zeros(1,p);
for i=1:p
    A(i)=a(p,i);
end

[H,w]=freqz(G2(p)^0.5,[1,A],N);
Hf=abs(H);
Sx=Hf.^2;
f=w/(2*pi);
plot(f,Sx);
title('功率谱密度');
xlabel('f');ylabel('Sx');

[pks,locs]=findpeaks(Sx,'SortStr','descend');
for i=1:2
    fprintf('预测频率f%d=%f\n',i,locs(i)/(2*N));
end
