xn=[1 2 3 4];
yn=[1 2 3 4 5];
M=length(xn);
N=length(yn);
L=M+N-1; 
for i=1:L
    R1(i)=0;
    for j=1:M
        k=N+j-i;  
        if(k>=1&k<=N)
            R1(i)=R1(i)+conj(xn(j))*yn(k); 
        end
    end
end

L1=1:L;
subplot(211);
stem(L1,R1,'.');
title('定义法');

R2=xcorr(xn,yn);
L2=1:length(R2);
subplot(212);
stem(L2,R2,'.');
title('函数法');