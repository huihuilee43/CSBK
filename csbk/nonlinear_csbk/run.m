close all;
clear;
clc;

load('r1.mat');
load('s1.mat');
r=r1;
s=s1;

plot(r(:,1),r(:,2),'r*');
hold on;
plot(s(:,1),s(:,2),'b+');
xlim([-5 5])
ylim([-5 5])

X = [r;s];
l = size(X,1);
%X = [X ones(l,1)];
Y = [ones(size(r,1),1) ; -ones(size(s,1),1)];
sample = [Y,X];

allnumber=size(sample,1);
    s=randperm(allnumber);
    sample=sample(s,:);

% 
k=5;
[max_acc,max_gmean,best_a,best_c,best_u] = gridsearch(sample,k);

[acc,gmean] = accuracy(X,Y,X,Y,a,c,u)

