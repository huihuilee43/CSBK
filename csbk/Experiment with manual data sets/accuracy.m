function [acc,gmean] = accuracy(testdata, testlabel, w, b)
%计算精确度
test_m=size(testdata,1);
predictlabel=zeros(test_m,1);

P = 0;
N = 0;
TP = 0;
FN = 0;
TN = 0;
FP = 0;
for j=1:test_m
    predictlabel(j)=sign(testdata(j,:)*w+b);      
    if testlabel(j) == 1
            P = P+1;
        if predictlabel(j) == 1
            TP = TP+1;
        else
            FN = FN+1;
        end
    else        %testlable = -1
        N = N+1;
        if predictlabel(j) == -1
            TN = TN+1;
        else
            FP = FP+1;
        end
    end 
end
    
    P;
    N;
    TP;
    TN;
    FP;
    FN;
    
    acc = (TP+TN)/(TP+TN+FP+FN);
    recall = TP/(TP+FN);
    pre = TP/(TP+FP);
    speci = TN/(TN+FP);
    gmean = sqrt(recall*speci);  
    sen = TP/(TP+FN);
    f1 = 2*pre*recall/(pre+recall);
    %acc=1-(norm(1/2*(predictlabel-testlabel))^2)/test_m;
    
end