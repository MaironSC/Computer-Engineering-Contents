%% � Gere um bitsream de 200 amostras aleat�rias em um vetor. Cada amostra � composta de 2 bits

amostras = 200; %N�mero de amostras
bit = [0, 1];
bits = randi(bit, 1, 2*amostras);  % Cada amostra tem 2 bits

%% � Extra��o do per�odo de transmiss�o atrav�s da obten��o da constante de tempo da resposta ao degrau do sistema.

num = 7.5*10^12;
den =[1  37*10^3  610*10^6  7.5*10^12];
H2 = tf(num, den);
l = 0:1e-6:1e-3;
step(H2, l)
grid on;

%% � Baseado na largura de banda do canal, defina o per�odo transmiss�o. Defina o passo de simula��o de
% forma a simular o sistema adequadamente;

% A justificativa para escolha desse Ts est� contida na sec��o 
%                                               "Determinar Ts "
dt = 1e-6; % Passo
fs = (1/dt); % Freq de amostragem
Ts = 0.57e-3; % Per�odo de transmiss�o

%% � Fa�a a transformada inversa da fun��o de transfer�ncia do canal; 
% Alternativamente utilize o simulink com entrada from workspace, utilizando o sinal da forma de onda
% gerado anteriormente.

Ts = 0.57e-3;
[t, y]=Manchester(bits, Ts, dt);
h = (12400.*exp(-24597.*t) + 2*9341.1*exp(-6201.7.*t).*(cos(-16324.*t + 2.2966))).*u(t);

figure();
plot(t, h);
legend('h_2(t)')
title('Fun��o em dom�nio tempo do canal h_2');
grid on;
xlim([0 1.5e-3])

% � Crie uma fun��o que gere a forma de onda que representa o bitsream com a codifica��o de linha definida
%na especifica��o. A fun��o poder� ter como entrada o bitsream, o per�odo de transmiss�o e o passo de
%simula��o, e como sa�da a forma de onda e o vetor de tempo associado a ela;

figure();
plot(t, y);
legend('Vetor de 200 amostras codificadas');
xlim([0 0.01])

% �Fa�a a convolu��o (conv()) entre a resposta ao impulso do canal e a forma de onda do sinal 
%codificado, para obter o sinal transmitido.

Convolucao = conv(h, y)*dt; %Faz a convolu��o entre o canal e a saida do bitstream codificado a um passo dt => Essa ser� a forma de onda transmitida
figure();
plot(t, Convolucao(1:length(t)));

title('Convolu��o entre a resposta ao impulso do canal e o bitstream codificado')
grid on;
xlim([0 0.01])

figure();
[f, M] = my_fft(Convolucao, fs);
plot(f, abs(M), 'Color', [1, 0, 0]); ylabel(['Magnitude da FFT']) ;xlabel(['Frequ�ncia (\omega)']); grid;
title('Comportamento em frequ�ncia da convolu��o entre bitstream e h_2(t)')
grid on;
xlim([-6.5e3, 6.5e3])

%% ---------------------------------------- Determinar Ts --------------------------------------------------------
                        %N�o rodar sem antes diminuir o n�mero de amostras%

%O local escolhido per�odo de tranmiss�o extra�do apartir da largura de
%banda do canal. Sabendo que o canal tem caracteristica de filtro passa
%baixa

% Condi��o: � necess�rio garantir primeiramente que ele esteja presente na banda de
%passagem de sinal (baixa frequ�ncia).

% Para ser poss�vel analisarmos o comportamento da resposta
% atrav�s do diagrama de olho, temos que encontrar um per�odo que consiga
% concentrar o maior n�mero de frequ�ncias (analisados pela convolu��o)
% para que consigamos concentrar uma maior quantidade de frequ�ncias e
% tornar assim, o diagrama de olho mais linear (com mais linhas
% sobrepostas) "indicando" um comportamento que tende a ser igual para
% sinais -1 e 1. E por isso, � necess�rio centralizar os sinais na banda de
% passagem do filtro, garantindo assim que possamos observar o
% comportamento atrav�s do diagrama de olho

%As pr�ximas linhas tem como prop�sito de testar o espectro de frequ�ncias da convolu��o alterando o
%per�odo de transmiss�o, na tentativa de validar a veracidade das linhas
%anteriores
% ---------------------------------------- Fim --------------------------------------------------------

% Plot do comportamento do canal em frequ�ncia (Filtro passa baixas).

[t, y]=Manchester(bits, Ts, dt);
h = (12400.*exp(-24597.*t) + 2*9341.1*exp(-6201.7.*t).*(cos(-16324.*t + 2.2966))).*u(t);

