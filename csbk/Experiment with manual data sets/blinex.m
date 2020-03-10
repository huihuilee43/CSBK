%clear
x = -4:0.1:4;
lam1 = 1;
a1 = 5;
b1 = 0.005;
y1 = 1./lam1*(1 - 1./(1 + b1*(exp(a1*x) - a1*x -1)))

plot(x,y1)
pause(5)

for a1 = 0.1:0.5:8
   pause(1)
   x = -4:0.1:4;
   lam1 = 01;
   for b1 = 0.1:0.5:5
   pause(1)
   y1 = 1./lam1*(1 - 1./(1 + b1*(exp(a1*x) - a1*x -1)))
   plot(x,y1)
   title(['a=' num2str(a1) 'b=' num2str(b1)])
   end
    
end
    