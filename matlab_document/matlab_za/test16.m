%�����ź�ϵͳ��һ�¿κ�ϰ���16��ʵ�����
A1=[1,-0.6,0.08];B1=1;   %��һ�ʲ�ַ��̵�ϵ������
A2=[1,-0.7,0.1];B2=[2,0,-1];  %�ڶ��ʲ�ַ��̵�ϵ������
%��λ������Ӧ�͵�λ��Ծ��Ӧ��������filter������impz����,
%������Ҫ����filter����
%��һ��ϵͳ
x1=[1,zeros(1,20)];      %��λ�������� ,����Ϊ21
n=0:20;
hn1=filter(B1,A1,x1);
subplot(2,2,1);stem(n,hn1,'filled');
title('ϵͳһ��ϵͳ������Ӧ');xlabel('n');ylabel('h(n)');
n=0:20;
x1=1.^n;                %��λ��Ծ���� ,����Ϊ21
sn1=filter(B1,A1,x1);
subplot(2,2,2);stem(n,sn1,'filled');
title('ϵͳһ��ϵͳ��Ծ��Ӧ');xlabel('n');ylabel('s(n)');
%�ڶ���ϵͳ
x2=[1,zeros(1,20)];      %��λ�������� ,����Ϊ21
n=0:20;
hn2=filter(B2,A2,x2);
subplot(2,2,3);stem(n,hn2,'filled');
title('ϵͳ����ϵͳ������Ӧ');xlabel('n');ylabel('h(n)');
n=0:20;
x2=1.^n;                %��λ��Ծ���� ,����Ϊ21
sn2=filter(B2,A2,x2);
subplot(2,2,4);stem(n,sn2,'filled');
title('ϵͳ����ϵͳ��Ծ��Ӧ');xlabel('n');ylabel('s(n)');