[f, M] = my_fft(h, fs);
plot(f, abs(M), 'Color', [1, 0, 0]); ylabel(['Magnitude da FFT']) ;xlabel(['Frequ�ncia (\omega)']); grid;
title('Comportamento em frequ�ncia do canal H_2(s)')
grid on;
xlim([-1e4, 1e4]);

%Teste de diferentes per�odos para comprovar a veracidade da condi��o
%descrita no topo da sec��o.

figure();
[t, y]=Manchester(bits, Ts, dt);
h = (12400.*exp(-24597.*t) + 2*9341.1*exp(-6201.7.*t).*(cos(-16324.*t + 2.2966))).*u(t);

Convolucao = conv(h, y)*dt;
[f, M] = my_fft(Convolucao, fs);
subplot(4,1,1);
plot(f, abs(M)); ylabel(['Magnitude da FFT']) ;xlabel(['Frequ�ncia (\omega)']); grid; 
title('Convolu��o h(t) e bitstream codificada'); legend('Ts  = 0,57 ms')
grid on;
xlim([-6.5e3, 6.5e3])

Ts = 1e-3;
[t, y]=Manchester(bits, Ts, dt);

Convolucao = conv(h, y)*dt;
[f, M] = my_fft(Convolucao, fs);
subplot(4,1,2);
plot(f, abs(M)); ylabel(['Magnitude da FFT']) ;xlabel(['Frequ�ncia (\omega)']); grid;
title('Convolu��o h(t) e bitstream codificada');
grid on; legend('Ts  = 1 ms')
xlim([-6.5e3, 6.5e3])

Ts = 3e-3;
[t, y]=Manchester(bits, Ts, dt);

Convolucao = conv(h, y)*dt;
[f, M] = my_fft(Convolucao, fs);
subplot(4,1,3);
plot(f, abs(M)); ylabel(['Magnitude da FFT']) ;xlabel(['Frequ�ncia (\omega)']); grid;
title('Convolu��o h(t) e bitstream codificada');
grid on; legend('Ts  = 3 ms')
xlim([-6.5e3, 6.5e3])

Ts = 20e-3;
[t, y]=Manchester(bits, Ts, dt);

Convolucao = conv(h, y)*dt;
[f, M] = my_fft(Convolucao, fs);
subplot(4,1,4);
plot(f, abs(M)); ylabel(['Magnitude da FFT']) ;xlabel(['Frequ�ncia (\omega)']); grid;
title('Convolu��o h(t) e bitstream codificada'); legend('Ts  = 20 ms')
grid on;
xlim([-6.5e3, 6.5e3])

%% � Crie uma fun��o que gere o diagrama de olho da transmiss�o e a margem de ru�do no melhor ponto de
%amostragem tendo como entradas a forma de onda, o per�odo de transmiss�o e o passo de simula��o. Dica:
%Observe os exerc�cios com MATLAB no final do cap�tulo.

% A fun��o abaixo determina o diagrama de olho atrav�s do resultado do
% sinal transmitido (convolu��o entre a resposta do canal e do bitstream
% codificado.

% Aqui, para isolarmos o primeiro ciclo, foi necess�rio garantir que o
% come�o da constru��o do diagrama seja apartir do segundo ciclo do vetor
% de valores que est�o contidos no vetor convolu��o, portanto, isso �
% feito considerando o n�mero total de pontos resultantes da convolu��o
% divididos pelo n�mero total de bits contidos na bitstream (amostras * 2)
% ou seja, cada ciclo tem 1139.9975 pontos com TS = 0.57e-3 e 1e-6 passo 

tau = round((Ts/2)/dt);
x = eyediagram(Convolucao(1139.9975:length(t)), tau, 3*tau, 245);
grid on; hold on;

%% C�lculo da transformada inversa.

% Aqui � a sess�o que foi utilizada como auxilio para o c�lculo da fun��o
% inversa do canal. Com fun��es que retornam os angulos necess�rios para
% converter para o formato e^{j0} que � o formato necess�rio para utiliza��o dos pares b�sicos. 

num = 7.5*10^12;
den =[1  37*10^3  610*10^6  7.5*10^12];
[r, p, k] = residue(num, den);
[rad, mag] = cart2pol(real(r), imag(r));

t=0:dt:1;
h = (12400.*exp(-24597.*t) + 2*9341.1*exp(-6201.7.*t).*(cos(-16324.*t + 2.2966))).*u(t);
plot(t, h);
