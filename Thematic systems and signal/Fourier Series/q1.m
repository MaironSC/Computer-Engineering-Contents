clc; clear;
t = -20:0.001:20;
figure(1);
x_primeiro = t.*(u(t) - u(t-2)); 
subplot(4,1,1); plot(t,x_primeiro); l = legend('x1 (Primeira componente)'); title('x1 = t*(u(t) - u(t-2))'); grid on;
x_segundo = ((t).*(u(t-2)-u(t-4))); 
subplot(4,1,2); plot(t, x_segundo); l = legend('x2 (Segunda componente)'); title('x2 = t*(u(t-2)-u(t-4))'); grid on;
x_terceiro = 4*(u(t-2)-u(t-4)); 
subplot(4,1,3); plot(t, x_terceiro); l = legend('x3 (Terceira componente)'); title('x3 = 4*(u(t-2)-u(t-4))'); grid on;
x = x_primeiro - x_segundo + x_terceiro; 
subplot(4,1,4);  plot(t, x); l = legend('x (Somas das componentes)'); title('x = x1 - x2 + x3'); grid on;

figure (2)
for limit=[5 11 21 51]
    y=zeros(1, length(t));
    for k=-1*limit:limit
          y = y + (func1(k)*exp(1i*k*(pi/2).*t));
    end
    hold on; 
    plot(t,y);
    legend('k=-5:5', 'k=-11:11', 'k=-10:10', 'k=-100:100');
end
l = title('$\sum a_k e^{jk(\pi/2)}$'); grid on; set(l, 'interpreter', 'latex', 'FontSize', 16)

%% Integrais
syms t k 
ak1 = int(t*exp(-1i*t*k*(pi/2)), t, 0, 2);
ak2 = int((t)*exp(-1i*t*k*(pi/2)), t, 2, 4);
ak3 = int((4)*exp(-1i*t*k*(pi/2)), t, 2, 4);
ak  = 1/4*(ak1-ak2+ak3)
%%
FourierDsc = zeros(1, length(t));
k=-15:15;

for n=1:length(k) 
       FourierDsc(n) =(func1(k(n)));
end
figure(3);
subplot(2,1,1)
stem(k, abs(FourierDsc)); grid on;  l = legend('$|a_k|$');title('Módulo'), set(l, 'interpreter', 'latex', 'FontSize', 16); 
subplot(2,1,2); 
stem(k, angle(FourierDsc)*(180/pi));grid on;l = legend('$\theta = arctg(\frac{b}{a})$');title('Fase'); set(l, 'interpreter', 'latex', 'FontSize', 16); 




