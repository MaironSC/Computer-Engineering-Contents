%%Execute section por section

s = tf('s');
T = (6*s^2 + 66*s + 60)/(0.6*s^3+6*s^2+56*s+60);
figure();
pzmap(T); grid on;

%C = -1*(1+(1/s));
%H = (-6*s-60)/(0.6*s^2-10);
%M = feedback(series(C,H),+1);

figure();
step(T, 0:0.001:50); 

hold on;

k =-2;
T = k*(s+1)*(-6*s-60)/(s*(0.6*s^2 - 10) + (k*(s+1)*(-6*s-60)));
step(T, 0:0.001:3.1); hold on;

k = -5;
T = k*(s+1)*(-6*s-60)/(s*(0.6*s^2 - 10) + (k*(s+1)*(-6*s-60)));
step(T, 0:0.001:3.1); hold on; 

k=-10;
T = k*(s+1)*(-6*s-60)/(s*(0.6*s^2 - 10) + (k*(s+1)*(-6*s-60)));
step(T, 0:0.001:3.1); 
legend('k = -1', 'k = -2', 'k = -5', 'k = -10');

%% ERROS DE REGIME PERMANENTE
% ENTRADA R(S) = RAMPA
clc;clear;
s = tf('s');
T = (6*s^2 + 66*s + 60)/(0.6*s^3+6*s^2+56*s+60);
y = step((1/s)*T, 0:0.01:30);
r = step(1/s, 0:0.01:30);
plot(0:0.01:30, y-r);
legend('Erro de regime permanente para R(s) = 1/s^2'); 
figure();
plot(y, 0:0.01:30); hold on;
plot(r, 0:0.01:30);

legend('Comparação do comportamento do sistema para R(s)', 'R(s)'); 

%% Esforço
s = tf('s');
k = -1;
C = k*(1 + (1/s));
H = (-6*s - 60)/(0.6*s^2 - 10);

Potencia = feedback(C,H); step(Potencia);legend('Esforço');
figure ();
energia = cumsum(step(Potencia, 0:0.001:6));
plot(energia); hold on;


C = k;
Potencia = feedback(C,H);
energia = cumsum(step(Potencia, 0:0.001:6));
plot(energia); 
legend('Energia do controlador integrativo-proporcional','Energia controlador proporcional');
%% Rejeição

s = tf('s');
k = -1;
C = k*(1 + (1/s));
H = (-6*s - 60)/(0.6*s^2 - 10);
Q2 = feedback(1,series(C,H));
step(Q2, 0:0.001:6); hold on;

k = -2;
C = k*(1 + (1/s));
Q2 = feedback(1,series(C,H));
step(Q2, 0:0.001:6); hold on;

k = -5;
C = k*(1 + (1/s));
Q2 = feedback(1,series(C,H));
step(Q2, 0:0.001:6); hold on;

k = -10;
C = k*(1 + (1/s));
Q2 = feedback(1,series(C,H));
step(Q2, 0:0.001:6); hold on;
legend('k = -1', 'k = -2', 'k = -5', 'k = -10');





