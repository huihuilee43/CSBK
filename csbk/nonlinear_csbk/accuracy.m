function [acc,gmean] = accuracy(test_data,test_label,X,Y,a,c,u)  %X,Y分别为Train_data  Train_label

test_m=size(test_data,1);
predictlabel=zeros(test_m,1);
P = 0;
N = 0;
TP = 0;
FP = 0;
FN = 0;
TN = 0;

for j=1:test_m
        predictlabel(j)=sign(nonlinear_forcast( test_data(j,:), X, Y, a, c, u ) )  %  没被抽到的为0？？
        
        if test_label(j) == 1
            P = P+1;
            if predictlabel(j) == 1
                TP = TP+1;
            else
                FN = FN+1;
            end
        else
            N = N+1;
            if predictlabel(j) == -1
                TN = TN+1;
            else
                FP = FP+1;
            end
        end 
end
P
TP
FP
N
TN
FN
acc = (TP+TN)/(TP+FN+FP+TN)
precision = TP/(TP+FP);
sensitivity = TP/(TP+FN);
specificity = TN/(FP+TN);
gmean = sqrt((TP/(TP+FN)) * (TN/(TN+FP)))
a
c
u
