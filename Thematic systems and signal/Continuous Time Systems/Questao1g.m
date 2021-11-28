t=0:0.001:10;
y_imp = -0.5668*exp(-0.3542*t) + 0.5668*exp(-5.6457*t);
subplot(1,1,1)
plot(t,y_imp,'Linewidth',1.5');

lgd = legend('Resposta ao impulso');
title(lgd,'Questão 1g)')
grid on;