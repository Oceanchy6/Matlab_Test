close all; 
clear; 
clc;
%% 折线图 直接训练
% epoch=1:1:15;
% Swin_t=[63.5,65.4,65.1,65.9,66.5,67.3,66.9,67.2,68.2,68.8,70.1,70.8,71.5,71.3,71.6];
% plot(epoch,Swin_t,'s-g','MarkerSize',2,'MarkerFaceColor','g','MarkerEdgeColor','g','LineWidth',2);
% grid
% Swin_s=[63.9,65.9,66.7,66.1,67.9,67.8,68.2,68.4,68.9,69.8,71.5,73.8,74.9,75.3,75.4];
% hold on
% plot(epoch,Swin_s,'s--y','MarkerSize',2,'MarkerFaceColor','y','MarkerEdgeColor','y','LineWidth',2);
% Swin_B_224=[64.1,65.6,67.1,66.6,67.5,67.9,70.6,72.6,74.3,76.8,77.1,78.3,78.6,78.5,78.7];
% hold on
% plot(epoch,Swin_B_224,'+:b','MarkerSize',1.5,'MarkerFaceColor','b','MarkerEdgeColor','b','LineWidth',1.5);
% Swin_B_384 =[64.3,65.3,66.9,67.6,67.3,68.8,70.8,73.3,75.6,77.2,79.8,79.6,79.8,80.1,80.3];
% hold on
% plot(epoch,Swin_B_384,'s-.r','MarkerSize',2,'MarkerFaceColor','r','MarkerEdgeColor','r','LineWidth',2);
% % e=[0,0.10,0.20,0.30,0.40,0.50];
% % hold on
% % plot(x,e,'s-r','MarkerSize',2,'MarkerFaceColor','r','MarkerEdgeColor','r','LineWidth',2)
% xlabel('迭代次数（Epochs）')%,'fontsize',22,'FontWeight','bold','FontName','Times New Roman') 
% ylabel('分类准确率（ACC）/%')%,'fontsize',21,'FontWeight','bold','FontName','Times New Roman')
% h=legend('Swin_T','Swin_S','Swin_B_ 224','Swin_B_ 384');
% % set(h,'Fontsize',16,'FontWeight','bold','FontName','Times New Roman');
% % set(gca,'FontSize',20,'LineWid',2);%设置坐标轴字体打下以及网格粗细

