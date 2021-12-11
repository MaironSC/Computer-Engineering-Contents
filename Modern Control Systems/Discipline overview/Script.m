%% Cálculo da função de transferência da planta
syms s;
A = (1/10+1/10+1/(5*s) + 0.1*s);
B = s/5 - 1/(5*s) - 1/10;
C = 1/10;
D = 1/(5*s) + 1/10;
E = 1/(5*s) + 1/(1/(2*s) + 11) + 2/15;
F = (1/(2*s) + 10)/(1/(2*s) + 11);
G = (C*F)/(((A*E)/D) + B);
simplify(G)
%% Bode da planta G(s)
s = tf('s');
k = 1;
G = (60*s^2 + 123*s + 6)/(280*s^3 + 636*s^2 + 319*s + 8);
bode(G);
grid on;
%% Comparação Proporcional-integrativo <-> Proporcional - Esforço
s = tf('s');
k = 2700;
G = (60*s^2 + 123*s + 6)/(280*s^3 + 636*s^2 + 319*s + 8);
C = k
T = feedback(G*C, 1)
Potencia = feedback(C,G); step(Potencia);legend('Esforço proporcional');
grid on;
figure ();
Ti = 1;
k=1;
C = k*(1+(1/(Ti*s)));
T = feedback(G*C, 1)
Potencia = feedback(C,G); step(Potencia);legend('Esforço proporcional integrativo');
grid on;


%%
s = tf('s');
SYS = (60*s^2 + 123*s + 6)/(280*s^3 + 636*s^2 + 319*s + 8);
[Y,time] = step(SYS);
K = Y(end);                              % Index Of Maximumy

L_index = find(Y>=.05*K,1);
L = time(L_index);
T_index = find(Y>=(1-exp(-1))*K,1);
T = time(T_index);

D = diff(Y)./diff(time);
inflex = find(diff(D)./diff(time(1:end-1))<0,1);
A = D(inflex)*time(inflex)-Y(inflex);
tangent = D(inflex)*time - A;
step(SYS), hold on, plot(time,tangent), plot(L,Y(L_index),'*'), plot(T,Y(T_index),'*'), legend('Extração dos parâmetros através do método da resposta ao salto');
%% Ziegler-Nichols
G = (60*s^2 + 123*s + 6)/(280*s^3 + 636*s^2 + 319*s + 8);
Ti = 3*L

Kp = 0.9/0.004
Ki = Kp/Ti

Gc = pid(Kp, Ki)

Sys = feedback(G*Gc, 1);
figure();
step(Sys);
grid
title('Resposta ao degrau (Ziegler-Nichols).');
%%
% ESFORÇO DE CONTROLE
Potencia2 = feedback(G,Gc);
figure();
step(Potencia2); hold on; legend('Esforço do sistema com G(s)');
grid on;

% REJEIÇÃO
Q2_SC = feedback(1,series(G,Gc));
figure();
step(Q2_SC, 0:0.001:6);
grid on;
legend('Rejeição do sistema com G(s)');


%% Critério de Routh Hurwitz
syms k s
%q = 280*s^4 + (636+60*k)*s^3 + (319+183*k)*s^2 + (8+126*k)*s + 6*k

% s4|280|319+183*k |6*k
% s3|636+60*k|8+126*k   | 0
% s2|b1  | b2            | 0
% s1|c1  | 0              | 0
% s0|d1  | 0              | 0

a0 =280;
a1 = 636+(60*k);
a2 = 319+(183*k)
a3 = 8+(126*k)
a4 = 6*k;
a5 = 0;

b1 = (a1*a2 - a0*a3)/a1 %   k>-53,936
b2 = (a1*a4 - a0*a5)/a1
b3 = 0;
c1 = (b1*a3 - a1*b2)/b1 % k>-48.62, k>-0.07
c2 = 0;
d1 = (c1*b2 - b1*c2)/c1 % k>0
d2 = 0;



