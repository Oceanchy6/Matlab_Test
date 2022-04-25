%% Step1 构造原始指标数据矩阵X
X=xlsread('');
%% Step2 数据矩阵列向量单位化
[m,n]=size(X);  %输入矩阵的大小,rows为方案个数，cols为属性指标个数
a=0;
for j=1:n
    for i=1:m
        a=a+X(i,j)^2;
    end
    A(1,j)=sqrt(a);
    a=0;
end
A=repmat(A,m,1);
R=X./A;
%% Step3 熵权法求各属性指标权重 R为输入矩阵 返回权重向量weights 构造加权标准化决策矩阵
k=1/log(m);         %求k
p=zeros(m,n);       %初始化pij
sumBycols=sum(R,1); %输入矩阵的每一列之和(结果为一个1*cols的行向量)
%计算pij
for i=1:m
    for j=1:n
        p(i,j)=R(i,j)./sumBycols(1,j);
    end
end
 
lnpij=zeros(m,n);  % 初始化lnpij
% 计算lnpij
for i=1:m
    for j=1:n
        if p(i,j)==0
            lnpij(i,j)=0;
        else
            lnpij(i,j)=log(p(i,j));
        end
    end
end
%计算熵值Hj
Hj=-k*(sum(p.*lnpij,1)); 
%返回权重向量weights
weights=(1-Hj)/sum(1-Hj);
%weights=(1-Hj)/(m-sum(Hj));
%求加权矩阵
w=weights;
%Z=X*diag(diag(repmat(w',1,3))); %构造对角矩阵 叉乘
Z=w.*R; %点乘 求加权矩阵
%% Step4 确定理想方案和负理想方案
%属性1、2、3为成本型指标，属性值越小越好；属性4、5、6为效益型指标，属性值越大越好
z_positive=min(Z); %求正理想解 
z_positive([4,5,6])=max(Z(:,[4,5,6]));
z1=z_positive;
z_negative=max(Z); %求负理想解
z_negative([4,5,6])=min(Z(:,[4,5,6]));
z0=z_negative;
%% Step5 计算各方案与理想方案和负理想方案的相对熵
S1=[];S0=[];
for i=1:m
    s1=z1.*log10((z1./Z(i,:)))+(1-z1).*log10(((1-z1)./(1-Z(i,:))));
    s0=z0.*log10((z0./Z(i,:)))+(1-z0).*log10(((1-z0)./(1-Z(i,:))));
    s1=sum(s1);
    s0=sum(s0);
    S1=[S1,s1];
    S0=[S0,s0];
end
C=S0./(S0+S1);
%% Step6 排序
[SortValue1,sortIndex1]= sort(C,'descend'); %对C进行降序排序
disp(sortIndex1);
[ModeValue,F]=mode(C); %找出C的众数及出现频次
index1=find(C(1,:)==ModeValue); %找出众数值索引

for i=1:F  %对S1中众数索引位置处的值排序并存储
    V(i)=S1(index1(i));
    [SortValue2,sortIndex2]= sort(V,'ascend');
end

for i=1:F   %找出那些众数值，并按上节排序
    index2(i)=index1(sortIndex2(i));
end

for i=1:F
    index3(i)=find(sortIndex1(1,:)==index1(i));%找到目标索引所在的位置
end
for i=1:length(sortIndex1)
    for j=1:F
        sortIndex1(index3(j))=index2(j); %赋值
    end
end
fprintf('排序指标值：\n');disp(SortValue1);
fprintf('排序结果为：\n');disp(sortIndex1);
%% Step7 绘制
figure;
plot(z1,'rp');hold on;
plot(z0,'ro');hold on;
plot(Z(1,:),'y*');hold on;
plot(Z(2,:),'g*');hold on;
plot(Z(3,:),'b*');hold on;
plot(Z(4,:),'m*');hold on;
plot(Z(5,:),'k*');hold on;
plot(Z(6,:),'c*');hold off;
axis tight;