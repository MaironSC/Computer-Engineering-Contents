%% • Gere um bitsream de 200 amostras aleatórias em um vetor. Cada amostra é composta de 2 bits

amostras = 200; %Número de amostras
bit = [0, 1];
bits = randi(bit, 1, 2*amostras);  % Cada amostra tem 2 bits

%% • Extração do período de transmissão através da obtenção da constante de tempo da resposta ao degrau do sistema.

num = 7.5*10^12;
den =[1  37*10^3  610*10^6  7.5*10^12];
H2 = tf(num, den);
l = 0:1e-6:1e-3;
step(H2, l)
grid on;

%% • Baseado na largura de banda do canal, defina o período transmissão. Defina o passo de simulação de
% forma a simular o sistema adequadamente;

% A justificativa para escolha desse Ts está contida na secção 
%                                               "Determinar Ts "
dt = 1e-6; % Passo
fs = (1/dt); % Freq de amostragem
Ts = 0.57e-3; % Período de transmissão

%% • Faça a transformada inversa da função de transferência do canal; 
% Alternativamente utilize o simulink com entrada from workspace, utilizando o sinal da forma de onda
% gerado anteriormente.

Ts = 0.57e-3;
[t, y]=Manchester(bits, Ts, dt);
h = (12400.*exp(-24597.*t) + 2*9341.1*exp(-6201.7.*t).*(cos(-16324.*t + 2.2966))).*u(t);

figure();
plot(t, h);
legend('h_2(t)')
title('Função em domínio tempo do canal h_2');
grid on;
xlim([0 1.5e-3])

% • Crie uma função que gere a forma de onda que representa o bitsream com a codificação de linha definida
%na especificação. A função poderá ter como entrada o bitsream, o período de transmissão e o passo de
%simulação, e como saída a forma de onda e o vetor de tempo associado a ela;

figure();
plot(t, y);
legend('Vetor de 200 amostras codificadas');
xlim([0 0.01])

% •Faça a convolução (conv()) entre a resposta ao impulso do canal e a forma de onda do sinal 
%codificado, para obter o sinal transmitido.

Convolucao = conv(h, y)*dt; %Faz a convolução entre o canal e a saida do bitstream codificado a um passo dt => Essa será a forma de onda transmitida
figure();
plot(t, Convolucao(1:length(t)));

title('Convolução entre a resposta ao impulso do canal e o bitstream codificado')
grid on;
xlim([0 0.01])

figure();
[f, M] = my_fft(Convolucao, fs);
plot(f, abs(M), 'Color', [1, 0, 0]); ylabel(['Magnitude da FFT']) ;xlabel(['Frequência (\omega)']); grid;
title('Comportamento em frequência da convolução entre bitstream e h_2(t)')
grid on;
xlim([-6.5e3, 6.5e3])

%% ---------------------------------------- Determinar Ts --------------------------------------------------------
                        %Não rodar sem antes diminuir o número de amostras%

%O local escolhido período de tranmissão extraído apartir da largura de
%banda do canal. Sabendo que o canal tem caracteristica de filtro passa
%baixa

% Condição: é necessário garantir primeiramente que ele esteja presente na banda de
%passagem de sinal (baixa frequência).

% Para ser possível analisarmos o comportamento da resposta
% através do diagrama de olho, temos que encontrar um período que consiga
% concentrar o maior número de frequências (analisados pela convolução)
% para que consigamos concentrar uma maior quantidade de frequências e
% tornar assim, o diagrama de olho mais linear (com mais linhas
% sobrepostas) "indicando" um comportamento que tende a ser igual para
% sinais -1 e 1. E por isso, é necessário centralizar os sinais na banda de
% passagem do filtro, garantindo assim que possamos observar o
% comportamento através do diagrama de olho

%As próximas linhas tem como propósito de testar o espectro de frequências da convolução alterando o
%período de transmissão, na tentativa de validar a veracidade das linhas
%anteriores
% ---------------------------------------- Fim --------------------------------------------------------

% Plot do comportamento do canal em frequência (Filtro passa baixas).

[t, y]=Manchester(bits, Ts, dt);
h = (12400.*exp(-24597.*t) + 2*9341.1*exp(-6201.7.*t).*(cos(-16324.*t + 2.2966))).*u(t);

