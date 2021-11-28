%% 4
n = -5:5;
x=u(n)-u(n-1);
stem(n,x)
title('x[n] = u[n] - u[n-1] ')
xlabel('Amostras')  
grid on;