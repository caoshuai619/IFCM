clear all
close all
clc


%%
% *%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����ר��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����ר��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����ר��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����ר��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����ר��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����ר��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����ר��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*

str = 'IMG-0004-00001.dcm';
if strfind(str,'dcm')
    I=dicomread(str);
else
    I = imread(str);
end

if size(I,3) == 3
   I=rgb2gray(I);

end
 figure;imshow(I,[]);title('(a)ԭʼͼ��');

[m,n]=size(I);


k=4;  %����ĸ���


I=im2double(I);
I4 = I(:);  %% ��ͼ��ҶȰ�������



%% ------------------------ ifcm------------------------
ifcm_label=zeros(m*n,1);   %�洢�����ı�ǩ
t=cputime;
tic;
[O2, U2, obj_fcn2] = ifcm(I4, k);
toc;
time_fcm_spatial_mean=cputime-t;
maxU2 = max(U2);   %���������  


for j=1:k
    index = find(U2(j, :) == maxU2);  %����������Ӧ������λ��
   ifcm_label(index) = j;    
end
labels2=reshape(ifcm_label,[m n]);
% labels2
%��ʾ��ͬ����ɫ
nsrc = zeros(m,n,3); %�洢��ͼƬ

[rindice ,cindice] = find(labels2==1);

for i = 1 : numel(rindice)
    nsrc(rindice(i) , cindice(i) , 2) = 1;
end

%��������ɫ�����ĵ����
[rindice cindice] = find(labels2==2);
for i = 1 : numel(rindice)
    nsrc(rindice(i) , cindice(i) , 3) = 1;
end

%�������ɫ�����ĵ����
[rindice cindice] = find(labels2==3);
for i = 1 : numel(rindice)
    nsrc(rindice(i) , cindice(i) , 1) = 1;
end

%�������ɫ�����ĵ����
[rindice cindice] = find(labels2==4);
for i = 1 : numel(rindice)
    nsrc(rindice(i) , cindice(i) , 1) = 0;
end

figure,imshow(nsrc),title('(b)��������ɫ���ͼ��');



%��ʾ����ָ�ͼ
labels2(find(labels2==1))=0;
labels2(find(labels2==2))=255;
labels2(find(labels2==3))=100;
labels2(find(labels2==4))=180;
labels2=uint8(labels2);



figure;imshow(labels2,[]);title('(c)����ָ�ͼ');









