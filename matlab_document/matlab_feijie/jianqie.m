function zl_jianqie(img_path,dir,times,size_center,col4xy)
   %dir Ϊ�������̶ܳȣ�col4xyΪ��������
    train_path = 'I:\�ν��\����\result2\train23jpg\';
    result_name = [img_path(24:37),'_',char(num2str(dir)),'_',char(num2str(times)),img_path(38:46)];
    train_path = [train_path,char(num2str(dir)),'\',result_name];  %����·��*
    img=imread(img_path);  %��ȡͼƬ�ļ�*
    img1=imcrop(img,col4xy);   %����ͼ���һ���ü�����*  I2=imcrop(I,[a b c d]);%���òü������ü�ͼ�����У�
    %��a,b����ʾ�ü������Ͻ�������ԭͼ���е�λ�ã�c��ʾ�ü���ͼ��Ŀ�d��ʾ�ü���ͼ��ĸ�
 %% �ָ�ν��ʵ��
    img1_size = size(img1);
    min(min(img1));    %   �ҵ���Сֵ�����ֵ
    max(max(img1));
    t=graythresh(img1);    %ʹ�������䷽��ҵ�ͼƬ��һ�����ʵ���ֵthreshold
    C=im2bw(img1,t);   %ת��Ϊ��ֵͼ��*
    D=imfill(C,4,'holes');%�Զ�ֵ�����ͼ������ʵ��
    if dir >=4    %�����Ϊ�ΰ�*
        FMask=bwareaopen(D,10);  % ����ֵͼ�������С��10�Ķ���  
        D = FMask;
    end
    total = 0;  
    for i = 1:img1_size(1)   %����    
        for j = 1:img1_size(2)   %����
            if D(i,j) == 0   %��ֵͼ��ֵΪ0ʱ  ����ɫ��
                img1(i,j) = 0;
            end
            if D(i,j) == 1   %��ֵͼ��ֵΪ1ʱ  ����ɫ��
       
                if ~(i > size_center(1) && j > size_center(1)&& j < size_center(1) + size_center(3)&& i < size_center(1) + size_center(3))    %���ڷ�Χ��*��
                     img1(i,j) = 0;   %ȡΪ��ɫ*
                end
            end
        end
    end
  %% ����ͼƬ
  for m = 1:img1_size(1)
        for n = 1:img1_size(2)
            if img1(m,n) == 0    %��ɫԪ�ص����*
                total = total + 1;
            end
        end
  end
 
    if total ~= img1_size(1)*img1_size(2)   %�����ȫ�Ǻ�*
            imwrite(img1,train_path);    %����ͼƬ*
    end
end
