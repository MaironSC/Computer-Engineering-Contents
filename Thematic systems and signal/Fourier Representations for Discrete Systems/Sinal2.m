clc;clear
interacao = -15:16;
x=zeros(size(interacao));

x(17) = 1;x(18) = 7; x(19) = 1; x(20) = 0; x(21) = 2; x(22) = 5; x(23) = 1; x(24) = 5; 

percorrer=-15:16;
subplot(3,1,1);stem(percorrer,x); title('x[n]');xlabel('n');
xlim([-16, 17]);
ylim([0, 7]);
grid on;

k = -15:0.01:16;
X = (exp(-1i*k*pi/4) + 7*exp(2*-1i*k*pi/4) + exp(3*-1i*k*pi/4)+2*exp(5*-1i*k*pi/4)+5*exp(6*-1i*k*pi/4)+exp(7*-1i*k*pi/4)+5*exp(8*-1i*k*pi/4));

% c)Plote os diagramas de modulo e fase da representação de Fourier deste sinal.
subplot(3,1,2);plot(k, abs(X)); title('|X(e^{(j\Omega)})|'); grid on; xlim([-15, 16]);
subplot(3,1,3);plot(k, angle(X)*(180/pi));title('\angle X(e^{(j\Omega)})'); grid on; ylabel('Graus');xlim([-15, 16]);

t = -15:0.01:16;
n=-15:16;
x_reconstruido = (x(1:length(interacao))*sinc(t-(n')));

figure (2);
plot(t, x_reconstruido); grid on; title('Sinal reconstruído');
xlim([-16, 17]);
ylim([-1.6, 7.5]);
