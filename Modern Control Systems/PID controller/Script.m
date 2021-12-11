clc;clear
s = tf('s');
G = (s+10)/((s+1)*(s+5));
[y,t] = step(G,0:0.001:8);
h = mean(diff(t));
dy = gradient(y, h);                                            % Numerical Derivative
[~,idx] = max(dy);                                              % Index Of Maximumy

b = [t([idx-1,idx+1]) ones(2,1)] \ y([idx-1,idx+1]);            % Regression Line Around Maximum Derivative
tv = [-b(2)/b(1); (1-b(2))/b(1)];                               % Independent Variable Range For Tangent Line Plot
f = [t ones(size(t))] * b;                                      % Calculate Tangent Line

K =2; L = 0.021; T = 1.454-L; L/T;
figure(2)

plot(t, y)
xlabel('Tempo (segundos)')
hold on
plot(t, f,'--', 'Color', 'red');  
title('Resposta ao degrau da planta G(s)');
ylim([-0.1 2]);
plot(t(idx), y(idx), 'o','MarkerSize',6, 'MarkerEdgeColor','red', 'MarkerFaceColor',[1 .6 .6]);       
legend('Planta G(s)', 'Curva tangente', 'Ponto de inflexão');
grid
%% Ziegler-Nichols
figure();
% Gc(s) = Kp(1 + 1/Tis + Tds)
A = K*(L/T);
Ti = 2*L
Td = L/2

Kp = 1.2/A
Ki = Kp/Ti
Kd = Kp*Td

Gc = pid(Kp, Ki, Kd)

Sys = feedback(G*Gc, 1);
step(Sys)
title('Resposta ao degrau (ajuste de parâmetros através da tabela Ziegler-Nichols)');
grid
figure();
Q2 = feedback(1,series(Gc,G)); 
step(Q2, 0:0.001:6); 
title('Perturbação do tipo degrau na saída (ajuste de parâmetros através da tabela Ziegler-Nichols)');
grid
%%  Chien, Hrones e Reswick
% Sobrepasso de 0% -> Referência
A = K*(L/T);
Ti = T
Td = L/2

Kp = 0.6/A
Ki = Kp/Ti
Kd = Kp*Td

Gc = pid(Kp, Ki, Kd);

Sys = feedback(G*Gc, 1);
step(Sys);
grid
title('Resposta ao degrau (ajuste de parâmetros através da tabela Chien, Hrones e Reswick). Otimização da resposta à referência. Sobrepasso de 0%.');
figure();
Q2 = feedback(1,series(Gc,G)); 
step(Q2, 0:0.001:6);
grid
title('Perturbação do tipo degrau na saída (ajuste de parâmetros através da tabela Chien, Hrones e Reswick). Otimização da resposta à referência. Sobrepasso de 0%.');
%%
% Sobrepasso de 20% -> Referência
A = K*(L/T)
Ti = 1.4*T
Td = 0.47*L

Kp = 0.95/A
Ki = Kp/Ti
Kd = Kp*Td

Gc = pid(Kp, Ki, Kd);

Sys = feedback(G*Gc, 1);
step(Sys);
grid
title('Resposta ao degrau (ajuste de parâmetros através da tabela Chien, Hrones e Reswick). Otimização da resposta à referência. Sobrepasso de 20%.');
figure();
Q2 = feedback(1,series(Gc,G)); 
step(Q2, 0:0.001:6); 
grid
title('Perturbação do tipo degrau na saída (ajuste de parâmetros através da tabela Chien, Hrones e Reswick). Otimização da resposta à referência. Sobrepasso de 20%.');
%%
%Sobrepasso de 0% -> Perturbação
A = K*(L/T);
Ti = 2.4*L
Td = 0.42*L

Kp = 0.95/A
Ki = Kp/Ti
Kd = Kp*Td

Gc = pid(Kp, Ki, Kd);

