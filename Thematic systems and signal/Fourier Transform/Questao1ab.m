%Questão 1a) e 1b):
t = -10:0.001:10;
x1 = u(t + 6) - u(t+2); subplot(4,1,1); plot(t,x1); l = legend('x1 (Primeira componente)');grid on;title('x1 = u(t + 6) - u(t+2)');
x2 = 3*(u(t+2)-u(t-2));subplot(4,1,2); plot(t,x2); l = legend('x2 (Segunda componente)');grid on;title('x2 =  3*(u(t+2)-u(t-2))');
x3 = -1*(u(t-2)-u(t-4));subplot(4,1,3); plot(t,x3); l = legend('x3 (Terceira componente)');grid on; title('x3 = -1*(u(t-2)-u(t-4))');
x = x1+x2 + x3;subplot(4,1,4); plot(t,(x)); l = legend('x (Soma das componentes)');grid on;title('x = x1 + x2 + x3');
xsinal1 = x;

figure(2);
x1 = 2.*sin(2*pi*t).*u(t+2); subplot(3,1,1); plot(t,x1); l = legend('x1 (Primeira componente)', 'Location','northwest'); grid on;title('x1 = 2*sin(2*\pi*t) * u(t+2)');
x2 = 2.*sin(2*pi*t).*u(t-2); subplot(3,1,2); plot(t,x2); l = legend('x2 (Segunda componente)', 'Location','northwest');grid on;title('x2 = 2*sin(2*\pi*t) * u(t-2)');
x= x1-x2; subplot(3,1,3); plot(t,(x)); l = legend('x (Soma das componentes)', 'Location','northwest');grid on;title('x = x1 - x2');
xsinal2 = x;


figure(3);
x1 = 2.*sin(2*pi*t).*u(t+4); subplot(3,1,1); plot(t,x1);l = legend('x1 (Primeira componente)', 'Location','northwest');grid on;title('x1 = 2*sin(2*\pi*t) * u(t+4)');
x2 = 2.*sin(2*pi*t).*u(t); subplot(3,1,2); plot(t,x2);l = legend('x2 (Segunda componente)', 'Location','northwest');grid on; title('x2 = 2*sin(2*\pi*t) * u(t)');
x = x1-x2; subplot(3,1,3); plot(t,x);l = legend('x (Soma das componentes)',  'Location','northwest');grid on;title('x = x1-x2');
xsinal3 = x;

figure(4);
subplot(3,1,1); plot(t,xsinal1); grid on; title('Sinal 1');
subplot(3,1,2); plot(t,xsinal2); grid on; title('Sinal 2');
subplot(3,1,3) ;plot(t,xsinal3); grid on; title('Sinal 3');

