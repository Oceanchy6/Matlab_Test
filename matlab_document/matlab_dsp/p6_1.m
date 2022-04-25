clc;
clear;
tm=[1,2,3,65;4,5,6,66;7,8,9,67;42,0,35,68];     %DTMF信号代表的16个数
N=205;K=[18,20,22,24,31,34,38,42];  %8个基频对应的8个k值
f1=[697,770,852,941];           %行频率向量
f2=[1209,1336,1477,1633];       %列频率向量
TN=input('键入6位电话号码=');    %输入6位数字
TNr=0;          %接收端电话号码初值为零

for m=1:6      %分别对每位号码数字处理：产生信号，发声，检测
	d=fix(TN/10^(6-m));         %计算出第m位号码数字
	TN=TN-d*10^(6-m);
    
	for p=1:4
		for q=1:4
			if tm(p,q)==abs(d);break,end       %检测与第m位号码相符的列号q
        end
            if tm(p,q)==abs(d);break,end       %检测与第m位号码相符的行号p
    end
    n=0:1023;           %为了发声，加长序列
    x=sin(2*pi*n*f1(p)/8000)+sin(2*pi*n*f2(q)/8000);    %构成双频信号
    sound(x,8000);      %发出声音
    pause(0.1)          %相邻号码响声之间加0.1秒停顿
    %接收检测端的程序
    X=goertzel(x(1:N),K+1);     %用Goertzel算法计算八点DFT样本
    val=abs(X);                 %列出八点DFT的模
    subplot(3,2,m);stem(K,val,'.');grid;xlabel('k');ylabel('|X(k)|')
                                    %画出8点DFT的幅度
    axis([10 50 0 120])
    limit=80;                       %基频检测门限为80
    for s=5:8
        if val(s)>limit,break,end   %查找列号
    end
    for r=1:4
        if val(r)>limit,break,end   %查找行号
    end
    TNr=TNr+tm(r,s-4)*10^(6-m);     %将6位电话号码表示成一个6位数，以便显示
end
disp('接收端检测到的号码为：')
disp(TNr)                           %显示接收到的6位电话号码