Sys = feedback(G*Gc, 1);
step(Sys);
grid
title('Resposta ao degrau (ajuste de parâmetros através da tabela Chien, Hrones e Reswick). Otimização da resposta à perturbação. Sobrepasso de 0%.');
figure();
Q2 = feedback(1,series(Gc,G)); 
step(Q2, 0:0.001:6); 
grid
title('Perturbação do tipo degrau na saída (ajuste de parâmetros através da tabela Chien, Hrones e Reswick). Otimização da resposta à perturbação. Sobrepasso de 0%.');
%%
%Sobrepasso de 20% -> Perturbação
A = K*(L/T);
Ti = 2*L
Td = 0.42*L

Kp = 1.2/A
Ki = Kp/Ti
Kd = Kp*Td

Gc = pid(Kp, Ki, Kd);

Sys = feedback(G*Gc, 1);
step(Sys);
grid
title('Resposta ao degrau (ajuste de parâmetros através da tabela Chien, Hrones e Reswick). Otimização da resposta à perturbação. Sobrepasso de 20%.');
figure();
Q2 = feedback(1,series(Gc,G)); 
step(Q2, 0:0.001:6);
grid
title('Perturbação do tipo degrau na saída (ajuste de parâmetros através da tabela Chien, Hrones e Reswick). Otimização da resposta à perturbação. Sobrepasso de 20%.');

%% Questão 3
% Gc(s) = Kp(1 + 1/Tis + Tds)
s = tf('s');
G = (s+20)/((s+4)*(s+2)*(s+6));
figure;
rlocus(G)
title('Lugar das raízes do sistema.');
K_c = 60;

Sys = feedback(G*K_c, 1)
figure;
step(Sys);
grid;
title('Extração do período do sistema no ponto crítico.');
T_c = 0.6; %Periodo das ondas

Ti = 0.5*T_c;
Td = 0.125*T_c;
K = 0.6*K_c;

Kp = K;
Ki = Kp/Ti;
Kd = Kp*Td;

Gc = pid(Kp, Ki, Kd);

T = feedback(G*Gc, 1);
figure;
step(T);
grid
title('Resposta ao degrau (ajuste de parâmetros através do método do ponto crítico).');
figure;
Q2 = feedback(1,series(Gc,G)); 
step(Q2, 0:0.001:6);
title('Perturbação do tipo degrau na saída (ajuste de parâmetros através do método do ponto crítico');


%% Parte 2) Exercio 2a)
s = tf('s');
G = feedback((0.022612*(s+1.006))/((s^2 + 1.108*s + 0.3109)*(s^2 + 0.4844*s + 0.08009)), 1);

[y,t] = step(G,0:0.001:20);
h = mean(diff(t));
dy = gradient(y, h);                                            % Numerical Derivative
[~,idx] = max(dy);                                              % Index Of Maximumy

b = [t([idx-1,idx+1]) ones(2,1)] \ y([idx-1,idx+1]);            % Regression Line Around Maximum Derivative
tv = [-b(2)/b(1); (1-b(2))/b(1)];                               % Independent Variable Range For Tangent Line Plot
f = [t ones(size(t))] * b;                                      % Calculate Tangent Line

K =0.47774; L = 2.571; T = 8.618-L; L/T;
figure(2)

plot(t, y)
xlabel('Tempo (segundos)')
hold on
plot(t, f,'--', 'Color', 'red');  
title('Resposta ao degrau da planta G(s)');

plot(t(idx), y(idx), 'o','MarkerSize',6, 'MarkerEdgeColor','red', 'MarkerFaceColor',[1 .6 .6]);       
legend('Planta G(s)', 'Curva tangente', 'Ponto de inflexão');
grid
%%
% Sobrepasso de 0% -> Referência
s = tf('s');
A = K*(L/T);
Ti = T
Td = L/2

Kp = 0.6/A
Ki = Kp/Ti
Kd = Kp*Td

Gc = pid(Kp, Ki, Kd);

Sys = feedback(G*Gc, 1);
step(Sys);
grid
title('Resposta ao degrau (ajuste de parâmetros através da tabela Chien, Hrones e Reswick). Otimização da resposta à referência. Sobrepasso de 0%.');
figure();
Q2 = feedback(1,series(Gc,G)); 
step(Q2, 0:0.001:80);
grid
title('Perturbação do tipo degrau na saída (ajuste de parâmetros através da tabela Chien, Hrones e Reswick). Otimização da resposta à referência. Sobrepasso de 0%.');
%%
s = tf('s');
G = feedback((0.022612*(s+1.006))/((s^2 + 1.108*s + 0.3109)*(s^2 + 0.4844*s + 0.08009)), 1)
K_c = 5.100029;
rlocus(G*K_c)

