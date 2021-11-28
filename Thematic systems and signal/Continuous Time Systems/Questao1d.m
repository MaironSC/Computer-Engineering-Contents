t=0:0.001:10;
y = 11.8032*exp(-0.3542*t) - 1.8032*exp(-5.6457*t);
subplot(1,1,1)
plot(t,y,'m','Linewidth',2.5);


syms y(t);
Dy = diff(y);
edo = diff(y,t,2)+(5+1)*diff(y,t)+(1+1)*y==0;
cond1 = y(0)==(5*2); cond2 = Dy(0) == (5+1);
conds=[cond1 cond2];
y_nat(t)=dsolve(edo,conds);
y_nat=simplify(y_nat(t));
hold on;
fplot(y_nat,[0 10],'-.', 'Linewidth',1.5)

lgd = legend('Calculado', 'Exercício');
title(lgd,'Resposta natural 1d) e 1e)')
grid on;