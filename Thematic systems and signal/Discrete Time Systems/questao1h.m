interacao = 20;
percorrer = -2:1:20;
h = ones(size(interacao));
h(1) = 0;
h(2) = 0;

%Interações menores, logo, não é preciso deslocar no tempo como no último
%exercício.
for n=0:1:(interacao)
   h(n+3)=(2.545 + 5.724.*(0.534^n.*(cos(1.083.*n + 2.893)))) - (2.545 + 5.724.*0.534.^(n-1).*(cos(1.083.*(n-1) + 2.893)));
end

subplot(1,1,1)
stem(percorrer, h);
title('h[n]');
legend('h[n]=s[n]-s[n-1]');
grid on;