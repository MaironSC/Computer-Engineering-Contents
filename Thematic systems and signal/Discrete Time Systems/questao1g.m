%yf[n] por recursão
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
subplot(6,1,1);
stem(percorrer, y_q1);
title('Resposta completa calculada através da forma recursiva');
legend('y_{[n]}');
fprintf('Valor = %i\n', y_q1);
grid on;

% s[n]
s = ones(size(interacao));
s(1) = 0;
s(2) = 0;

for n = 0:1:20
    s(n+3) = 5.724*(0.534^n)*cos(1.083*n + 2.893)+2.545;
end

percorrer = -2:1:20;
subplot(6,1,2);
stem(percorrer, s);
legend('s[n]');
title('y_{degrau} = s[n] = Resposta forçada a uma entrada degrau');
grid on;

%y_natural
interacao = 23;
y_nat=ones(size(interacao));
y_nat(1) = 4; %y[-2]
y_nat(2) = 10; %y[-1]

for n = 0:1:20
    y_nat(n+3) = 5.56.*0.534^n.*cos(1.083*n+0.804);
end

%Resposta s[n-11]
s11 = ones(size(interacao));
%Atribui 0 em 11 posições (s[n] -"11")
for i = 1:1:13
    s11(i) = 0;
end
%Atribui a função s[n] ao restante da resposta.
for i = 14:1:23
    s11(i)=s(i-11);
end

forc = s - s11;
% Resposta completa
comp = y_nat + forc;

subplot(6,1,3);
stem(percorrer,s11);
legend('s[n-11]');
title('Curva s[n] deslocada 11 unidades');
grid on;

subplot(6,1,4);
stem(percorrer,forc);
legend('y_f[n] = s[n] - s[n-11]');
title('Resposta forçada para uma entrada s[n] - s[n-11]');
grid on;

subplot(6,1,5);
stem(percorrer,y_nat);
legend('y_{natural}');
title('Resposta natural');
grid on;


subplot(6,1,6);
stem(percorrer,comp);
legend('y_{[n]}');
title('Resposta completa = y_{natural}[n] + y_f[n]');
grid on;

