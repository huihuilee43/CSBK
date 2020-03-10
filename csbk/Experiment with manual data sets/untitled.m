clear;clc;close all;

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
% X = [X ones(l,1)];
Y = [ones(size(r,1),1) ; -ones(size(s,1),1)];
dataset=[Y X];

A = dataset(:,:);

allnumber=size(dataset,1);
s=randperm(allnumber);
dataset=dataset(s,:);

% x1 = A(:,2);
% x2 = A(:,3);
% x1t=[];
% y1t=[];
% x1f=[];
% y1f=[];
% 
% x1tn=[];
% y1tn=[];
% x1fn=[];
% y1fn=[];
% y = A(:,1);

% 
% for i=1:numel(y)   %for i=1:(numel(y)-10)
%     if y(i)==1
%         x1t=[x1t x1(i)];
%         y1t=[y1t x2(i)];
%     else
%         x1f=[x1f x1(i)];
%         y1f=[y1f x2(i)];
%     end
% end

% for i=(numel(y)-10):numel(y)
%     if y(i)==1
%         x1tn=[x1tn x1(i)];
%         y1tn=[y1tn x2(i)];
%         
%     else
%         x1fn=[x1fn x1(i)];
%         y1fn=[y1fn x2(i)];
%     end
% % end
% scatter(x1t,y1t,'x','r');hold on;
% scatter(x1f,y1f,17,'b');hold on;  %'filled'     
% % scatter(x1tn,y1tn,'x','r');hold on;
% % scatter(x1fn,y1fn,17,'b');hold on;

set(gca,'linewidth',1.5);
box on;
set(gca,'XLim',[-5 5]);%X轴的数据显示范围
set(gca,'YLim',[-5 5]);%X轴的数据显示范围
set(gca,'FontSize',20);  %是设置刻度字体大小






%scatter(A(:,2),A(:,3))
% disp(A)
% plot(A)

k = 5 ;
[max_acc ,max_gmean, max_std , Best_a, Best_c,Best_U]=gridsearch(dataset, k)
% Best_a = 1;%1.3
% Best_c = 10;%8
% Best_U = 0.01;

[ w ,b] = nesterovlinexsvm( dataset(:,2:end), dataset(:,1) ,Best_a, 2^Best_c,Best_U);
[acc,gmean] = accuracy(dataset(:,2:end), dataset(:,1) , w, b);
disp(w)
disp(b)


x1 = 0:0.1:10;
x2=-(b+w(1)*x1)/w(2);

plot(x1,x2,'black','LineWidth',1.5);hold on ;
h=legend('positive class','negative class','Blinex SVM');
set(h,'FontName','Times New Roman','FontSize',18,'FontWeight','normal');


% draw plane: wx+b=0


