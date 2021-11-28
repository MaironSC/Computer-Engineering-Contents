t=0:0.001:10;
h= -0.5668*exp(-0.3542*t) + 0.5668*exp(-5.6457*t);
x=2*u(t)-u(t-1)-u(t-2);
y=conv(x,h)*0.001;
subplot(3,1,1)
plot(t,x);
title('x(t) = 2*u(t)-u(t-1)-u(t-2)');
legend('x(t)');
grid on
subplot(3,1,2)
plot(t,h);
title('h(t) =-0.5668*exp(-0.3542*t) + 0.5668*exp(-5.6457*t)');
legend('h(t)');
grid on

subplot(3,1,3)
plot(t,y(1:length(t)), 'Linewidth',3);
hold on;


%intervalo de 0 a t, ONDE A = u(t-tau) = 2
x1 = 2*(1.60022*exp(-0.3542*t)-0.10039*exp(-5.6457*t)-1.49983);

%intervalo de 0 a t-1, onde A = u(t-tau) = 1
x2 = (1.60022*exp(-0.3542*(t-1))-0.10039*exp(-5.6457*(t-1))-1.49983);

%intervalo de t-1 a t, onde A = u(t-tau) = 2
x3 = 2*(1.60022*(exp(-0.3542*t) - exp(-0.3542*(t-1))) - 0.10039*(exp(-5.6457*t)-exp(-5.6457*(t-1))));

%intervalo de t-2 a t-1, onde A = u(t-tau) = 1
x4 = 1.60022*(exp(-0.3542*(t-1))-exp(-0.3542*(t-2))) - 0.10039*(exp(-5.6457*(t-1))-exp(-5.6457*(t-2)));

y_calc = x1.*(u(t) - u(t-1)) + x2.*(u(t-1)-u(t-2)) + x3.*(u(t-1)) + x4.*u(t-2);
plot(t,y_calc, '-.' , 'Linewidth', 2);
legend('Convolução', 'Convolução calculada', 'Location', 'East')
title('y_{calc} = x1.*(u(t) - u(t-1)) + x2.*(u(t-1)-u(t-2)) + x3.*(u(t-1)) + x4.*u(t-2)')
grid on;
