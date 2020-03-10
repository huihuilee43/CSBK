% function [acc, max_acc , max_std , Best_a, Best_c]=gridsearch(sample, k)
% 
%  c =4; 
%  a = 3;
% [A, C] = meshgrid(a,c);
% acc = [];
% std = [];
% 
% for i = 1:numel(A)
%    [mean_accuracy , std_accuracy] = Crossvalidation(sample,k,A(i),2^C(i));
%    acc=[acc mean_accuracy];
%    std=[std std_accuracy];
% end
% 
% [max_acc,idx] = max(acc);
% max_std = std(idx);
% 
% Best_a = A(idx);
% Best_c = C(idx);
% 
% end
function [max_acc ,max_gmean, max_std , Best_a, Best_c,Best_U]=gridsearch(sample, k)
A=[0.5,1,1.5,2,2.5,3,3.5,4,4.5,5,6,7,8,9,];
C=[0.5,1,2,3,4,5,6,7,8,9,10];
U=[0.1,0.2,0.5,0.8,1,0.01,0.05,0.08,0.001,0.005];

Best_a=0;
Best_c=0;
Best_U=0;

max_score=0;
max_acc=0;
max_gmean=0;
max_std=0;


for a = A
    for c = C
        for u = U
            [mean_accuracy , mean_gmean,std_accuracy] = Crossvalidation(sample,k,a,2^c,u);
            if mean_accuracy+mean_gmean>max_score
                max_score=mean_accuracy+mean_gmean;
                max_acc=mean_accuracy;
                max_gmean=mean_gmean;
                max_std=std_accuracy;
                Best_a=a;
                Best_c=c;
                Best_U=u;
            end
        end
    end
end

