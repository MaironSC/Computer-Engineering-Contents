function [f, M] = my_fft(m, fs)
        N = length(m); % Tamanho da mensagem
        M = fftshift(fft(m, N)/abs(N)); % Faz a FFT divindo a amplitude.
        f = fs*[-N/2:N/2-1]/N; % Extra��o da frequ�ncia de amostragem da fft
end