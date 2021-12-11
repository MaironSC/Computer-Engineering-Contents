%%Trabalho 1
w1 = (640*pi); 
w2 = (1040*pi); 
w3 = (1700*pi); 
w4 = (2800*pi); 
w5 = (4600*pi); 
w6 = (7400*pi);
w7 = (12200*pi);
w8 = (20000*pi);

freqNyquist = 200e06; % Frequência de amostragem
t = -0.01 :1/freqNyquist: 0.01; % Periodo de amostragem

a1 = 1; a2 = 7; a3 = 1; a4 = 0; a5 = 2; a6 = 5; a7 = 1; a8 = 5;

% Mensagem 1
m_L = 1/10*(10 + a1*cos(w1.*t) + a2*cos(w2.*t) + a3*cos(w3.*t) + a4*cos(w4.*t) + a5*cos(w5.*t) + a6*cos(w6.*t) +a7*cos(w7.*t)+a8*cos(w8.*t));
m_R = 1/10*(10 + a8*cos(w1.*t) + a7*cos(w2.*t) + a6*cos(w3.*t) + a5*cos(w4.*t) + a4*cos(w5.*t) + a3*cos(w6.*t) +a2*cos(w7.*t)+a1*cos(w8.*t));

%% Os sinais modulantes mL(t) e mR(t) no domínio tempo e domínio frequência
suptitle('Mensagens (em domínio do tempo)')
subplot(2,1,1);plot(t, m_L, 'Color', [0,0.7,0.9]);legend('m_{L}(t)'); xlabel('Tempo (segundos)');ylabel('Amplitude'); grid;
subplot(2, 1, 2);plot(t, m_R, 'Color',[1, 0, 0]); xlabel('Tempo (segundos)');ylabel('Amplitude'); grid; legend('m_{R}(t)')
% ----- Chamada das funções que fazem a fft (descrita no próprio arquivo da função) -----
[f1, M_L1] = my_fft(m_L, freqNyquist);
[f2, M_R2] = my_fft(m_R, freqNyquist);
% ------------------------------------------------------------------------------------------------------------------------
figure();
suptitle('Mensagens (em domínio da frequência)')
subplot(2,1,1);plot(f1, abs(M_L1),  'Color', [0,0.7,0.9]);legend('M_{L}(\omega)'); xlim([-10185.91637, 10185.91637]);ylabel(['Magnitude da FFT']);xlabel(['Frequência (Hz)']); grid;
subplot(2,1,2); plot(f2, abs(M_R2), 'Color', [1, 0, 0]); legend('M_{R}(\omega)'); xlim([-10185.91637, 10185.91637]); ylabel(['Magnitude da FFT']) ;xlabel(['Frequência (Hz)']); grid;

%% O sinal multiplexado m(t) no domínio tempo e domínio frequência (Stereo multiplexer)
suptitle('Multiplexação estereofônica de FM')
circuito_combinador_soma = m_L + m_R; % [m_L (t) + m_R (t)]
circuito_combinador_diferenca = m_L - m_R; % [m_L (t) - m_R (t)]
frequencia_piloto =  19000*2*pi; 
subportadora = cos(2*frequencia_piloto*t); % cos(2*wp*t)
sinal_moduladodsb = circuito_combinador_diferenca.*subportadora; % [m_L (t) - m_R (t)] . cos(2*wp*t)

k = 0.3; % [30%]
sinal_piloto = k.*cos(frequencia_piloto*t);  % k . cos(wp*t)

% m (t) = [m_L (t) + m_R (t)] + [m_L (t) - m_R (t)] . cos(2*wp*t) + k . cos(wp*t)
m = circuito_combinador_soma + sinal_moduladodsb + sinal_piloto;

