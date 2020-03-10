function [FX, label] = nonlinear_forcast( test_data, X, Y, a, c, u )

[l,dim] = size(X);
alpha = csbsvm(X, Y, a, c, u);
sigma =2;
label = []; 
FX = [];
lab=0;
for i=1:numel(test_data(:,1))
    for j=1:l
        alpha;
        
        lab = lab + a*c*u/l * alpha(j)*rbf_kernel( X(i,:),test_data(i,2:end) , sigma );
    end
    FX = [FX lab];
    lab = sign(lab);
    label = [label lab];
end