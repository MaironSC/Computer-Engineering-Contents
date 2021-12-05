%%
t=-20:0.01:20;
x1 = (2*sinc((2.*t)/pi) + sinc(t/pi))/pi;
figure(1);
plot(t,x1); title('Sinal no domínio tempo'); legend('x1(t) = (2*sinc(2*t) + sinc(t/\pi))/\pi'); grid on;

%% Representação de Fourier.
clc;clear;
w= -10:0.001:10;
x1 = (u(w+2) - u(w-2)) + (u(w+1)-u(w-1));
figure(2);
subplot(2,1,1); plot(w,abs(x1)); ylabel('| X(\omega) |'); legend('x(j\omega) = |ret(w/4) + ret(w+2)|'); title('Representação de Fourier do sinal'); grid on;
subplot(2,1,2); plot(w,angle(x1)); ylabel('\angle X(\omega)');title('Representação da fase do sinal'); grid on;
%% d) i. Taxa de amostragem de Nyquist (wsn = 4rad/s). ws = 2rad/s;
% d) ii. Gere um sinal x_i[n] c/ frequência de amostragem igual a 4Rad/s.
% d) iii. Reconstrua o sinal utilizando um tetentor de ordem zero.
% fs = 1/Ts -- ws = 2*pi*fs = ws=2*pi*1/Ts                ->        |Ts = 2*pi/ws|
figure(3);
tMax = 20;
tMin = -20;
Ts = (pi)/2; 

%for n=tMin:1:tMax5 -> Reconstrução ideal
 %   x_final = x_final +x[n].*exp(-1*abs(n*Ts))) .* sinc((3).*(t - (n*Ts))));
%end

t=-20:0.01:20;
x1 = (2*sinc((2.*t)/pi) + sinc(t/pi))/pi;
subplot(3,1,1); plot(t,x1); grid on; title('Sinal original'); legend('x1(t) = (2*sinc(2*t) + sinc(t/\pi))/\pi');

n = tMin:Ts:tMax;
x1 = (2*sinc((2.*n)/pi) + sinc(n/pi))/pi;
subplot (3,1,2); stem(n,x1); grid on; title('Sinal amostrado com frequência f_s(1/Ts)'); legend('x1[n] = 2*sinc((2*n)/pi) + sinc(n/pi))/pi');
subplot (3,1,3); stairs(n,x1); grid on; title('Sinal reconstruído'); legend('stairs(x1[n])');


%% d)Frequência de amostragem igual a 2fsn

figure(4);
tMax = 20;
tMin = -20;
Ts = (pi)/4; 

t=-20:0.01:20;
x1 = (2*sinc((2.*t)/pi) + sinc(t/pi))/pi;
subplot(3,1,1); plot(t,x1); grid on; title('Sinal original'); legend('x1(t) = (2*sinc(2*t) + sinc(t/\pi))/\pi');

n = tMin:Ts:tMax;
x1 = (2*sinc((2.*n)/pi) + sinc(n/pi))/pi;

subplot (3,1,2); stem(n,x1); grid on; title('Sinal amostrado com frequência 2f_s(1/2Ts)'); legend('x1[n] = 2*sinc((2*n)/pi) + sinc(n/pi))/pi');
subplot (3,1,3); stairs(n,x1); grid on; title('Sinal reconstruído'); legend('stairs(x1[n])');
