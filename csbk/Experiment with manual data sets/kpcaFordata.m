function [train_kpca,test_kpca] =kpcaFordata(train,test,threshold,rbf_var)
%% Data kpca processing
%% Դ��ַ��http://blog.sina.com.cn/lssvm
%% ����Ĭ������
if nargin <4
rbf_var=10000;%��
end
if nargin <3
threshold = 90;
end
%% ���ݴ���
patterns=zscore(train); %ѵ�����ݱ�׼��
test_patterns=zscore(test); %�������ݱ�׼��
train_num=size(patterns,1); %train_num��ѵ�������ĸ���
test_num=size(test_patterns,1);%test_num�ǲ��������ĸ���
cov_size = train_num; %cov_size��ѵ�������ĸ���
%% ����˾���
for i=1:cov_size,
for j=i:cov_size,
K(i,j) = exp(-norm(patterns(i,:)-patterns(j,:))^2/rbf_var); %�˺���rbf_var ����
K(j,i) = K(i,j);
end
end
unit = ones(cov_size, cov_size)/cov_size;%cov_size�������ĸ���
%% ���Ļ��˾���
K_n = K - unit*K - K*unit + unit*K*unit;% ���Ļ��˾���
%% ����ֵ�ֽ�
[evectors_1,evaltures_1] = eig(K_n/cov_size);
[x,index]=sort(real(diag(evaltures_1)));%sortÿ�а���С��������xΪ���������indexΪ����
evals=flipud(x) ;% flipud����ʵ�־�������·�ת
index=flipud(index);
%%����������������ֵ�Ĵ�С˳������
evectors=evectors_1(:,index);
%% ��λ����������
% for i=1:cov_size
% evecs(:,i) = evectors(:,i)/(sqrt(evectors(:,i)));
% end
train_eigval = 100*cumsum(evals)./sum(evals);
index = find(train_eigval >threshold);

train_kpca = zeros(train_num, index(1)); %train_num��ѵ�������ĸ���
%% evecs��λ�������������,K_nѵ�����ݵ����Ļ��˾���
train_kpca=[K_n * evectors(:,1:index(1))];
%% �ؽ���������
unit_test =ones(test_num,cov_size)/cov_size;%cov_size��ѵ�������ĸ���
K_test = zeros(test_num,cov_size); %test_num�ǲ��������ĸ�����cov_size��ѵ�������ĸ���
for i=1:test_num, %test_num�ǲ��������ĸ���
for j=1:cov_size,%cov_size��ѵ�������ĸ���
K_test(i,j) =exp(-norm(test_patterns(i,:)-patterns(j,:))^2/rbf_var);
end
end
K_test_n = K_test - unit_test*K - K_test*unit +unit_test*K*unit;
test_kpca = zeros(test_num, index(1));%test_num�ǲ��������ĸ���
test_kpca = [K_test_n * evectors(:,1:index(1))];