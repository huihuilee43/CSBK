function y = blinex(a1,b1,lam1,x)

y = 1./lam1*(1 - 1./(1 + b1*(exp(a1*x) - a1*x -1)));