function [train_kpca,test_kpca] =kpcaFordata(train,test,threshold,rbf_var)
%% Data kpca processing
%% 源地址：http://blog.sina.com.cn/lssvm
%% 函数默认设置
if nargin <4
rbf_var=10000;%？
end
if nargin <3
threshold = 90;
end
%% 数据处理
patterns=zscore(train); %训练数据标准化
test_patterns=zscore(test); %测试数据标准化
train_num=size(patterns,1); %train_num是训练样本的个数
test_num=size(test_patterns,1);%test_num是测试样本的个数
cov_size = train_num; %cov_size是训练样本的个数
%% 计算核矩阵
for i=1:cov_size,
for j=i:cov_size,
K(i,j) = exp(-norm(patterns(i,:)-patterns(j,:))^2/rbf_var); %核函数rbf_var ？？
K(j,i) = K(i,j);
end
end
unit = ones(cov_size, cov_size)/cov_size;%cov_size是样本的个数
%% 中心化核矩阵
K_n = K - unit*K - K*unit + unit*K*unit;% 中心化核矩阵
%% 特征值分解
[evectors_1,evaltures_1] = eig(K_n/cov_size);
[x,index]=sort(real(diag(evaltures_1)));%sort每行按从小到大排序，x为排序后结果，index为索引
evals=flipud(x) ;% flipud函数实现矩阵的上下翻转
index=flipud(index);
%%将特征向量按特征值的大小顺序排序
evectors=evectors_1(:,index);
%% 单位化特征向量
% for i=1:cov_size
% evecs(:,i) = evectors(:,i)/(sqrt(evectors(:,i)));
% end
train_eigval = 100*cumsum(evals)./sum(evals);
index = find(train_eigval >threshold);

train_kpca = zeros(train_num, index(1)); %train_num是训练样本的个数
%% evecs单位化后的特征矩阵,K_n训练数据的中心化核矩阵
train_kpca=[K_n * evectors(:,1:index(1))];
%% 重建测试数据
unit_test =ones(test_num,cov_size)/cov_size;%cov_size是训练样本的个数
K_test = zeros(test_num,cov_size); %test_num是测试样本的个数，cov_size是训练样本的个数
for i=1:test_num, %test_num是测试样本的个数
for j=1:cov_size,%cov_size是训练样本的个数
K_test(i,j) =exp(-norm(test_patterns(i,:)-patterns(j,:))^2/rbf_var);
end
end
K_test_n = K_test - unit_test*K - K_test*unit +unit_test*K*unit;
test_kpca = zeros(test_num, index(1));%test_num是测试样本的个数
test_kpca = [K_test_n * evectors(:,1:index(1))];