w1 = (600*pi); w2 = (900*pi); w3 = (1500*pi); w4 = (2400*pi); w5 = (3200*pi); w6 = (4200*pi);w7 = (5400*pi);w8 = (6800*pi);

freqNyquist = 3.6e06; % Frequência de amostragem
t = -0.02 :1/freqNyquist: 0.02; % Periodo de amostragem

a1 = 1; a2 = 7; a3 = 1; a4 = 0; a5 = 2; a6 = 5; a7 = 1; a8 = 5;

% Mensagem 1
m1 = 2 + a1*cos(w1.*t) + a2*cos(w2.*t) + a3*cos(w3.*t) + a4*cos(w4.*t) + a5*cos(w5.*t) + a6*cos(w6.*t) + a7*cos(w7.*t) + a8*cos(w8.*t); 
% Mensagem 2
m2 = 6 + a8*cos(w1.*t) + a7*cos(w2.*t) + a6*cos(w3.*t) + a5*cos(w4.*t) + a4*cos(w5.*t) + a3*cos(w6.*t) + a2*cos(w7.*t) + a1*cos(w8.*t);
% Mensagem 3
m3 = 3 + cos(w1.*t) + 4*cos(w2.*t) + 9*cos(w3.*t) + 6*cos(w4.*t) + 3*cos(w5.*t) + 5*cos(w6.*t) + 1*cos(w7.*t) + 5*cos(w8.*t);

%% Os sinais modulantes no domínio tempo e domínio frequência; 
figure();

subplot(3,1,1);plot(t, m1, 'Color', [0,0.7,0.9]);legend('m_{(1)}(t)'); xlabel('Tempo (segundos)');ylabel('Amplitude'); grid;
subplot(3, 1, 2);plot(t, m2, 'Color',[1, 0, 0]);title('m_{(2)}(t)'); xlabel('Tempo (segundos)');ylabel('Amplitude'); grid; legend('m_{(2)}(t)'); 
subplot(3, 1, 3);plot(t, m3, 'Color' ,[0.4940, 0.1840, 0.5560]);title('m_{(3)}(t)'); xlabel('Tempo (segundos)');ylabel('Amplitude'); grid; legend('m_{(3)}(t)'); 
% ----- Chamada das funções que fazem a fft (descrita no próprio arquivo da função) -----
[f1, M_F1] = my_fft(m1, freqNyquist);
[f2, M_F2] = my_fft(m2, freqNyquist);
[f3, M_F3] = my_fft(m3, freqNyquist);
% ------------------------------------------------------------------------------------------------------------------------
figure();

subplot(3,1,1);plot(f1, abs(M_F1),  'Color', [0,0.7,0.9]);legend('M_{(1)}(\omega)'); xlim([-3600, 3600]);ylabel(['Magnitude da FFT']);xlabel(['Frequência (Hz)']); grid;
subplot(3,1,2); plot(f2, abs(M_F2), 'Color', [1, 0, 0]); legend('M_{(2)}(\omega)'); xlim([-3600, 3600]); ylabel(['Magnitude da FFT']) ;xlabel(['Frequência (Hz)']); grid;
subplot(3,1,3); plot(f3, abs(M_F3), 'Color' ,[0.4940, 0.1840, 0.5560]); legend('M_{(3)}(\omega)'); xlim([-3600, 3600]); ylabel(['Magnitude da FFT']); xlabel(['Frequência (Hz)']); grid;

%% O(s) sinal(is) de portadora(s) no domínio tempo e domínio frequência;
figure();
Ac = 1;
%-------------- Frequência em Hz (por isso *2pi) das portadoras do emissor --------------
freq1 = (430*10^3)*(2*pi);
freq2 = (440*10^3)*(2*pi);
freq3 = (450*10^3)*(2*pi);
Carrier_M1 = Ac*cos(freq1*t);
Carrier_M2 = Ac*cos(freq2*t);
Carrier_M3 = Ac*cos(freq3*t);
%------------------------------------------------------------------------------------------------------------------

subplot(3,1,1); plot(t, Carrier_M1, 'Color', [0,0.7,0.9]);legend('Portadora 1 centrada em 430KHz'); xlabel('Tempo (segundos)'); ylabel('Amplitude'); xlim([-0.0001, +0.0001]); grid;
subplot(3,1,2); plot(t, Carrier_M2, 'Color', [1, 0, 0]); legend('Portadora 2 centrada em 440KHz'); xlabel('Tempo (segundos)'); ylabel('Amplitude'); xlim([-0.0001, +0.0001]); grid;
subplot(3,1,3); plot(t, Carrier_M3, 'Color' ,[0.4940, 0.1840, 0.5560]); legend('Portadora 3 centrada em 450KHz'); xlabel('Tempo (segundos)'); ylabel('Amplitude'); xlim([-0.0001, +0.0001]); grid;

