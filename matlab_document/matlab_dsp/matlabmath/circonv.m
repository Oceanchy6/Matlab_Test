function yc=circonv(x1,x2,N)
%y:output sequences
%x1,x2:input sequences
%N:circulation length
 
if length(x1)>N
error( 'N must not be less than length of x1 ');
end
if length(x2)>N
error( 'N must not be less than length of x2 ');
end
%以上语句判断两个序列的长度是否小于 N
x1=[x1,zeros(1,N-length(x1))];  
%填充序列x1(n)使其长度为N1+N2-1(序列%h(n)的长度为 N1，序列 x(n)的长度为 N2)
x2=[x2,zeros(1,N-length(x2))];  
%填充序列 x2(n)使其长度为 N1+N2-1
n=[0:1:N-1];
x2=x2(mod(-n,N)+1);  %取模 生成序列x2((-n))N
H=zeros(N,N);
for n=1:1:N
    H(n,:)=cirshiftd(x2,n-1,N);  %该矩阵的k行 为x2((k-1-n))N
end
yc=x1*H'; %矩阵的方法计算循环卷积




function y=cirshiftd(x,m,N)  
%直接实现序列x的循环移位
%y=cirshiftd(x,m,N);
%x:长度小于N的输入序列
%m:转移多少
%N:圆形长度
%y:输出移位序列
if length(x)>N
error('length of x must be less than N');
end
x=[x,zeros(1,N-length(x))];
n=[0:1:N-1];
y=x(mod(n-m,N)+1);




%线性卷积程序
function y=myconv(x1,x2)
N1=length(x1);
M=length(x2);
L=N1+M-1;
for(n=1:L)
   y(n)=0;
   for(m=1:M)
      k=n-m+1;
      if(k>=1&k<=N1)
            y(n)=y(n)+x2(m)*x1(k);
      end
   end
end
