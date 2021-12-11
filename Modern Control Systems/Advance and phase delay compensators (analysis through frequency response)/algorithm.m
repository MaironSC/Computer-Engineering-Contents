%% Diferenças do sistema com o compensador.
s = tf('s');
H = -10*((s+10)/((s+4.0825)*(s-4.0825)));
k = -0.5; % 
C = k*(1/s+1);

%%% PARÂMETROS DO COMPENSADOR %%%
defphase = 28.1;
freq_ganho = 10.1;
alpha = (sind(defphase)+1)/(-sind(defphase)+1);
tau = 1/(freq_ganho*sqrt(alpha));
G = (alpha*tau*s + 1)/(tau*s+1)
freq1 = 1/(alpha*tau);
freq2 = 1/tau;
%%% PARÂMETROS DO COMPENSADOR %%%

figure();
bode(G);legend('G(s)');grid on;
figure();
bode(C*H); hold on; grid on;
bode(C*G*H); legend('C(s)*H(s)','C(s)*H(s)*G(s)');

%%% ESFORÇO DE CONTROLE
Potencia = feedback(C*G,H);
Potencia2 = feedback(C,H);
figure();
step(Potencia); hold on;
step(Potencia2);
legend('Esforço do sistema realimentado com G(s)', 'Esforço do sistema realimentado sem G(s)');grid on;

%%% REJEIÇÃO
Q2 = feedback(1,series(C*G,H));
Q2_SC = feedback(1,series(C,H));
figure();
step(Q2, 0:0.001:6); hold on;
step(Q2_SC, 0:0.001:6);
grid on;
legend('Rejeição do sistema com G(s)', 'Rejeição do sistema sem G(s)');

%%% STEP RESPONSE
figure();
T = feedback(G*C*H, 1);
T2 = feedback(C*H, 1);
step(T); hold on;
step(T2); grid on;
legend('Resposta ao degrau do sistema com G(s)', 'Resposta ao degrau do sistema sem G(s)');

% ENTRADA R(S) = RAMPA
figure();
y = step((1/s)*T2, 0:0.01:30);
y1 = step((1/s)*T, 0:0.01:30);
r = step(1/s, 0:0.01:30);
plot(0:0.01:30, y-r); hold on;
plot(0:0.01:30, y1-r);
legend('Erro de regime permanente para R(s) = 1/s^2 sem G(s)', 'Erro de regime permanente para R(s) = 1/s^2 com G(s)'); 

figure();
plot(y, 0:0.01:30); hold on;
plot(y1, 0:0.01:30); hold on;
plot(r, 0:0.01:30);
legend('Comparação do comportamento do sistema para R(s) = 1/s^2 sem G(s)', 'Comparação do comportamento do sistema para R(s) = 1/s^2 com G(s)','R(s)'); 

%% Comparação que tanta igualar o BW a 10.1 modificando o k
clc;clear;
s = tf('s');
H = -10*((s+10)/((s+4.0825)*(s-4.0825)));
k = -0.5;
k1 = -0.83;

C = k*(1/s+1);
C1 = k1*(1/s+1);

%%% PARÂMETROS DO COMPENSADOR %%%
defphase = 28.1;
freq_ganho = 10.1;
alpha = (sind(defphase)+1)/(-sind(defphase)+1);
tau = 1/(freq_ganho*sqrt(alpha));
G = (alpha*tau*s + 1)/(tau*s+1);
%%% PARÂMETROS DO COMPENSADOR %%%

figure();
bode(C1*H); hold on; grid on;
bode(C*G*H); legend('C1(s)*H(s)','C(s)*H(s)*G(s)');

%%% ESFORÇO DE CONTROLE
Potencia = feedback(C*G,H);
Potencia2 = feedback(C1,H);
figure();
step(Potencia); hold on;
step(Potencia2);
legend('Esforço do sistema realimentado com G(s)', 'Esforço do sistema realimentado sem G(s)');grid on;

%%% REJEIÇÃO
Q2 = feedback(1,series(C*G,H));
Q2_SC = feedback(1,series(C1,H));
figure();
step(Q2, 0:0.001:6); hold on;
step(Q2_SC, 0:0.001:6);
grid on;
legend('Rejeição do sistema com G(s)', 'Rejeição do sistema sem G(s)');

%%% STEP RESPONSE
figure();
T = feedback(G*C*H, 1);
T2 = feedback(C1*H, 1);
step(T); hold on;
step(T2); grid on;
legend('Resposta ao degrau do sistema com G(s)', 'Resposta ao degrau do sistema sem G(s)');

% ENTRADA R(S) = RAMPA
figure();
y = step((1/s)*T2, 0:0.01:30);
y1 = step((1/s)*T, 0:0.01:30);
r = step(1/s, 0:0.01:30);
plot(0:0.01:30, y-r); hold on;
plot(0:0.01:30, y1-r);
legend('Erro de regime permanente para R(s) = 1/s^2 sem G(s)', 'Erro de regime permanente para R(s) = 1/s^2 com G(s)'); 

figure();
plot(y, 0:0.01:30); hold on;
plot(y1, 0:0.01:30); hold on;
plot(r, 0:0.01:30);
legend('Comparação do comportamento do sistema para R(s) = 1/s^2 sem G(s)', 'Comparação do comportamento do sistema para R(s) = 1/s^2 com G(s)','R(s)'); 

