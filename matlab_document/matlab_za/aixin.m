
clc;clear;close all
% %% 立体红心
% [x,y,z]=meshgrid(linspace(-2,2));
% val=(x.^2+(9/4)*y.^2+z.^2-1).^3-x.^2.*z.^3-(9/80).*y.^2.*z.^3;
% isosurface(x,y,z,val,0)
% p = patch(isosurface(x,y,z,val,0));
% set(p,'facecolor','red','edgecolor','none');
% view(3);
% axis equal;
% title('\fontsize{14}\fontname{songti}你爱我','color','r')
% set(gcf,'unit','centimeters','position',[18 5 13.53 9.03],'color','white');
% grid on

%% 五彩斑斓的心
figure
f=@(x,y,z)(x.^2+(9/4)*y.^2+z.^2-1).^3-x.^2.*z.^3-(9/80)*y.^2.*z.^3;
[x,y,z]=meshgrid(linspace(-3,3));
val=f(x,y,z);
[p,v]=isosurface(x,y,z,val,0);
patch('faces',p,'vertices',v,'facevertexcdata',jet(size(v,1)),'facecolor','w','edgecolor','flat');
view(3);
axis equal;
title('\fontsize{14}\fontname{songti}我爱你','color','r')
set(gcf,'unit','centimeters','position',[18 5 13.53 9.03],'color','white');
grid on
