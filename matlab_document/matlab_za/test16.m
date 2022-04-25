%数字信号系统第一章课后习题第16题实验程序
A1=[1,-0.6,0.08];B1=1;   %第一问差分方程的系数向量
A2=[1,-0.7,0.1];B2=[2,0,-1];  %第二问差分方程的系数向量
%求单位脉冲响应和单位阶跃响应可以利用filter函数和impz函数,
%本题主要利用filter函数
%第一个系统
x1=[1,zeros(1,20)];      %单位脉冲序列 ,长度为21
n=0:20;
hn1=filter(B1,A1,x1);
subplot(2,2,1);stem(n,hn1,'filled');
title('系统一的系统脉冲响应');xlabel('n');ylabel('h(n)');
n=0:20;
x1=1.^n;                %单位阶跃序列 ,长度为21
sn1=filter(B1,A1,x1);
subplot(2,2,2);stem(n,sn1,'filled');
title('系统一的系统阶跃响应');xlabel('n');ylabel('s(n)');
%第二个系统
x2=[1,zeros(1,20)];      %单位脉冲序列 ,长度为21
n=0:20;
hn2=filter(B2,A2,x2);
subplot(2,2,3);stem(n,hn2,'filled');
title('系统二的系统脉冲响应');xlabel('n');ylabel('h(n)');
n=0:20;
x2=1.^n;                %单位阶跃序列 ,长度为21
sn2=filter(B2,A2,x2);
subplot(2,2,4);stem(n,sn2,'filled');
title('系统二的系统阶跃响应');xlabel('n');ylabel('s(n)');