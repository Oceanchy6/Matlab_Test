clear;
clc;     
%% Each treatment 100 or 200       %�������ݵ��뵽�����
%LIDC_path   = 'E:\zhaolei\���ѧϰ\�ν��\400-499\LIDC-IDRI\';    ԭ·��
LIDC_path   = 'D:\MATLAB\tiqu\LIDC-IDRI';
%IDRI_path = 'H:\�ν��\����\LIDC-IDRI\';     ԭ·��
%XLS_path = 'H:\�ν��\����\excel\excel_all';     ԭ·��
IDRI_path = 'D:\MATLAB\tiqu\LIDC-IDRI';
XLS_path = 'D:\MATLAB\tiqu\xls';
IDRI_child_path = dir(IDRI_path);                               %���ļ�Ŀ¼�������ļ��ṹ��*
num_IDRI_child = size(IDRI_child_path);                             %�����к�����������*  
%for n = 8 :num_IDRI_child ԭ��            %Ϊɶ��8��ʼ������
for n = 3 :num_IDRI_child    %��ԭ��
   % child_idri_path = [IDRI_path,IDRI_child_path(n).name];ԭ�棨�����д�
    child_idri_path = [IDRI_path,'\',IDRI_child_path(n).name];   %��ԭ��
    child_idri_path_temp = dir(child_idri_path);                %���ļ�*
    LIDC_path = [child_idri_path,'\',child_idri_path_temp(3).name];     %�ļ�Ŀ¼*
    LIDC_child_path = dir(LIDC_path);        %��
    num_child = size(LIDC_child_path);      %�����ļ����к�����������*
    for i = 3 : num_child(1)       %��3��ʼ��ǰ������. ..�� 
        %% find dicom file list
        child_path = [LIDC_path,'\',LIDC_child_path(i).name];        %һ�������ļ���
        child_path_temp = dir(child_path);
        child_path1 = [child_path,'\',child_path_temp(3).name];
        child_path_temp = dir(child_path1);
        %xml_path = [child_path1,'\',child_path_temp(3).name];
        xml_path = [child_path,'\'];
        %��ȡ�����ļ����е�dicom��xml�ļ�
        dcm_files = find_files(xml_path, '.dcm');    % ����ļ��б�    
        xml_files = find_files(xml_path, '.xml');
        xml_path = char(xml_files);      
        [num_mal,sop_text,max_min_xy]=zl_readxml(xml_path);  %��������
         
       %  num_mal = []; %ÿ����ڵĶ��ԶȺ����ڸ�����ͼƬ������
       %  sop_text = { }; %ÿ��ͼƬ�ı��
       % max_min_xy = []; %ÿ��ͼ���зν�ڵ�x��y����Сֵ�����ֵ
        
        sop_num = size(sop_text);   %  ������������У��� �У�ͼƬ��*
        mal_num = size(num_mal);        %�У� ͼƬ����*
        dcm_number = [ ];   %ͼƬ���*    
        %??
        if sop_num(2)>mal_num(1)           %Ҫ�������������Ĳ�ֵ�����������ٸ�0
            for m = 1 : sop_num(2)-mal_num(1)    
                num_mal = [num_mal();0,0];    %�����չά��*
            end
        end
        if sop_num(2)< mal_num(1)
            for m = 1 :  mal_num(1) - sop_num(2)     %  ֻ������ά��һ�����ܱ�д�뵽�ļ��У������ٵ�Ҫ�����ĸ�0
                dcm_number= [dcm_number;0];            %�����չά��
                max_min_xy = [max_min_xy;0,0,0,0];       %�����չά��   
            end
        end
        %??
        %% Get the number and file name of the image In a single folder
        
         for md = 1 : sop_num(2)      %???            
            dcm_number= [dcm_number;0];    
        end
           for j = 1:numel(dcm_files)    %�����ļ�
                    dicomInformation = dicominfo(dcm_files{j});          %�洢ͼƬ��Ϣ
                    instance = dicomInformation.SOPInstanceUID;   
                    imagenum = dicomInformation.InstanceNumber; 
                    % Make sure that the StudyInstanceUID matches that found in
                    % the XML annotations
                    for s = 1 : sop_num(2)    %�Ա�
                        if strcmpi(instance,sop_text(1,s))
                           dcm_number(s) = imagenum;     %��ţ���?*
                        end
                    end
                    
           end
           
         
           total = [num_mal,dcm_number,max_min_xy];
           if isempty(total)
               continue;
           end
           child_path = [XLS_path,'\',LIDC_child_path(i).name]
           xlswrite(child_path,total);     %���뵽����� 2017/4/10
         

    end

end