[f1, M_w] = my_fft(m, freqNyquist);
subplot(2,1,1);plot(t, m, 'Color', [0,0.7,0.9]);legend('m(t)'); xlabel('Tempo (segundos)');ylabel('Amplitude'); grid;
subplot(2,1,2); plot(f1, abs(M_w), 'Color', [1, 0, 0]); legend('M(\omega)'); xlim([-50000, 50000]); ylabel(['Magnitude da FFT']) ;xlabel(['Frequência (Hz)']); grid;

%% O sinal de portadora no domínio tempo e domínio frequência;
f_L = 76e06;
f_c = 76.1e06; %Frequência central da portadora
f_H = 76.2e06;
carrier = cos(2*pi*f_c.*t);
suptitle('Sinal da portadora')
subplot(2,1,1);
plot(t, carrier, 'Color', [0,0.7,0.9]); legend('Portadora (t)'); xlabel('Tempo (segundos)'); ylabel('Amplitude'); grid;
xlim([-0.000001, 0.0000001])

subplot(2, 1, 2)
[f4, M_w] = my_fft(carrier, freqNyquist);
plot(f4, abs(M_w), 'Color', [1, 0, 0]); legend('Portadora (\omega)'); ylabel(['Magnitude da FFT']) ;xlabel(['Frequência (Hz)']); grid;
xlim([7.6085e07, 7.612e07])
%% O sinal modulado em frequência no domínio tempo e domínio frequência;
Amplitude = (-min(m)+max(m))/2;
Beta = 0.5;
% Desvio de frequência instantânea 
Delta_omega = (200e3)/(2*(1+(1/Beta)));

% Beta = Delta_omega/(Omega_m(t))                                         [1.1]
% Isolando na equação que descreve kf
% kf = Delta_omega * Omega_m(t)/Amplitude_pp                     [1.2]
% Substituindo [1.1] em [1.2]
% kf = Delta_omega/Amplitude_pp

%O desvio de freqüência de pico Delta_omega da onda FM é proporcional (pela constante kf ) ao valor de pico Vm (ou amplitude) do sinal modulante: 
kf = (Delta_omega/Amplitude);
a = (1/freqNyquist) * cumsum(m); %a(t) = integral (-inf, t) m(lambda) d_lambda
fm = cos(2*pi.*t*f_c + a.* kf);  %Portadora + variação na frequência
suptitle('Sinal m(t) modulado')
subplot(2,1,1);
plot(t, fm, 'Color', [0,0.7,0.9]); legend('Fm (t)'); xlabel('Tempo (segundos)'); ylabel('Amplitude'); grid;
xlim([-1e-6, 1e-6])
subplot(2, 1, 2)
[f4, M_w1] = my_fft(fm, freqNyquist);
plot(f4, abs(M_w1), 'Color', [1, 0, 0]); legend('Fm (\omega)'); ylabel(['Magnitude da FFT']) ;xlabel(['Frequência (Hz)']); grid;
xlim([7.60*10^7, 7.62*10^7])
%% Demodulação
demodulacao = fmdemod(fm, f_c, freqNyquist, kf/(2*pi));
suptitle('Sinal m(t) demodulado')

subplot(2, 1, 1)
plot(t, demodulacao); legend('m_d(t)'); xlabel('Tempo (segundos)'); ylabel('Amplitude'); grid;

subplot(2, 1, 2)
[f4, M_w] = my_fft(demodulacao, freqNyquist);
plot(f4, abs(M_w), 'Color', [1, 0, 0]); legend('M_d(\omega)'); ylabel(['Magnitude da FFT']) ;xlabel(['Frequência (Hz)']); grid;
xlim([-0.6*10^5, 0.6*10^5])
%% Filtragem necessária no repector FM estéreo
%FPB DE BANDA BASE
FM_dem = (11.5e+03)/(freqNyquist/2);

[a, b] = butter(4, FM_dem, 'low'); % Filtro butter passa baixa de ordem 4
M1_soma_MR = filtfilt(a, b, demodulacao); 

