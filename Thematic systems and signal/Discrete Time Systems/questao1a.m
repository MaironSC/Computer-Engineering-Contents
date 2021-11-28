interacao = 23;
y_q1=ones(size(interacao));
x=ones(size(interacao));

y_q1(1) = 4;
y_q1(2) = 10;

for n = 3:1:23
    x(n) = u(n-3) - u(n-14);
    y_q1(n) = 0.5*y_q1(n-1) - 2/7*y_q1(n-2) + 5*x(n-1) - 3*x(n);
end

percorrer = -2:1:20;
subplot(1,1,1);
stem(percorrer, y_q1);
title('Resposta completa calculada através da forma recursiva');
legend('y_{[n]}');
fprintf('Valor = %i\n', y_q1);
grid on;
