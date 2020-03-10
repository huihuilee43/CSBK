function [mean_accuracy ,mean_gmean, std_accuracy] = Crossvalidation(sample,k,a,c,u)

m=size(sample,1);
step=floor(m/k);
all_accuracy=0;
all_gmean=0;

for i=1:k
  
    if i~= k
        startpoint=(i-1)*step+1;
        endpoint=(i)*step;
    
    else
        startpoint=(i-1)*step+1;
        endpoint=m;
    end
  
    
    cv_p=startpoint:endpoint; 
    
  
    testdata=sample(cv_p,2:end);
    testlabel=sample(cv_p,1); 
  
    traindata=sample(:,2:end);
    traindata(cv_p,:)=[];
    trainlabel=sample(:,1);
    trainlabel(cv_p,:)=[];
 
    rbf_var=150;
    threshold = 90;
    [train_kpca,test_kpca] =kpcaFordata(traindata,testdata,threshold,rbf_var);
    
    [w,b] = nesterovlinexsvm(train_kpca, trainlabel, a, c,u);
   
    
    [acc,gmean] = accuracy(test_kpca, testlabel, w, b);
 
    all_accuracy(i) = acc;
    all_gmean(i) = gmean;

end  
    
mean_accuracy = mean(all_accuracy);  
mean_gmean = mean(all_gmean);
std_accuracy = std(all_accuracy); 

end


% function [mean_accuracy , std_accuracy] = Crossvalidation(sample,k,a,c)
% 
% m=size(sample,1);
% step=floor(m/k);
% all_accuracy=0;
% 
% 
% for i=1:k
%   
%     if i~= k
%         startpoint=(i-1)*step+1;
%         endpoint=(i)*step;
%     
%     else
%         startpoint=(i-1)*step+1;
%         endpoint=m;
%     end
%   
%     
%     cv_p=startpoint:endpoint; 
%     
%   
%     testdata=sample(cv_p,2:end);
%     testlabel=sample(cv_p,1); 
%   
%     traindata=sample(:,2:end);
%     traindata(cv_p,:)=[];
%     trainlabel=sample(:,1);
%     trainlabel(cv_p,:)=[];
%  
%     rbf_var=150;
%     threshold = 90;
%     [train_kpca,test_kpca] =kpcaFordata(traindata,testdata,threshold,rbf_var);
%     
%     [w,b] = nesterovlinexsvm(train_kpca, trainlabel, a, c);
%    
%     
%     acc = accuracy(test_kpca, testlabel, w, b);
%  
%     all_accuracy(i) = acc;
% 
% end  
%     
% mean_accuracy = mean(all_accuracy);  
% std_accuracy = std(all_accuracy); 
% 
% end
