function [Miuij,Vij,Paiij]=initifcmmvp(data)


Miuij=data;  %隶属度
alpha=0.85;   %参数     %调这个参数，我实验的结果基本alpha在0.8-0.9之间效果比较好
Vij=(1-Miuij.^alpha).^(1/alpha); %非隶属度
Paiij=1-Miuij-Vij;  %不确定度矩阵
end