figure();

% ----- Chamada das funções que fazem a fft (descrita no próprio arquivo da função) -----
[f1, Carrier_F1] = my_fft(Carrier_M1, freqNyquist);
[f2, Carrier_F2] = my_fft(Carrier_M2, freqNyquist);
[f3, Carrier_F3] = my_fft(Carrier_M3, freqNyquist);
% ------------------------------------------------------------------------------------------------------------------------
subplot(3,1,1); plot(f1, abs(Carrier_F1), 'Color', [0,0.7,0.9]); legend('Portadora 1 centrada em 430KHz');ylabel(['Magnitude da FFT']);xlabel(['Frequência (Hz)']);grid;
subplot(3,1,2);xlabel(['Frequência (Hz)']);plot(f2, abs(Carrier_F2), 'Color', [1, 0, 0]);legend('Portadora 2 centrada em 440KHz');ylabel(['Magnitude da FFT']);xlabel(['Frequência (Hz)']);grid;
subplot(3,1,3);ylabel(['Magnitude da FFT']);xlabel(['Frequência (Hz)']);plot(f3, abs(Carrier_F3), 'Color' ,[0.4940, 0.1840, 0.5560]);ylabel(['Magnitude da FFT']);xlabel(['Frequência (Hz)']);legend('Portadora 3 centrada em 450KHz'); grid;

%% Os sinais modulados no domínio tempo e domínio frequência; 
%--------------------------Módulo modulador multiplicador--------------------------
s1 = m1.*Carrier_M1;
s2 = m2.*Carrier_M2;
s3 = m3.*Carrier_M3;
%-------------------------------------------------------------------------------------------------
figure();

subplot(3,1,1); plot(t, s1, 'Color', [0,0.7,0.9]);legend('Sinal modulado a partir da mensagem m_{(1)}(t) e portadora 1.'); xlabel('Tempo (segundos)');ylabel('Amplitude');grid;
subplot(3,1,2, 'Color', [1, 0, 0]);plot(t, s2);legend('Sinal modulado a partir da mensagem m_{(2)}(t) e portadora 2.');xlabel('Tempo (segundos)'); ylabel('Amplitude'); grid;
subplot(3,1,3);plot(t, s3, 'Color' ,[0.4940, 0.1840, 0.5560]);legend('Sinal modulado a partir da mensagem m_{(3)}(t) e portadora 3.'); xlabel('Tempo (segundos)');ylabel('Amplitude'); grid;
figure();

subplot(3,1,1); [f_1, s1_F]=my_fft(s1, freqNyquist);plot(f_1, abs(s1_F), 'Color', [0,0.7,0.9]);ylabel(['Magnitude da FFT']);xlabel(['Frequência (Hz)']);legend('Sinal modulado a partir da mensagem M_{(1)}(\omega) e portadora 1.'); grid;
subplot(3,1,2); [f_2, s2_F]=my_fft(s2, freqNyquist);plot(f_2, abs(s2_F), 'Color', [1, 0, 0]); ylabel(['Magnitude da FFT']); xlabel(['Frequência (Hz)']); legend('Sinal modulado a partir da mensagem M_{(2)}(\omega) e portadora 2.'); grid;
subplot(3,1,3); [f_3, s3_F]=my_fft(s3, freqNyquist); plot(f_3, abs(s3_F), 'Color' ,[0.4940, 0.1840, 0.5560]); ylabel(['Magnitude da FFT']); xlabel(['Frequência (Hz)']); legend('Sinal modulado a partir da mensagem M_{(3)}(\omega) e portadora 3.'); grid;

%% A soma dos sinais modulados no domínio tempo e no domínio frequência; 
figure();
s4 = s1+s2+s3;
subplot(2,1,1);plot(t, s4, 'Color', [0,0.7,0.9]);suptitle('Soma dos sinais modulados');legend('s_{(t)}');xlabel('Tempo (segundos)');ylabel('Amplitude');grid;
subplot(2,1,2);[f_4, s4_F]=my_fft(s4, freqNyquist);plot(f_4, abs(s4_F), 'Color', [0,0.7,0.9]);ylabel(['Magnitude da FFT']);xlabel(['Frequência (Hz)']);legend('Soma dos sinais modulados');grid;

%%  Os sinais demodulados no domínio tempo e no domínio frequência;

