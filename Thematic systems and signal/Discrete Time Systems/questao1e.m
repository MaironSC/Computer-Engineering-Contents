interacao = 23;
y_nat=ones(size(interacao));
y_nat(1) = 4; %y[-2]
y_nat(2) = 10; %y[-1]

for n = 0:1:20
    y_nat(n+3) = 5.56.*0.534^n.*cos(1.083*n+0.804);
end

percorrer = -2:1:20;
subplot(1,1,1)
stem(percorrer, y_nat);
legend('y_{natural}[n]');
title('Resposta natural');
grid on;