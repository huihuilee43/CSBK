clear
x = -10:0.1:10;

lam2 = 1;
a2 =2;
b2 = 0.01;
y2 = blinex(a2,b2,lam2,x);
plot(x,y2,':','LineWidth',5);hold on;

lam1 = 1;
a1 =5;
b1 = 0.01;
y1 = blinex(a1,b1,lam1,x);
plot(x,y1,'k','LineWidth',5);hold on;


lam3 = 1;
a3 =10;
b3 = 0.01;
y3 = blinex(a3,b3,lam3,x);
plot(x,y3,'--','LineWidth',5);hold on;



set(gca,'XLim',[-5 5]);%X轴的数据显示范围
set(gca,'YLim',[0 1.2]);%X轴的数据显示范围
set(gca,'linewidth',1.5);
set(gca,'FontSize',20);  %是设置刻度字体大小
h=legend('b=0.01, \lambda=1, a=1','b=0.01, \lambda=1, a=5','b=0.01, \lambda=1, a=10');
%'a=5, b=0.1, \lambda=1','a=5, b=0.1, \lambda=2','a=5, b=0.1, \lambda=5' 
%'a=5, \lambda=1, b=1','a=5, \lambda=1, b=0.1','a=5, \lambda=1, b=0.01'
%'b=0.01, \lambd=1, a=1','b=0.01, \lambd=1, a=5','b=0.01, \lambd=1, a=10',
set(h,'FontName','Times New Roman','FontSize',14,'FontWeight','normal');
xlabel('x','FontWeight','bold','Fontsize',17); 
ylabel('L(x)','FontWeight','bold','Fontsize',17);
box on;




%------------------------------------------------------------------------------------------------------------
% lam1 = 1;
% a1 =5;
% b1 = 0.1;
% y1 = blinex(a1,b1,lam1,x);
% plot(x,y1,'k--','LineWidth',2);hold on;
% 
% lam1 = 1;
% a1 =5;
% b1 = 0.01;
% y1 = blinex(a1,b1,lam1,x);
% plot(x,y1,'r--','LineWidth',2);hold on;
% 
% lam1 = 1;
% a1 =5;
% b1 = 1;
% y1 = blinex(a1,b1,lam1,x);
% plot(x,y1,'b--','LineWidth',2);hold on;
% 
% 
% 
% lam1 = 1;
% a1 =5;
% b1 = 0.01;
% y1 = blinex(a1,b1,lam1,x);
% plot(x,y1,'k','LineWidth',2);hold on;
% 
% lam1 = 1;
% a1 =10;
% b1 = 0.01;
% y1 = blinex(a1,b1,lam1,x);
% plot(x,y1,'r','LineWidth',2);hold on;
% 
% lam1 = 1;
% a1 =1;
% b1 = 0.01;
% y1 = blinex(a1,b1,lam1,x);
% plot(x,y1,'b','LineWidth',2);hold on;
% 
% 
% 
% 
% lam1 = 1;
% a1 =5;
% b1 = 0.01;
% y1 = blinex(a1,b1,lam1,x);
% plot(x,y1,'k:','LineWidth',2);hold on;
% 
% lam1 = 2;
% a1 =5;
% b1 = 0.01;
% y1 = blinex(a1,b1,lam1,x);
% plot(x,y1,'r:','LineWidth',2);hold on;
% 
% lam1 = 5;
% a1 =5;
% b1 = 0.01;
% y1 = blinex(a1,b1,lam1,x);
% plot(x,y1,'b:','LineWidth',2);hold on;
% 
% 
% 
% set(gca,'XLim',[-3 3]);%X轴的数据显示范围
% set(gca,'YLim',[0 1.2]);%X轴的数据显示范围
% set(gca,'linewidth',1.5);
% set(gca,'FontSize',20);  %是设置刻度字体大小
% h=legend('b=0.1 a=5 c=1','b=0.1 a=5 c=2','b=0.1 a=5 c=5');
% set(h,'FontName','Times New Roman','FontSize',14,'FontWeight','normal');
% box on;


