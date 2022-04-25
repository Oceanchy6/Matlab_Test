%数字信号系统第一章课后习题第17题实验程序
A=[1,-0.8,0.64];B=0.866;   %该题差分方程的系数向量
%求单位脉冲响应和单位阶跃响应可以利用filter函数和impz函数,
%本题主要利用filter函数
x1=[1,zeros(1,48)];      %单位脉冲序列 ,长度为49
n1=0:48;
hn=filter(B,A,x1);
subplot(2,1,1);stem(n1,hn,'filled');
title('系统单位脉冲响应');xlabel('n');ylabel('h(n)');
n2=0:100;
x2=1.^n2;                %单位阶跃序列 ,长度为100
sn=filter(B,A,x2);
subplot(2,1,2);stem(n2,sn,'filled');
title('系统单位阶跃响应');xlabel('n');ylabel('s(n)');