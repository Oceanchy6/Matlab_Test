function [num_mal,sop_text,max_min_xy]=zl_readxml(xml_path)
% % function [sop_text,max_min_xy]=zl_readxml(xml_path)


% clear all
% clc
% xml_path ='I:\LIDC\LIDC-IDRI-0001\1.3.6.1.4.1.14519.5.2.1.6279.6001.298806137288633453246975630178\1.3.6.1.4.1.14519.5.2.1.6279.6001.179049373636438705059720603192\69.xml';
% xml_path = 'H:\�ν��\����\LIDC-IDRI\900-300\LIDC-IDRI\LIDC-IDRI-0060\1.3.6.1.4.1.14519.5.2.1.6279.6001.203745372924354240670222118382\1.3.6.1.4.1.14519.5.2.1.6279.6001.463214953282361219537913355115\191.xml';
%% ��ת���ڲ��ǩunblindedReadNodule
docNode = xmlread(xml_path);     %��ȡXML�ļ�����һ���ļ�ģ�ͽڵ�*  
document = docNode.getDocumentElement();
readingSession = document.getElementsByTagName('readingSession');  %�����������Ԫ�������ӽڵ��Nodelist����*
%% ��󷵻ص�����ֵ
%% ��󷵻ص�����ֵ
num_mal = []; %ÿ����ڵĶ��ԶȺ����ڸ�����ͼƬ������
sop_text = { }; %ÿ��ͼƬ�ı��
max_min_xy = []; %ÿ��ͼ���зν�ڵ�x��y����Сֵ�����ֵ
sop_num = 0;         %�ܽ�ڸ�����*
%%
for r = 0:readingSession.getLength()-1
        unblinded_nodule = readingSession.item(r).getElementsByTagName('unblindedReadNodule');     %unblindedReadNoduleһ���ڵ��ǣ�<unblindedReadNodule>�ڵ����ݰ�����</unblindedReadNodule>*
        
        for u = 0 : unblinded_nodule.getLength()-1

            roi = unblinded_nodule.item(u).getElementsByTagName('roi');   %item() �����ɷ��ؽڵ��б��д���ָ�������ŵĽڵ㡣*<roi>�������</roi>*
            mal = unblinded_nodule.item(u).getElementsByTagName('malignancy');    %<malignancy>��ڶ��Զ�</malignancy>*
            %���xml�ļ���û��malignancy����roi��ǩֱ������
            if isempty(roi.item(0))       
                continue;
            end
            if isempty(mal.item(0))       
                continue;
            end

            Num_roi = roi.getLength();   %������ͼƬ������
            mal_int = str2num(char(mal.item(0).getTextContent()));
            num_mal = [num_mal();mal_int,Num_roi];

            for i = 0 : Num_roi-1  %����*
                sop_id = roi.item(i).getElementsByTagName('imageSOP_UID');    %ͼƬ���*  
                sop_text{sop_num + i + 1} = char(sop_id.item(0).getTextContent());   %����*
                edgeMap = roi.item(i).getElementsByTagName('edgeMap');   %�߽�* 
                 xy = [];
                for j = 0 :edgeMap.getLength()-1            %�������*
                    xCoord = edgeMap.item(j).getElementsByTagName('xCoord');
                    xCoord_int = str2num(char(xCoord.item(0).getTextContent()));

                    yCoord = edgeMap.item(j).getElementsByTagName('yCoord');
                    yCoord_int = str2num(char(yCoord.item(0).getTextContent()));
                    xy=[xy();xCoord_int,yCoord_int];
                end
                %�ҵ��������*
                if edgeMap.getLength()==1
                   max_min_xy = [max_min_xy();xy,xy];
                   continue;
                end
                [maxr,max_index] = max(xy);
                [minr,min_index] = min(xy);
                max_min_xy = [max_min_xy();minr,maxr];


            end

            sop_num = sop_num + Num_roi;   %�ܸ���

        end
        if isempty(num_mal)                      
                continue;
        end
         num_mal = [num_mal();0,0];    %��չά��*
end
end                                                   
