close all;
clear;
clc;


name={'Australian_scale'};
path0 = '/Users/huihui/Documents/temp/code/xu/linex-svm_CODE/data/1VS10/';

pathsave = '.\results\'; 
fsave = strcat(pathsave,'Pima_scale.mat','.csv');

k=5; 
dataset_num=length(name);
output_title={ 'Best_a', 'Best_c', 'max_acc', 'max_std',  'toc'};
csvwrite(fsave,output_title,1,2);
%csvwrite(fsave,name,2,1);
result=zeros(dataset_num,5);

for fi=1:dataset_num
   
    
    disp(['The current runing dataset is ',name{fi}]);
    filename1= strcat(path0,name{fi},'.mat');
    dataset=cell2mat(struct2cell(load(filename1)));
    
    rand('state',2);
    allnumber=size(dataset,1);
    s=randperm(allnumber);
    dataset=dataset(s,:);
    

    [max_acc ,max_gmean, max_std , Best_a, Best_c,Best_U]=gridsearch(dataset, k);
    tic;
    [ w ,b] = nesterovlinexsvm( dataset(:,2:end), dataset(:,1) ,Best_a, 2^Best_c,Best_U);
    toc
    out=[max_acc ,max_gmean, max_std , Best_a, Best_c,Best_U]
    %result(fi,:) = out;
    %csvwrite(fsave,result,2,2);
    
    
end
