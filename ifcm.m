function [center, U, obj_fcn] = ifcm(data,cluster_n)


if nargin ~= 2 
	error('Too many or too few input arguments!');
end

% data_n = size(data, 1);
% in_n = size(data, 2);

% 默认的参数,参照fcm.m
default_options = [2;	% exponent for the partition matrix U
		100;	%  maximum number of iterations 
		1e-3;	%    minimum amount of improvement    
		1];	% info display during iteration 
    try
        if nargin == 2
            options = default_options;
         
        end
    catch
        error('too few input argument');
    end

expo = options(1);		% Exponent for U
max_iter = options(2);		% Max. iteration
min_impro = options(3);		% Min. improvement
display = options(4);		% Display info or not
obj_fcn = zeros(max_iter, 1);	% Array for objective function


center= initifcmv(cluster_n);            %初始化聚类中心
[Miuij,Vij,Paiij]=initifcmmvp(data);    %初始化参数

for i = 1:max_iter
    [U, center, obj_fcn(i)] = ifcm_step(data, center, cluster_n, expo, Miuij,Vij,Paiij);
	if display
		fprintf('Iteration count = %d, obj. fcn = %f\n', i, obj_fcn(i));
	end
	% 检查终止条件
	if i>1
% 		if abs(obj_fcn(i) - obj_fcn(i-1)) < min_impro, break; end,
 %        if norm(old_U-U,2) < min_impro, break; end,
%        if norm(old_U-U,'fro') < min_impro, break; end,
       if norm(old_center-center,2) < min_impro
           break; 
       end
       % (old_center-center).^2
         
    end
    old_U = U;
    old_center = center;
end

% iter_n = i;	% Actual number of iterations 
% % obj_fcn(iter_n+1:max_iter) = [];
% mf = old_U.^expo;       % 隶属度矩阵进行指数运算结果
% dist = distfcm(old_center, data);       % 计算距离矩阵
% obj_fcn = sum(sum((dist.^2).*mf));  % 计算目标函数值 