%%%---------------- Inicialização dos 3 filtros passa banda ----------------
%Frequências máxima e mínima de banda mensagem 1                                                                
f_high_1 = (4.35*10^5)/(freqNyquist/2);
f_low_1 = (4.25*10^5)/(freqNyquist/2); 

%Frequências máxima e mínima de banda mensagem 2      
f_high_2 = (4.45*10^5)/(freqNyquist/2);
f_low_2 = (4.35*10^5)/(freqNyquist/2); 

%Frequências máxima e mínima de banda mensagem 3       
f_high_3 = (4.55*10^5)/(freqNyquist/2);
f_low_3 = (4.45*10^5)/(freqNyquist/2);

[b1, a1] = butter(4, [f_low_1, f_high_1], 'bandpass'); % Filtro butter passa banda de ordem 4 apartir da frequência da mensagem 1
filtro_m_1 = filtfilt(b1, a1, s4); 
[b2, a2] = butter(4, [f_low_2, f_high_2], 'bandpass'); % Filtro butter passa banda de ordem 4 apartir da frequência da mensagem 2
filtro_m_2 = filtfilt(b2, a2, s4);
[b3, a3] = butter(4, [f_low_3, f_high_3], 'bandpass'); % Filtro butter passa banda de ordem 4 apartir da frequência da mensagem 3
filtro_m_3 = filtfilt(b3, a3, s4);
%%%--------------------------------------------------------------------------------------
Ac = 2; %Amplitude da portadora local (receptor).
freq1 = (430*10^3)*(2*pi);
freq2 = (440*10^3)*(2*pi);
freq3 = (450*10^3)*(2*pi);

%Portadora local (receptor)
Carrier_local_oscilattor_1 = Ac*cos(freq1*t);
Carrier_local_oscilattor_2 = Ac*cos(freq2*t);
Carrier_local_oscilattor_3 = Ac*cos(freq3*t);

m_final_1 = filtro_m_1.*Carrier_local_oscilattor_1;
m_final_2 = filtro_m_2.*Carrier_local_oscilattor_2;
m_final_3 = filtro_m_3.*Carrier_local_oscilattor_3;

%%%---------------- Inicialização dos 3 filtros passa baixa ----------------
[num, den] = butter(2, ((450*10^3)/freqNyquist));
m_t_1 = filtfilt(num, den, m_final_1); 
m_t_2 = filtfilt(num, den, m_final_2);
m_t_3 = filtfilt(num, den, m_final_3);
%%%--------------------------------------------------------------------------------------

suptitle('Mensagens demoduladas em domínio de tempo')
subplot(3, 1, 1);plot(t, m_t_1, 'Color', [0,0.7,0.9]);xlabel('Tempo (segundos)');ylabel('Amplitude');legend('m_{(1)}(t)'); grid;
subplot(3, 1, 2);plot(t, m_t_2, 'Color', [1, 0, 0]);xlabel('Tempo (segundos)');ylabel('Amplitude');legend('m_{(2)}(t)'); grid;
subplot(3, 1, 3);plot(t, m_t_3, 'Color' ,[0.4940, 0.1840, 0.5560]);xlabel('Tempo (segundos)');ylabel('Amplitude');legend('m_{(3)}(t)'); grid;

[fm1_f, m_f_1]=my_fft(m_t_1, freqNyquist);
[fm2_f, m_f_2]=my_fft(m_t_2, freqNyquist);
[fm3_f, m_f_3]=my_fft(m_t_3, freqNyquist);

figure()
suptitle('Mensagens demoduladas em domínio da frequência')
subplot(3, 1, 1);plot(t, m_t_1, 'Color', [0,0.7,0.9]);plot(fm1_f, abs(m_f_1), 'Color', [0,0.7,0.9]);xlabel('Tempo (segundos)');ylabel('Amplitude');xlim([-3600, 3600]);legend('M_{(1)}(\omega)'); grid;
subplot(3, 1, 2);plot(fm2_f, abs(m_f_2), 'Color', [1, 0, 0]);xlabel('Tempo (segundos)');ylabel('Amplitude');legend('M_{(2)}(\omega)'); xlim([-3600, 3600]);grid;
subplot(3, 1, 3);plot(fm3_f, abs(m_f_3), 'Color' ,[0.4940, 0.1840, 0.5560]);xlabel('Tempo (segundos)');ylabel('Amplitude');legend('M_{(3)}(\omega)'); xlim([-3600, 3600]);grid;
%%
function [f, M] = my_fft(m, fs)
        N = length(m); % Tamanho da mensagem
        M = fftshift(fft(m, N)/abs(N)); % Faz a FFT divindo a amplitude.
        f = fs*[-N/2:N/2-1]/N; % Extração da frequência de amostragem da fft
end