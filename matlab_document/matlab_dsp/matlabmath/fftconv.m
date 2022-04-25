function yk=fftconv(x1,x2,N)
     Xk1=fft(x1,N);
     XK2=fft(x2,N);
     YK=Xk1.*XK2; 
     yk=ifft(YK,N);

%直接调用函数fftconv 即可返回其圆卷积
%例如： fftconv(x,h,N0)