%% 迁移学习训练 22k
% epoch=1:1:15;
% Swin_t=[74.3,74.6,75.1,74.5,75.5,76.3,76.9,77.3,77.9,78.8,79.2,79.8,82.1,81.9,82.2];
% plot(epoch,Swin_t,'s-g','MarkerSize',2,'MarkerFaceColor','g','MarkerEdgeColor','g','LineWidth',2);
% grid
% Swin_s=[75.9,77.4,78.4,78.9,78.2,79.4,79.8,81.4,80.9,81.5,82.4,83.3,84.2,84.4,84.4];
% hold on
% plot(epoch,Swin_s,'s--y','MarkerSize',2,'MarkerFaceColor','y','MarkerEdgeColor','y','LineWidth',2);
% Swin_B_224=[78.5,78.1,79.9,80.4,80.3,81.4,81.5,82.6,83.3,84.6,86.6,86.3,86.7,86.9,87.3];
% hold on
% plot(epoch,Swin_B_224,'+:b','MarkerSize',1.5,'MarkerFaceColor','b','MarkerEdgeColor','b','LineWidth',1.5);
% Swin_B_384 =[79.8,79.6,79.9,81.6,82.6,83.2,84.1,84.9,85.4,85.6,87.8,88.6,89.3,90.2,90.1];
% hold on
% plot(epoch,Swin_B_384,'s-.r','MarkerSize',2,'MarkerFaceColor','r','MarkerEdgeColor','r','LineWidth',2);
% % e=[0,0.10,0.20,0.30,0.40,0.50];
% % hold on
% % plot(x,e,'s-r','MarkerSize',2,'MarkerFaceColor','r','MarkerEdgeColor','r','LineWidth',2)
% xlabel('迭代次数（Epochs）')%,'fontsize',22,'FontWeight','bold','FontName','Times New Roman') 
% ylabel('分类准确率（ACC）/%')%,'fontsize',21,'FontWeight','bold','FontName','Times New Roman')
% h=legend('Swin_T','Swin_S','Swin_B_ 224','Swin_B_ 384');
% % set(h,'Fontsize',16,'FontWeight','bold','FontName','Times New Roman');
% % set(gca,'FontSize',20,'LineWid',2);%设置坐标轴字体打下以及网格粗细
%  
%% 迁移学习训练 1k
% epoch=1:1:15;
% Swin_t=[73.8,74.8,74.7,75.1,75.7,76.1,76.8,76.6,76.9,78.3,79.1,79.4,80.5,80.2,80.6];
% plot(epoch,Swin_t,'s-g','MarkerSize',2,'MarkerFaceColor','g','MarkerEdgeColor','g','LineWidth',2);
% grid
% Swin_s=[75.3,75.7,76.4,76.9,77.2,77.4,77.6,78.4,79.6,80.2,80.7,81.3,81.7,82.1,82.2];
% hold on
% plot(epoch,Swin_s,'s--y','MarkerSize',2,'MarkerFaceColor','y','MarkerEdgeColor','y','LineWidth',2);
% Swin_B_224=[76.9,76.7,77.8,78.6,80.2,81.4,80.1,81.3,82.6,82.9,84.2,84.6,84.9,84.7,85.1];
% hold on
% plot(epoch,Swin_B_224,'+:b','MarkerSize',1.5,'MarkerFaceColor','b','MarkerEdgeColor','b','LineWidth',1.5);
% Swin_B_384 =[77.6,79.1,79.3,81.4,82.6,82.2,84.1,84.3,85.4,86.6,87.4,87.6,88.2,88.0,88.2];
% hold on
% plot(epoch,Swin_B_384,'s-.r','MarkerSize',2,'MarkerFaceColor','r','MarkerEdgeColor','r','LineWidth',2);
% e=[0,0.10,0.20,0.30,0.40,0.50];
% hold on
% plot(x,e,'s-r','MarkerSize',2,'MarkerFaceColor','r','MarkerEdgeColor','r','LineWidth',2)
% xlabel('迭代次数（Epochs）')%,'fontsize',22,'FontWeight','bold','FontName','Times New Roman') 
% ylabel('分类准确率（ACC）/%')%,'fontsize',21,'FontWeight','bold','FontName','Times New Roman')
% h=legend('Swin_T','Swin_S','Swin_B_ 224','Swin_B_ 384');
% set(h,'Fontsize',16,'FontWeight','bold','FontName','Times New Roman');
% set(gca,'FontSize',20,'LineWid',2);%设置坐标轴字体打下以及网格粗细
%% CNN

epoch=1:1:15;
Swin_t=[63.5,65.4,65.1,65.9,66.5,67.3,66.9,67.2,68.2,68.8,70.1,70.8,71.5,71.3,71.6];
plot(epoch,Swin_t,'s-g','MarkerSize',2,'MarkerFaceColor','g','MarkerEdgeColor','g','LineWidth',2);
grid
Swin_s=[63.9,65.9,66.7,66.1,67.9,67.8,68.2,68.4,68.9,69.8,71.5,73.8,74.9,75.3,75.4];
hold on
plot(epoch,Swin_s,'s--y','MarkerSize',2,'MarkerFaceColor','y','MarkerEdgeColor','y','LineWidth',2);
Swin_B_224=[64.1,65.6,67.1,66.6,67.5,67.9,70.6,72.6,74.3,76.8,77.1,78.3,78.6,78.5,78.7];
hold on
plot(epoch,Swin_B_224,'+:b','MarkerSize',1.5,'MarkerFaceColor','b','MarkerEdgeColor','b','LineWidth',1.5);
Swin_B_384 =[64.3,65.3,66.9,67.6,67.3,68.8,70.8,73.3,75.6,77.2,79.8,79.6,79.8,80.1,80.3];
hold on
plot(epoch,Swin_B_384,'s-.r','MarkerSize',2,'MarkerFaceColor','r','MarkerEdgeColor','r','LineWidth',2);
% e=[0,0.10,0.20,0.30,0.40,0.50];
% hold on
% plot(x,e,'s-r','MarkerSize',2,'MarkerFaceColor','r','MarkerEdgeColor','r','LineWidth',2)
xlabel('迭代次数（Epochs）')%,'fontsize',22,'FontWeight','bold','FontName','Times New Roman') 
ylabel('分类准确率（ACC）/%')%,'fontsize',21,'FontWeight','bold','FontName','Times New Roman')
h=legend('Swin_T','Swin_S','Swin_B_ 224','Swin_B_ 384');
% set(h,'Fontsize',16,'FontWeight','bold','FontName','Times New Roman');
% set(gca,'FontSize',20,'LineWid',2);%设置坐标轴字体打下以及网格粗细



