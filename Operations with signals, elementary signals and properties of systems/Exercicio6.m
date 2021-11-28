t=-10:0.001:10;
x1 = jexp(-0.4, 30, t);
x2 = u(t);
x3 = 0.5*sin(pi*t)+2;
x4 = rectangularPulse(t+4) + rectangularPulse(t+2) + rectangularPulse(t+6) + rectangularPulse(t+8);
y =  ((x1.*x3)).*((x4+(6*x2)));
subplot(3,1,1);
plot(t,y)
title('y(t) = ((x1(t).*x3(t)) * ((x4(t)+(6*x2(t))))')
xlabel('Tempo') 
grid on;


T=0.1;
n=-100:100;
x1_disc = jexp(-0.4, 30, n*T);
x2_disc = u(n*T);
x3_disc = 0.5*sin(pi*(n*T))+2;
x4_disc = rectangularPulse((n*T)+4) + rectangularPulse((n*T)+2) + rectangularPulse((n*T)+6) + rectangularPulse((n*T)+8);
y_disc = ((x1_disc.*x3_disc)).*((x4_disc+(6*x2_disc)));
subplot(3,1,2);
stem(n, y_disc);
title('y[n] = ((x1[n].*x3[n]) * ((x4[n]+(6*x2[n]))) ; T=0.1')
xlabel('Amostras') 

T=0.2;
n=-100:100;

x1_disc = jexp(-0.4, 30, n*T);
x2_disc = u(n*T);
x3_disc = 0.5*sin(pi*(n*T))+2;
x4_disc = rectangularPulse((n*T)+4) + rectangularPulse((n*T)+2) + rectangularPulse((n*T)+6) + rectangularPulse((n*T)+8);
y_disc = ((x1_disc.*x3_disc)).*((x4_disc+(6*x2_disc)));
subplot(3,1,3);
stem(n, y_disc);
title('y[n] = ((x1[n].*x3[n]) * ((x4[n]+(6*x2[n]))); T=0.2')
xlabel('Amostras') 