[f, M] = my_fft(h, fs);
plot(f, abs(M), 'Color', [1, 0, 0]); ylabel(['Magnitude da FFT']) ;xlabel(['Frequência (\omega)']); grid;
title('Comportamento em frequência do canal H_2(s)')
grid on;
xlim([-1e4, 1e4]);

%Teste de diferentes períodos para comprovar a veracidade da condição
%descrita no topo da secção.

figure();
[t, y]=Manchester(bits, Ts, dt);
h = (12400.*exp(-24597.*t) + 2*9341.1*exp(-6201.7.*t).*(cos(-16324.*t + 2.2966))).*u(t);

Convolucao = conv(h, y)*dt;
[f, M] = my_fft(Convolucao, fs);
subplot(4,1,1);
plot(f, abs(M)); ylabel(['Magnitude da FFT']) ;xlabel(['Frequência (\omega)']); grid; 
title('Convolução h(t) e bitstream codificada'); legend('Ts  = 0,57 ms')
grid on;
xlim([-6.5e3, 6.5e3])

Ts = 1e-3;
[t, y]=Manchester(bits, Ts, dt);

Convolucao = conv(h, y)*dt;
[f, M] = my_fft(Convolucao, fs);
subplot(4,1,2);
plot(f, abs(M)); ylabel(['Magnitude da FFT']) ;xlabel(['Frequência (\omega)']); grid;
title('Convolução h(t) e bitstream codificada');
grid on; legend('Ts  = 1 ms')
xlim([-6.5e3, 6.5e3])

Ts = 3e-3;
[t, y]=Manchester(bits, Ts, dt);

Convolucao = conv(h, y)*dt;
[f, M] = my_fft(Convolucao, fs);
subplot(4,1,3);
plot(f, abs(M)); ylabel(['Magnitude da FFT']) ;xlabel(['Frequência (\omega)']); grid;
title('Convolução h(t) e bitstream codificada');
grid on; legend('Ts  = 3 ms')
xlim([-6.5e3, 6.5e3])

Ts = 20e-3;
[t, y]=Manchester(bits, Ts, dt);

Convolucao = conv(h, y)*dt;
[f, M] = my_fft(Convolucao, fs);
subplot(4,1,4);
plot(f, abs(M)); ylabel(['Magnitude da FFT']) ;xlabel(['Frequência (\omega)']); grid;
title('Convolução h(t) e bitstream codificada'); legend('Ts  = 20 ms')
grid on;
xlim([-6.5e3, 6.5e3])

%% • Crie uma função que gere o diagrama de olho da transmissão e a margem de ruído no melhor ponto de
%amostragem tendo como entradas a forma de onda, o período de transmissão e o passo de simulação. Dica:
%Observe os exercícios com MATLAB no final do capítulo.

% A função abaixo determina o diagrama de olho através do resultado do
% sinal transmitido (convolução entre a resposta do canal e do bitstream
% codificado.

% Aqui, para isolarmos o primeiro ciclo, foi necessário garantir que o
% começo da construção do diagrama seja apartir do segundo ciclo do vetor
% de valores que estão contidos no vetor convolução, portanto, isso é
% feito considerando o número total de pontos resultantes da convolução
% divididos pelo número total de bits contidos na bitstream (amostras * 2)
% ou seja, cada ciclo tem 1139.9975 pontos com TS = 0.57e-3 e 1e-6 passo 

tau = round((Ts/2)/dt);
x = eyediagram(Convolucao(1139.9975:length(t)), tau, 3*tau, 245);
grid on; hold on;

%% Cálculo da transformada inversa.

% Aqui é a sessão que foi utilizada como auxilio para o cálculo da função
% inversa do canal. Com funções que retornam os angulos necessários para
% converter para o formato e^{j0} que é o formato necessário para utilização dos pares básicos. 

num = 7.5*10^12;
den =[1  37*10^3  610*10^6  7.5*10^12];
[r, p, k] = residue(num, den);
[rad, mag] = cart2pol(real(r), imag(r));

t=0:dt:1;
h = (12400.*exp(-24597.*t) + 2*9341.1*exp(-6201.7.*t).*(cos(-16324.*t + 2.2966))).*u(t);
plot(t, h);
