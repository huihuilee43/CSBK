function [ w , b ] = nesterovlinexsvm( X, Y , a , c, u )

[m, dim] = size(X);  
X = [ones(m,1) X];  
w = zeros(dim+1,1);  



learning_rate = 0.01; 
itn = 10000;  
tol = 1e-9 ;    
t = 1;   
vel = zeros(dim+1,1);
r = 0.6; 
d = 0.01;
batch = 10;

error = 1;
objectvalue=zeros(itn,1);

while((t <= itn)&&(error>tol))
      rindex = unidrnd(m,batch,1); 
      loss=0;
      w0 = w - r*vel;
      

%       u=0.01;
%       a=2;
%       c=1;
      for i=1:batch
          cesi = max(0,1-Y(rindex(i))*(X(rindex(i),:)*w0));
          loss1 = u*X(rindex(i),:)*(1-exp(a*Y(rindex(i))*cesi))/(1+u*(exp(a*Y(rindex(i))*cesi)-a*Y(rindex(i))*cesi-1))^2;
          %loss1 = X(rindex(i),:)*(exp(a * Y(rindex(i) )) * cesi -1);
          loss2 = 0;  
          if Y(rindex(i))*(X(rindex(i),:)*w0)<1
              loss2 = 1;
          end
          loss3 = loss1*loss2;
          loss = loss + loss3;
      end
      
      
      gradw = w/m + (a*c*loss)'/batch;
      vel = r*vel + learning_rate*gradw; 
      w = w - vel;
      learning_rate = learning_rate*exp(-d*t);
      t = t + 1;
      

    linexloss=0;
    for i=1:m
        v=Y(i)*(X(i,:)*w)-1;
        linexloss=linexloss+(exp(a*v)-a*v-1);
    end
          
    objectvalue(t) = 1/2*norm(w,2)^2+c*linexloss;
   if t>1
       error = abs(objectvalue(t)-objectvalue(t-1));
   end
     
end
b=w(1);
w=w(2:end);

end