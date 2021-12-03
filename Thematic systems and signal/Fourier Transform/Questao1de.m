%%
clc;clear;
%Questão 1d) e 1)e
w = -10:0.01:10;

integ1_par = 4.*sinc(2.*w/pi).*exp(1i.*w.*4)+12.*sinc(2.*w/pi) -2.*sinc(w/pi).*exp(-1i.*w*3);
integ2_par =(4*(sinc(((w-2*pi)*2)/pi) - sinc(((w+2*pi)*2)/pi))/1i);
integ3_par = (4*(sinc(((w-2*pi)*2)/pi) - sinc(((w+2*pi)*2)/pi))/1i).*exp(2*1i.*w);

integral_Sinal1 = (4.*exp(1i.*4.*w).*sin(w).*cos(w))./w + (12.*sin(w).*cos(w))./w -(2.*exp(-1i*3.*w).*sin(w))./w; 
integral_Sinal2 = (pi*sin(2.*w)*8i)./(- w.^2 + 4*pi.^2); 
integral_Sinal3 = (4.*pi.*(exp(w.*4i) - 1))./(- w.^2 + 4.*pi^2); 

subplot(3,1,1); plot(w, abs(integral_Sinal1), 'Color', 'k'); grid on; hold on;
plot(w,abs(integ1_par), '--', 'Color', 'r');
l = legend('Calculado através da integral', 'Calculado através dos pares básicos e propriedades da transformada de Fourier');
ylabel('| X(\omega) |')


subplot(3,1,2); plot(w, abs(integral_Sinal2), 'Color', 'k'); grid on;  hold on;
plot(w, abs(integ2_par), '--', 'Color', 'r'); 
l = legend('Calculado através da integral', 'Calculado através dos pares básicos e propriedades da transformada de Fourier');
ylabel('| X(\omega) |')
ylim([0 6])

subplot(3,1,3); plot(w, abs(integral_Sinal3), 'Color', 'k'); grid on; hold on;
plot(w, abs(integ3_par), '--', 'Color', 'r'); 
l = legend('Calculado através da integral', 'Calculado através dos pares básicos e propriedades da transformada de Fourier');
ylabel('| X(\omega) |')
ylim([0 6])

%%
clc; clear
figure(2);
w = -10:0.01:10;

integ1_par = 4.*sinc(2.*w/pi).*exp(1i.*w.*4)+12.*sinc(2.*w/pi) -2.*sinc(w/pi).*exp(-1i.*w*3);
integ2_par =(4*(sinc(((w-2*pi)*2)/pi) - sinc(((w+2*pi)*2)/pi))/1i);
integ3_par = (4*(sinc(((w-2*pi)*2)/pi) - sinc(((w+2*pi)*2)/pi))/1i).*exp(2*1i.*w);

integral_Sinal1 =(6.*sin(2.*w))./w - (2.*exp(-w.*3i).*sin(w))./w + (2.*sin(2.*w).*(sin(4.*w).*1i - 2.*sin(2.*w).^2 + 1))./w;
integral_Sinal2 = (pi*sin(2.*w)*8i)./(- w.^2 + 4*pi.^2);
integral_Sinal3 = (4.*pi.*(exp(w.*4i) - 1))./(- w.^2 + 4.*pi^2);

subplot(3,1,1); plot(w, angle(integral_Sinal1), 'Color', 'k'); grid on;  hold on;
plot(w, angle(integ1_par), '--', 'Color', 'r');
l = legend('Calculado através da integral', 'Calculado através dos pares básicos e propriedades da transformada de Fourier');
l.FontSize = 8;
ylabel('\angle X(\omega)')
ylim([-4 5.5])

subplot(3,1,2); plot(w, angle(integral_Sinal2), 'Color', 'k'); grid on; hold on;
plot(w, angle(integ2_par), '--', 'Color', 'r'); 
l = legend('Calculado através da integral', 'Calculado através dos pares básicos e propriedades da transformada de Fourier');
l.FontSize = 8;
ylabel('\angle X(\omega)')
ylim([-2 3.5])

subplot(3,1,3); plot(w, angle(integral_Sinal3), 'Color', 'k'); grid on; hold on;
plot(w, angle(integ3_par), '--', 'Color', 'r'); 
l = legend('Calculado através da integral', 'Calculado através dos pares básicos e propriedades da transformada de Fourier');
l.FontSize = 8;
ylim([-4 5.5])

ylabel('\angle X(\omega)')