%FPF CENTRADA EM 2*FC = 38kHz
F_HIGH = (51.5e+03)/(freqNyquist/2);
F_LOW = (27.5e+03)/(freqNyquist/2);

[b2, a2] = butter(2, [F_LOW, F_HIGH], 'bandpass'); % Filtro butter passa faixa de ordem 2 
FPF_38 = filtfilt(b2, a2, demodulacao); 

% FPF sintonizado em 19kHz
F_HIGH = (19.5e+03)/(freqNyquist/2);
F_LOW = (18.5e+03)/(freqNyquist/2);

[b3, a3] = butter(2, [F_LOW, F_HIGH], 'bandpass'); % Filtro butter passa faixa de ordem 2 
FPF_19 = filtfilt(b3, a3, demodulacao); 

Duplicador = ((FPF_19.*FPF_19)*2) -1;
Mult = Duplicador.*FPF_38;

[b4, a4] = butter(4, FM_dem, 'low'); % Filtro butter passa baixa de ordem 4 
M1_s_MR = filtfilt(b4, a4, Mult); 

ML_2 = (M1_soma_MR + M1_s_MR)/2;
MR_2 = (M1_soma_MR - M1_s_MR)/2;

%%  As mensagens demoduladas m'L (t) e m'R (t) no domínio tempo e domínio frequência, comparando-as com os sinais originalmente transmitidos.
figure()
plot(t, M1_soma_MR, 'Color', [0,0.7,0.9]);xlabel('Tempo (segundos)');ylabel('Amplitude');legend('m_{r+l}(t)'); grid;

figure();
suptitle('Multiplexação estereofônica de FM em domínio tempo')
subplot(2,1,1);
plot(t, ML_2, 'Color', [0,0.7,0.9]);xlabel('Tempo (segundos)');ylabel('Amplitude');legend('m_{(1)}(t)'); grid;
hold on;
plot(t, m_L, '--', 'Color', [1, 0, 0]);
legend('m_L rebuild(t)', 'm_L(t)');
ylim([min(m_L)-0.5, max(m_L)+1])
xlim([-0.002, 0.002])

subplot(2,1,2);
plot(t, MR_2, 'Color', [0,0.7,0.9]);xlabel('Tempo (segundos)');ylabel('Amplitude');legend('m_{(1)}(t)'); grid;
hold on;
plot(t, m_R, '--', 'Color', [1, 0, 0]);
legend('m_R rebuild(t)', 'm_R(t)');
xlim([-0.002, 0.002])
ylim([min(m_R)-1, max(m_R)+1])


[f1, M_L] = my_fft(ML_2, freqNyquist);
[f2, M_R] = my_fft(MR_2, freqNyquist);
[f3, M_L_original] = my_fft(m_L, freqNyquist);
[f4, M_R_original] = my_fft(m_R, freqNyquist);

figure();
subplot(2,1,1);
plot(f1, abs(M_L_original), 'Color', [1, 0, 0]); hold on;
plot(f3, abs(M_L), '--', 'Color', [0,0.7,0.9]); legend('M_L(\omega)','M_Lrebuild(\omega)'); ylabel(['Magnitude da FFT']) ;xlabel(['Frequência (Hz)']); grid;
xlim([-0.6*10^4, 0.6*10^4])
subplot(2,1,2);
plot(f2, abs(M_R_original), 'Color', [1, 0, 0]); hold on;
plot(f4, abs(M_R), '--', 'Color', [0,0.7,0.9]); legend('M_R(\omega)', 'M_Rrebuild(\omega)'); ylabel(['Magnitude da FFT']) ;xlabel(['Frequência (Hz)']); grid;
xlim([-0.6*10^4, 0.6*10^4])
%%
function [f, M] = my_fft(m, fs)
        N = length(m); % Tamanho da mensagem
        M = fftshift(fft(m, N)/abs(N)); % Faz a FFT divindo a amplitude.
        f = fs*[-N/2:N/2-1]/N; % Extração da frequência de amostragem da fft
end