%% PLANTA DO PRIMEIRO TRABALHO, COM GANHO (K) DE 1.2
clc;clear;
s = tf('s');
G = -10*((s+10)/((s+4.0825)*(s-4.0825)));
bode(G); grid on; title('Resposta em frequência do sistema G(s)')
figure;
pzmap(G); title('Mapa de polos e zeros do sistema G(s)')
figure;
step(G); grid on; title('Resposta ao degrau do sistema G(s)')


%% PARTE 1
s = tf('s');
k=0.8;
G_1 = -k*(5*s+50)/(0.6*s^2+6*s-5*k*s-50*k+50);
bode(G_1); grid on; title('Resposta em frequência do sistema G1(s)')
figure;
pzmap(G_1); title('Mapa de polos e zeros do sistema G1(s)')

figure;
step(G_1); hold on; grid on; title('Resposta ao degrau do sistema G1(s)')

k=0.9;
G_1 = -k*(5*s+50)/(0.6*s^2+6*s-5*k*s-50*k+50);
step(G_1); hold on;

k=0.95;
G_1 = -k*(5*s+50)/(0.6*s^2+6*s-5*k*s-50*k+50);
step(G_1); hold on;

legend('k = 0,8', 'k = 0,9', 'k=0,95');


%% PARTE 2  -- Deslocado -1.5 
clc;clear;
s = tf('s'); 
k=-0.5087; % -0,45>k>-0,5088
T = (-6*k*s^2-66*k*s-60*k)/(0.6*s^3 -10*s-6*k*s^2-66*k*s-60*k);
bode(T); grid on; title('Resposta em frequência do sistema T(s)')
figure;
pzmap(T); title('Mapa de polos e zeros do sistema T(s)')
figure;
step(T); grid on; hold on; title('Resposta ao degrau do sistema T(s)')
k = -0.46; T = (-6*k*s^2-66*k*s-60*k)/(0.6*s^3 -10*s-6*k*s^2-66*k*s-60*k);
step(T); grid on; hold on;
k = -0.49; T = (-6*k*s^2-66*k*s-60*k)/(0.6*s^3 -10*s-6*k*s^2-66*k*s-60*k);
step(T); grid on;

legend('k = -0,5087', 'k = -0,46', 'k = -0,49');