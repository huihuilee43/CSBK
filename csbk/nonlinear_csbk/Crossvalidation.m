function [mean_acc, mean_gmean] = Crossvalidation (sample, k, a, c, u)

m=size(sample,1);
step=floor(m/k);
all_accuracy=0;
all_gmean=0;
all_f1=0;

for i=1:k
  
    if i~= k
        startpoint=(i-1)*step+1;
        endpoint=(i)*step;
    
    else
        startpoint=(i-1)*step+1;
        endpoint=m;
    end
  
    
    cv_p=startpoint:endpoint; 
    
  
    test_data=sample(cv_p,2:end);
    test_label=sample(cv_p,1); 
  
    train_data=sample(:,2:end);
    train_data(cv_p,:)=[];
    train_label=sample(:,1);
    train_label(cv_p,:)=[];
    
    
    
     
   % [w,b] = nesterovlinexsvm(traindata, trainlabel, a, c,u);   %1.È¥µôkpca
   [acc,gmean] = accuracy(test_data,test_label,train_data,train_label,a,c,u);
   
    
    
    all_accuracy(i) = acc;
    all_gmean(i) = gmean;
    %all_f1(i) = f1;

end  
    
mean_acc = mean(all_accuracy);  
mean_gmean = mean(all_gmean);
mean_f1 = mean(all_f1);
std_accuracy = std(all_accuracy); 

end
