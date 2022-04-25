%ʵ�������� exp6.m 
% DTMF˫Ƶ�����źŵ����ɺͼ�����
%clear all;clc; 
tm=[1,2,3,65;4,5,6,66;7,8,9,67;42,0,35,68]; % DTMF�źŴ���� 16 ����
N=205;K=[18, 20, 22, 24, 31, 34, 38, 42]; 
f1=[697,770,852,941]; % ��Ƶ������
f2=[1209,1336,1477,1633]; % ��Ƶ������
TN=input(' ���� 6 λ�绰���� = '); % ���� 6 λ����
TNr=0; % ���ն˵绰�����ֵΪ��
for l=1:6; 
d=fix(TN/10^(6-l)); 
TN=TN-d*10^(6-l); 
for p=1:4; 
for q=1:4; 
if tm(p,q)==abs(d); break,end 
% �����������к� q 
end 
if tm(p,q)==abs(d); break,end 
% �����������к� p 
end 
n=0:1023; % Ϊ�˷��� , �ӳ�����
x = sin(2*pi*n*f1(p)/8000) + sin(2*pi*n*f2(q)/8000); 
% ����˫Ƶ�ź�
sound(x,8000); % ��������
pause(0.1) 
% ���ռ��˵ĳ���
X=goertzel(x(1:205),K+1); 
% �� Goertzel �㷨����˵� DFT����
val = abs(X); % �г��˵� DFT ����
subplot(3,2,l); 
stem(K,val,'.');grid;xlabel('k'); 
ylabel('|X(k)|') % ���� DFT(k)����
axis([10 50 0 120]) 
limit = 80; 
for s=5:8; 
if val(s) > limit, break, end % �����к�
end 
for r=1:4; 
if val(r) > limit, break, end % �����к�
end 
TNr=TNr+tm(r,s-4)*10^(6-l); 
end 
disp('���ն˼�⵽�ĺ���Ϊ :') 
% ��ʾ���յ����ַ�
disp(TNr)