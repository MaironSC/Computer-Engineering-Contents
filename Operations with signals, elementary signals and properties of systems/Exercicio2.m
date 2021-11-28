t=-5:0.001:5;
y = (3*t-2).*(u(-t+3)-(u(-t+4)+u(-t+1))).*u(t+2);
plot(t,y)
title('y(t) = (3t-2) * (u(-t+3) - (u(-t+4) + u(-t+1))) * u(t+2)')
xlabel('Tempo')  
grid on;