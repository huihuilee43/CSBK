function [max_acc,max_gmean,best_a,best_c,best_u] = gridsearch(sample,k)

target_c=7;
target_a=3;
target_u=0.023;
a_gap = 0.25;
c_gap = 0.25;
u_gap = 0.002;

A=0;
C=0;
U=0;

numOfX=8;
for i=1:numOfX
    A(i)=target_a+a_gap*(i-numOfX/2);
    C(i)=target_c+c_gap*(i-numOfX/2);
    U(i)=target_u+u_gap*(i-numOfX/2);
end

max_acc=0;
max_gmean=0;
max_f1=0;

for a = A
    for c = C
        for u = U
            [mean_accuracy , mean_gmean] = Crossvalidation(sample,k,a,2^c,u);
%             if mean_accuracy>max_acc
%                 max_acc=mean_accuracy;
%                 best_a = a;
%             end
            if mean_gmean>max_gmean
                max_gmean=mean_gmean;
                best_a = a;
                best_c = c;
                best_u = u;
            end
%             if mean_f1>max_f1
%                 max_f1=mean_f1
%             end
        end
    end
end