Sys = feedback(G*K_c, 1)
figure;
step(Sys);
grid;
title('Extração do período do sistema no ponto crítico.');
T_c = 13; %Periodo das ondas

Ti = 0.5*T_c;
Td = 0.125*T_c;
K = 0.6*K_c;

Kp = K;
Ki = Kp/Ti;
Kd = Kp*Td;

Gc = pid(Kp, Ki, Kd);

T = feedback(G*Gc, 1);
figure;
step(T);
grid
title('Resposta ao degrau (ajuste de parâmetros através do método do ponto crítico).');
figure;
Q2 = feedback(1,series(Gc,G)); 
step(Q2, 0:0.001:6);
title('Perturbação do tipo degrau na saída (ajuste de parâmetros através do método do ponto crítico');

%% Parte 2) Exercio 2b)
s = tf('s');
G = (-13.768*(s+3.408)*(s-1))/((s+9.861)*(s+3.812)*(s^2 + 1.578*s + 3.239))
[y,t] = step(G,0:0.001:20);
h = mean(diff(t));
dy = gradient(y, h);                                            % Numerical Derivative
[~,idx] = max(dy);                                              % Index Of Maximumy

b = [t([idx-1,idx+1]) ones(2,1)] \ y([idx-1,idx+1]);            % Regression Line Around Maximum Derivative
tv = [-b(2)/b(1); (1-b(2))/b(1)];                               % Independent Variable Range For Tangent Line Plot
f = [t ones(size(t))] * b;                                      % Calculate Tangent Line

K =0.3845; L = 1.137; T = 1.703-L; L/T;
figure(2)

plot(t, y)
xlabel('Tempo (segundos)')
hold on
plot(t, f,'--', 'Color', 'red');  
title('Resposta ao degrau da planta G(s)');
ylim([-1 2]);
plot(t(idx), y(idx), 'o','MarkerSize',6, 'MarkerEdgeColor','red', 'MarkerFaceColor',[1 .6 .6]);       
legend('Planta G(s)', 'Curva tangente', 'Ponto de inflexão');
grid
%% Ziegler-Nichols
figure();
% Gc(s) = Kp(1 + 1/Tis + Tds)
A = K*(L/T);
Ti = 2*L
Td = L/2

Kp = 1.2/A
Ki = Kp/Ti
Kd = Kp*Td

Gc = pid(Kp, Ki, Kd)

Sys = feedback(G*Gc, 1);
step(Sys, 300:0.00001:500)
title('Resposta ao degrau (ajuste de parâmetros através da tabela Ziegler-Nichols)');
grid
figure();
Q2 = feedback(1,series(Gc,G)); 
step(Q2, 0:0.001:6); 
title('Perturbação do tipo degrau na saída (ajuste de parâmetros através da tabela Ziegler-Nichols)');
grid

%%
s = tf('s');
G = (-13.768*(s+3.408)*(s-1))/((s+9.861)*(s+3.812)*(s^2 + 1.578*s + 3.239))

figure;
rlocus(G, 0:00000.1: 1009)

title('Lugar das raízes do sistema.');
K_c = 1.180892;

Sys = feedback(G*K_c, 1)
figure;
step(Sys);

grid;
title('Extração do período do sistema no ponto crítico.');
T_c = 3.1; %Periodo das ondas

Ti = 0.5*T_c;
Td = 0.125*T_c;
K = 0.6*K_c;

Kp = K;
Ki = Kp/Ti;
Kd = Kp*Td;

Gc = pid(Kp, Ki, Kd);

T = feedback(G*Gc, 1);
figure;
step(T);
grid
title('Resposta ao degrau (ajuste de parâmetros através do método do ponto crítico).');
figure;
Q2 = feedback(1,series(Gc,G)); 
step(Q2, 0:0.001:6);
title('Perturbação do tipo degrau na saída (ajuste de parâmetros através do método do ponto crítico');

