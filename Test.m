clear all
close all
clc


%%
% *%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%测试专用%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%测试专用%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%测试专用%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%测试专用%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%测试专用%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%测试专用%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%测试专用%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*

str = 'IMG-0004-00001.dcm';
if strfind(str,'dcm')
    I=dicomread(str);
else
    I = imread(str);
end

if size(I,3) == 3
   I=rgb2gray(I);

end
 figure;imshow(I,[]);title('(a)原始图像');

[m,n]=size(I);


k=4;  %聚类的个数


I=im2double(I);
I4 = I(:);  %% 将图像灰度按列排列



%% ------------------------ ifcm------------------------
ifcm_label=zeros(m*n,1);   %存储分类后的标签
t=cputime;
tic;
[O2, U2, obj_fcn2] = ifcm(I4, k);
toc;
time_fcm_spatial_mean=cputime-t;
maxU2 = max(U2);   %隶属度最大  


for j=1:k
    index = find(U2(j, :) == maxU2);  %隶属度最大对应的像素位置
   ifcm_label(index) = j;    
end
labels2=reshape(ifcm_label,[m n]);
% labels2
%显示不同的颜色
nsrc = zeros(m,n,3); %存储的图片

[rindice ,cindice] = find(labels2==1);

for i = 1 : numel(rindice)
    nsrc(rindice(i) , cindice(i) , 2) = 1;
end

%对满足蓝色条件的点操作
[rindice cindice] = find(labels2==2);
for i = 1 : numel(rindice)
    nsrc(rindice(i) , cindice(i) , 3) = 1;
end

%对满足红色条件的点操作
[rindice cindice] = find(labels2==3);
for i = 1 : numel(rindice)
    nsrc(rindice(i) , cindice(i) , 1) = 1;
end

%对满足黑色条件的点操作
[rindice cindice] = find(labels2==4);
for i = 1 : numel(rindice)
    nsrc(rindice(i) , cindice(i) , 1) = 0;
end

figure,imshow(nsrc),title('(b)聚类标记颜色后的图像');



%显示聚类分割图
labels2(find(labels2==1))=0;
labels2(find(labels2==2))=255;
labels2(find(labels2==3))=100;
labels2(find(labels2==4))=180;
labels2=uint8(labels2);



figure;imshow(labels2,[]);title('(c)聚类分割图');









