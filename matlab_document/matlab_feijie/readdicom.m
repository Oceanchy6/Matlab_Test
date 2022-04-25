clear;
clc;     
%% Each treatment 100 or 200       %处理数据导入到表格中
%LIDC_path   = 'E:\zhaolei\深度学习\肺结节\400-499\LIDC-IDRI\';    原路径
LIDC_path   = 'D:\MATLAB\tiqu\LIDC-IDRI';
%IDRI_path = 'H:\肺结节\数据\LIDC-IDRI\';     原路径
%XLS_path = 'H:\肺结节\数据\excel\excel_all';     原路径
IDRI_path = 'D:\MATLAB\tiqu\LIDC-IDRI';
XLS_path = 'D:\MATLAB\tiqu\xls';
IDRI_child_path = dir(IDRI_path);                               %打开文件目录并返回文件结构体*
num_IDRI_child = size(IDRI_child_path);                             %返回列和行数的数组*  
%for n = 8 :num_IDRI_child 原版            %为啥从8开始？？？
for n = 3 :num_IDRI_child    %非原版
   % child_idri_path = [IDRI_path,IDRI_child_path(n).name];原版（可能有错）
    child_idri_path = [IDRI_path,'\',IDRI_child_path(n).name];   %非原版
    child_idri_path_temp = dir(child_idri_path);                %打开文件*
    LIDC_path = [child_idri_path,'\',child_idri_path_temp(3).name];     %文件目录*
    LIDC_child_path = dir(LIDC_path);        %打开
    num_child = size(LIDC_child_path);      %返回文件的列和行数的数组*
    for i = 3 : num_child(1)       %从3开始（前两个是. ..） 
        %% find dicom file list
        child_path = [LIDC_path,'\',LIDC_child_path(i).name];        %一步步打开文件夹
        child_path_temp = dir(child_path);
        child_path1 = [child_path,'\',child_path_temp(3).name];
        child_path_temp = dir(child_path1);
        %xml_path = [child_path1,'\',child_path_temp(3).name];
        xml_path = [child_path,'\'];
        %获取单个文件夹中的dicom和xml文件
        dcm_files = find_files(xml_path, '.dcm');    % 获得文件列表    
        xml_files = find_files(xml_path, '.xml');
        xml_path = char(xml_files);      
        [num_mal,sop_text,max_min_xy]=zl_readxml(xml_path);  %函数调用
         
       %  num_mal = []; %每个结节的恶性度和属于该类别的图片的数量
       %  sop_text = { }; %每个图片的标号
       % max_min_xy = []; %每个图像中肺结节的x和y的最小值和最大值
        
        sop_num = size(sop_text);   %  获得行列数，行：？ 列：图片数*
        mal_num = size(num_mal);        %行： 图片数？*
        dcm_number = [ ];   %图片编号*    
        %??
        if sop_num(2)>mal_num(1)           %要根据他们两个的差值来决定补多少个0
            for m = 1 : sop_num(2)-mal_num(1)    
                num_mal = [num_mal();0,0];    %添加扩展维度*
            end
        end
        if sop_num(2)< mal_num(1)
            for m = 1 :  mal_num(1) - sop_num(2)     %  只有数据维度一样才能被写入到文件中！所以少的要补上四个0
                dcm_number= [dcm_number;0];            %添加扩展维度
                max_min_xy = [max_min_xy;0,0,0,0];       %添加扩展维度   
            end
        end
        %??
        %% Get the number and file name of the image In a single folder
        
         for md = 1 : sop_num(2)      %???            
            dcm_number= [dcm_number;0];    
        end
           for j = 1:numel(dcm_files)    %遍历文件
                    dicomInformation = dicominfo(dcm_files{j});          %存储图片信息
                    instance = dicomInformation.SOPInstanceUID;   
                    imagenum = dicomInformation.InstanceNumber; 
                    % Make sure that the StudyInstanceUID matches that found in
                    % the XML annotations
                    for s = 1 : sop_num(2)    %对比
                        if strcmpi(instance,sop_text(1,s))
                           dcm_number(s) = imagenum;     %编号？？?*
                        end
                    end
                    
           end
           
         
           total = [num_mal,dcm_number,max_min_xy];
           if isempty(total)
               continue;
           end
           child_path = [XLS_path,'\',LIDC_child_path(i).name]
           xlswrite(child_path,total);     %导入到表格中 2017/4/10
         

    end

end
