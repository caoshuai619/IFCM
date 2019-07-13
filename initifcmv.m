function V = initifcmv(cluster_n)
%%%初始化聚类中心（随机）
 V = rand(cluster_n,1);
disp('初始聚类中心')
% V =[ 0.9289;
%     0.7303;
%     0.4886;
%     0.5785]

V
disp('聚类个数')
length(V)
end

