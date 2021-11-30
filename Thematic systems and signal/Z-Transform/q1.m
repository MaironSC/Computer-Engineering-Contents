%%
% Letra a)
interacao = 32;
y_q1=zeros(size(interacao));
x=zeros(size(interacao));
y_q1(1) = 4;
y_q1(2) = 10;

for n = 3:1:32
    x(n) = u(n-3) - u(n-14);
    y_q1(n) = 2/7*y_q1(n-1) -0.5*y_q1(n-2) + 3*x(n-1) - 6*x(n);
end

percorrer = -2:1:29;
subplot(4,1,1);
stem(percorrer, y_q1);
title('Resposta completa calculada através da forma recursiva');
legend('y_{Resp}_{[n]}');
grid on;
%%
%b)
y_q2=zeros(size(interacao));
y_q2(1) = 4;
y_q2(2) = 10;
for n = 0:1:interacao-3
    y_q2(n+3) = (7.094.*((0.707).^n).*cos(1.367.*n +1.449)).*u(n);
end

subplot(4,1,2);
stem(percorrer, y_q2);
title('Resposta natural');
legend('y_{natural}_{[n]}');
grid on;


y_forcada=zeros(size(interacao));
for n = 0:1:interacao-3
    y_forcada(n+3) = (-2.470.*(1.^n) + (4.33.*(0.707)^(n) .* cos(2.523+1.367.*n))).*u(n) - (-2.470.*(1.^(n-11)) +(4.33.*(0.707)^(n-11) .* cos(2.523+1.367.*(n-11)))).*u(n-11);
end

subplot(4,1,3);
stem(percorrer, y_forcada);
title('Resposta forçada');
legend('y_{forçada}_{[n]}');
grid on;

y_completa = y_q2 + y_forcada;

subplot(4,1,4);
stem(percorrer, y_completa);
title('Resposta completa');
legend('y_{Resp}_{[n]}');
grid on;
%%
% Letra c)
transf = tf([-6 3 0], [1 -2/7 1/2], -1)
%%
% Letra d)
n=-2:29;
ys(1) = 4;
ys(2) = 10;

ys(3:32)=step(transf, n(3:32));
figure(2);
stem(n, ys);
title('Resposta ao degrau unitário');
grid on;

