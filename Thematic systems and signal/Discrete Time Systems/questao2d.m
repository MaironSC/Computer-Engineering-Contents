interacao = 20;
percorrer = -2:1:20;
h = ones(size(interacao));
h(1) = 0;
h(2) = 0;
x = ones(size(interacao));
x(1) = 0;
x(2) = 0;
%Tamanho gerado pela conv
novo_int = 0:1:44;

for n=0:1:(interacao)
    % h[n] = s[n] - s[n-1]  
   h(n+3)=(2.545 + 5.724.*(0.534^n.*(cos(1.083.*n + 2.893)))) - (2.545 + 5.724.*0.534.^(n-1).*(cos(1.083.*(n-1) + 2.893)));
   x(n+3) = cos(0.2*n).*u(n);
end

subplot(3,1,1)
stem(percorrer, h);
title('h[n]');
grid on;

subplot(3,1,2);
stem(percorrer,x);
title('x[n]');
grid on;

convolucao=conv(h,x);
subplot(3,1,3)
stem(novo_int, convolucao);
title('Convolução h[n] por x[n]');
grid on;
