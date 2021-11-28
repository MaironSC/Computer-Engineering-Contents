t=-10:0.001:10;
x1 = jexp(-0.4, 30, t);
subplot(5,1,1);
plot(t,x1)

title('y(t) = -0.4e^{?t}cos?t (s = ? ± j30) ')
xlabel('Tempo')  
grid on;

x2 = u(t);
subplot(5,1,2);
plot(t,x2)
title('y(t) = u(t)')
xlabel('Tempo')  
grid on;


x3 =0.5*sin(pi*t)+2;
subplot(5,1,3);
plot(t,x3)
title('y(t) = 0.5*sin(pi*t) + 2')
xlabel('Tempo') 
grid on;

x4 = rectangularPulse(t+4) + rectangularPulse(t+2) + rectangularPulse(t+6) + rectangularPulse(t+8);
subplot(5,1,4);
plot(t,x4)
title('y(t) = rectangularPulse(t+4) + rectangularPulse(t+2) + rectangularPulse(t+6) + rectangularPulse(t+8)')
xlabel('Tempo') 
grid on;

y =  ((x1.*x3)).*((x4+(6*x2)));
subplot(5,1,5);
plot(t,y)
title('y(t) = ((x1(t).*x3(t)) * ((x4+(6*x2)))')
xlabel('Tempo') 
grid on;

