clear;
clc;
%肺实质的图片
image_path = 'I:\肺结节\数据\result2\jpg2\';
%肺结节的位置信息和良恶性程度
xls_path = 'I:\肺结节\数据\result2\result22.xls';
[txt,xls_text] = xlsread(xls_path);
xls_num = size(xls_text);
xls_num(1);
for m = 1:xls_num(1)
     img_name = xls_text(m,1);
     str = img_name{1};
     img_name = [str,'.jpg'];
     jpg_child_path = [image_path,img_name]
      if exist(jpg_child_path,'file')
          col4x = txt(m,4) - txt(m,2);
          col4y = txt(m,5) - txt(m,3);
          dir = txt(m,6);
          times = txt(m,7);
          size_center = [ ];
          if col4x < 32 && col4y < 32
              ma = 0.5 * (32 - max(col4x,col4y));      
              col4xy = [txt(m,2)-ma,txt(m,3)-ma,32,32];  
              size_center =[ma,ma,max(col4x,col4y)];
              zl_jianqie(jpg_child_path,dir,times,size_center,col4xy);
              continue;
          end
          size_center =[0,0,max(col4x,col4y)];
          col4xy = [txt(m,2),txt(m,3),max(col4x,col4y),max(col4x,col4y)];
          zl_jianqie(jpg_child_path,dir,times,size_center,col4xy);
      end
    
%     break;
end
