clear;
T = 1;
Fs = 200;
t = 0 : 1/(Fs*T) : T-1/(Fs*T);
K = 32;
k = 1 : K-1;
rlz = 20; % 仿真次数
PAR = zeros(1,rlz);
D=zeros(1,rlz);
for j = 1 : rlz
 theta = pi*floor(rand(1,length(k))/0.25)/2;
 x = zeros(1,Fs);
 echo off;
 for i = 1 : Fs
 for l = 1 : K-1
 x(i) = x(i) + cos(2*pi*l*t(i)/T+theta(l));
 end
 end
 echo on;
 % 计算PAPR
 P_av =sum(x.*x)/200;
 P_peak =max(x.*x);
 PAR(j) = P_peak/P_av;
 while PAR(j)>10.^0.3
   xl=sqrt(P_av*(10.^(0.25)));
 for i=1:200
     if(abs(x(i))>xl)
         if(x(i)>0)  x(i)=xl;
         else  x(i)=-xl;
     end
     end
 end
 P_av=sum(x.*x)/200;
 P_peak=max(x.*x);
 PAR(j) = P_peak/P_av;
 end
 for i=1:200
     if(x(i)>0)
        D(j)=D(j)+((x(i)-xl).^2)/200;
     else  D(j)=D(j)+((x(i)+xl).^2)/200;
     end
 end
end
figure(1)
stem(PAR)
axis([1 20 min(PAR) max(PAR)])
xlabel('仿真次数')
ylabel('PAR')
figure(2)
stem(D)
axis([1 20 min(D) max(D)])
xlabel('仿真次数')
ylabel('D')