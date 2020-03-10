clear;clc;close all;
n = 100;m = 15;
lx = randn(n,1)+3; %3
ly = randn(n,1)+3; %5
AP = [lx ly];

ilx = randn(n,1)+8;
ily = randn(n,1)+10;
BP = [ilx ily];

ilx = randn(m,1)+10;  %10
ily = randn(m,1)+9;   %-3
AN = [ilx ily];  

ilx = randn(m,1)+10;
ily = randn(m,1)+8;
BN = [ilx ily];
scatter(AP(:,1),AP(:,2));hold on;
% scatter(BP(:,1),BP(:,2));hold on;
scatter(AN(:,1),AN(:,2));hold on;
% scatter(BN(:,1),BN(:,2));

label=[-ones(100,1);ones(15,1)];

s=randperm(m+n);
A=[AP;AN];B=[BP;BN];
A=A(s,:);B=B(s,:);label=label(s);
T = [label,A];
save toydata3 T ;