%% Step1 ����ԭʼָ�����ݾ���X
X=xlsread('');
%% Step2 ���ݾ�����������λ��
[m,n]=size(X);  %�������Ĵ�С,rowsΪ����������colsΪ����ָ�����
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
%% Step3 ��Ȩ���������ָ��Ȩ�� RΪ������� ����Ȩ������weights �����Ȩ��׼�����߾���
k=1/log(m);         %��k
p=zeros(m,n);       %��ʼ��pij
sumBycols=sum(R,1); %��������ÿһ��֮��(���Ϊһ��1*cols��������)
%����pij
for i=1:m
    for j=1:n
        p(i,j)=R(i,j)./sumBycols(1,j);
    end
end
 
lnpij=zeros(m,n);  % ��ʼ��lnpij
% ����lnpij
for i=1:m
    for j=1:n
        if p(i,j)==0
            lnpij(i,j)=0;
        else
            lnpij(i,j)=log(p(i,j));
        end
    end
end
%������ֵHj
Hj=-k*(sum(p.*lnpij,1)); 
%����Ȩ������weights
weights=(1-Hj)/sum(1-Hj);
%weights=(1-Hj)/(m-sum(Hj));
%���Ȩ����
w=weights;
%Z=X*diag(diag(repmat(w',1,3))); %����ԽǾ��� ���
Z=w.*R; %��� ���Ȩ����
%% Step4 ȷ�����뷽���͸����뷽��
%����1��2��3Ϊ�ɱ���ָ�꣬����ֵԽСԽ�ã�����4��5��6ΪЧ����ָ�꣬����ֵԽ��Խ��
z_positive=min(Z); %��������� 
z_positive([4,5,6])=max(Z(:,[4,5,6]));
z1=z_positive;
z_negative=max(Z); %�������
z_negative([4,5,6])=min(Z(:,[4,5,6]));
z0=z_negative;
%% Step5 ��������������뷽���͸����뷽���������
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
%% Step6 ����
[SortValue1,sortIndex1]= sort(C,'descend'); %��C���н�������
disp(sortIndex1);
[ModeValue,F]=mode(C); %�ҳ�C������������Ƶ��
index1=find(C(1,:)==ModeValue); %�ҳ�����ֵ����

for i=1:F  %��S1����������λ�ô���ֵ���򲢴洢
    V(i)=S1(index1(i));
    [SortValue2,sortIndex2]= sort(V,'ascend');
end

for i=1:F   %�ҳ���Щ����ֵ�������Ͻ�����
    index2(i)=index1(sortIndex2(i));
end

for i=1:F
    index3(i)=find(sortIndex1(1,:)==index1(i));%�ҵ�Ŀ���������ڵ�λ��
end
for i=1:length(sortIndex1)
    for j=1:F
        sortIndex1(index3(j))=index2(j); %��ֵ
    end
end
fprintf('����ָ��ֵ��\n');disp(SortValue1);
fprintf('������Ϊ��\n');disp(sortIndex1);
%% Step7 ����
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