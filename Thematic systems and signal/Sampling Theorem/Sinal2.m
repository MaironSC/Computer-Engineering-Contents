t=-20:0.01:20;
x2 = sin(t).*cos(t/2);
figure(1);
plot(t,x2); title('Sinal no domínio tempo'); legend('x2(t) = sin(t)*cos(t/2)'); grid on;
grid on;

%% d) i. Taxa de amostragem de Nyquist 2*1/(1+0.5)

%for n=tMin:1:tMax5 -> Reconstrução ideal
 %   x_final = x_final +x[n].*exp(-1*abs(n*Ts))) .* sinc((3).*(t - (n*Ts))));
%end

figure(2);
tMax = 20;
tMin = -20;
Ts = ((2*pi)/3);

t=-20:0.01:20;
x2 =  sin(t).*cos(t/2);
subplot(3,1,1); plot(t,x2); grid on; title('Sinal original'); legend('x2(t) = sin(t)*cos(t/2)');

n = tMin:Ts:tMax;
x2 = sin(n).*cos(n/2);
subplot (3,1,2); stem(n,x2); grid on; title('Sinal amostrado com frequência f_s(1/Ts)'); legend('x2[n] = sin(n)*cos(n/2)');
subplot (3,1,3); stairs(n,x2); grid on; title('Sinal reconstruído'); legend('stairs(x2[n])')

%% d)Frequência de amostragem igual a 2fsn
figure(3);
tMax = 20;
tMin = -20;
Ts = (pi/3); 

t=-20:0.01:20;
x2 =  sin(t).*cos(t/2);
subplot(3,1,1); plot(t,x2); grid on; title('Sinal original'); legend('x2(t) = sin(t)*cos(t/2)');

n = tMin:Ts:tMax;
x2 = sin(n).*cos(n/2);
subplot (3,1,2); stem(n,x2); grid on;  title('Sinal amostrado com frequência 2f_s(1/2Ts)'); legend('x2[n] = sin(n)*cos(n/2) ');
subplot (3,1,3); stairs(n,x2); grid on; title('Sinal reconstruído'); legend('stairs(x2[n])')
