function f = csbsvm (X, Y, a, c, u)   %X-data Y-lable

[l,dim] = size(Y);
tol = 1e-9 ; 
itn = 10000; 
t = 2;              %t-1=0  >>  cesi = NAN
rbf_sig = 2;

A = zeros(l,2);  %a矩阵初始化
a1 = zeros(l,1);
error=1;
sig=0;
f=[];
while((t <= itn)&&(error>tol))
   i = unidrnd(l,1,1)  ;   %   随机抽取角标i
   Xi = X(i,1:end);
   Yi = Y(i);
   
   A =  [A a1]           % 动态扩展a矩阵
   
   for j=1:l         
       if j ~=i
            A(j,t+1) = A(j,t) ;
            sig = sig + A(j,t)*rbf_kernel(Xi,X(j,1:end),rbf_sig);
       end 
   end  
   A
   sig;
%    compute cesi
   t;
   Yi;
%    a
%    c
%    u
   cesi = 1 - ((Yi*a*c*u)*sig)/(t-1);
   
   if cesi>0
      % for j= 1:l %所有样本都更新？
  
        A(i,t+1) = A(i,t) + (exp(a*Yi*cesi)-1) / (1 + u*(exp(a*Yi*cesi) - a*Yi*cesi - 1));
      % end
   end
   
   t = t+1;
end

for j=1:l 
    f = [f a*u*c/t * A(j,t)] ;   %error!!! mulyi kernel
end
