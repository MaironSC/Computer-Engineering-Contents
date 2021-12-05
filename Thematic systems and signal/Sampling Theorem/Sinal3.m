t=-20:0.01:20;
x3 = (sin(2*pi*t)+1).*exp(-1*abs(t));
figure(1);
plot(t, x3);
grid on; title('Sinal no domínio tempo'); legend('x3(t) = (sin(2*pi*t)+1)*exp(-1*abs(t))');

%% Representação de Fourier
figure(2);

w=-20:0.01:20;
x3 = (1/2*1i).*((2./(1.^2+(w+2.*pi).^2)) + (-2./(1.^2+(w-2.*pi).^2))) + (2./(1.^2+(w).^2));

subplot(3,1,1); plot(w, x3);  title('Representação de Fourier do sinal'); grid on;
subplot(3,1,2); plot(w,abs(x3)); ylabel('| X(\omega) |'); legend('x_3(j\omega) =  |(1/2*1i).*((2./(1.^2+(w+2.*pi).^2)) + (-2./(1.^2+(w-2.*pi).^2))) + (2./(1.^2+(w).^2))|'); title('Representação do modulo do sinal') ; grid on;
subplot(3,1,3); plot(w,angle(x3)); ylabel('\angle X(\omega)');title('Representação da fase do sinal'); grid on;

%%
clc;clear;
figure(3);
tMax = 20;
tMin = -20;
fc = 1;
Ts = 1/fc;
Passo = 0.01;

n_amostrado = (tMin*fc):(tMax*fc);

t = tMin: Passo: tMax;
x3 = (sin(2*pi*t)+1).*exp(-1*abs(t));
subplot(3,1,1); plot(t,x3); grid on; title('Sinal original'); legend('x3(t) = (sin(2*pi*t)+1)*exp(-1*abs(t))'); hold on;

x3 = (sin(2*pi*n_amostrado*Ts)+1).*exp(-1*abs(n_amostrado*Ts));
subplot (3,1,2); stem(n_amostrado,x3); grid on;  title('Sinal amostrado com frequência 3Hz'); hold on;
subplot (3,1,3); stairs(n_amostrado,x3); grid on; title('Sinal reconstruído'); hold on;

filtro_passaBaixa = 2*fc*sinc(t*fc*2); %Pulso retangular na frequência, transformado via par básico.
x3 = (sin(2*pi*t)+1).*exp(-1*abs(t));

n_amostrado = (tMin*fc):(tMax*fc);
tMin_func = 1 - 1*(tMin/Passo); %Garante que tenha positive integers

sinal_rec = (conv(x3, filtro_passaBaixa));
sinal_filtrado = sinal_rec(tMin_func:tMin_func + (length(t) - 1))*Passo;
x_smpls = sinal_filtrado(round((n_amostrado*Ts - tMin)/Passo) + 1);

subplot(3, 1, 1)
plot(t, sinal_filtrado(1:length(t)));legend('Sem filtro anti-aliasing','Com filtro anti-aliasing'); xlim([-20 20])
subplot(3, 1, 2)
stem(n_amostrado, x_smpls);legend('Sem filtro anti-aliasing','Com filtro anti-aliasing');xlim([-20 20])
subplot(3, 1, 3)
stairs(n_amostrado, x_smpls); legend('Sem filtro anti-aliasing','Com filtro anti-aliasing');xlim([-20 20])


