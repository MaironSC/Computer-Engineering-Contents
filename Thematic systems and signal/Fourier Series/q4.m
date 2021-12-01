clc; clear;
t = -10:0.001:10;
figure(1);
x_primeiro = u(t-0.25) - u(t-1.75); subplot(3,1,1); plot(t,x_primeiro); grid on;  l = legend('x1 (Primeira componente)'); title('x1 = u(t-0.25) - u(t-1.75)');
x_segundo = u(t-0.75) - u(t-1.25); subplot(3,1,2); plot(t,x_segundo); grid on;  l = legend('x2 (Primeira componente)'); title('x2 = u(t-0.75) - u(t-1.25)');
x_terceiro = x_primeiro+x_segundo; subplot(3,1,3); plot(t,x_terceiro); grid on; l = legend('x3 (Somas das componente)'); title('x = x1 + x2');

figure(2);
t = -10:0.001:10;
for limit=[5 11 21 51]
    y=zeros(1, length(t));
    for k=-1*limit:limit
        y = y + (func4(k)*exp(1i*k*(pi).*t));
    end
    hold on; 
    plot(t,y);
    legend('k=-5:5', 'k=-11:11', 'k=-10:10', 'k=-100:100');
end
l = title('$\sum a_k e^{jk(\pi)}$'); grid on; set(l, 'interpreter', 'latex', 'FontSize', 16)
%%
syms t k 
ak1 = int(1*exp(-1i*t*k*(pi)), t, 0.25, 1.75);
ak2 = int(1*exp(-1i*t*k*(pi)), t, 0.75, 1.25);
ak3  = 1/2*(ak1+ak2)
%%
FourierDsc = zeros(1, length(t));
k=-15:15;

for n=1:length(k) 
       FourierDsc(n) =(func4(k(n)));
end
figure(3);
subplot(2,1,1)
stem(k, abs(FourierDsc)); grid on;  l = legend('$|a_k|$');title('Módulo'), set(l, 'interpreter', 'latex', 'FontSize', 16); 
subplot(2,1,2); 
stem(k, angle(FourierDsc)*(180/pi));grid on;l = legend('$\theta = arctg(\frac{b}{a})$');title('Fase'); set(l, 'interpreter', 'latex', 'FontSize', 16); 
