%% 5
t=-10:0.001:10;
T=0.5; %período de amostragem
n=-20:20;
x_cont= cos(pi*t).*u(t +4);
subplot(2,1,1); plot(t,x_cont)
title('y(t) = cos(\pi*t) * u(t + 4)')
xlabel('Tempo')  
grid on;

x_amost= cos(pi*n*T) .*u(n*T +4);
subplot(2,1,2); 
stem(n,x_amost)
title('x[n] = cos(\pi*n*T) * u(n*T + 4)')
xlabel('Amostras')  
grid on;