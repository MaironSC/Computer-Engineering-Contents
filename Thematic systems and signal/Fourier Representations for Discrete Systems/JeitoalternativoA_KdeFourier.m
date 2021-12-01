%% Jeito de calcular via Somatório
const = 8;
N = [1, 7, 1, 0, 2, 5, 1, 5];
A_k = zeros(size(N));

for n = 1:1:8
    for k = 1:1:8
        A_k(n) = A_k(n) + (N(k) * exp(-1i*k*(pi/4)*n))/8;
    end
end

x_calc = (1/8);

percorrer=1:8;
% c)Plote os diagramas de modulo e fase da representação de Fourier deste sinal.
subplot(2,1,1);stem(percorrer, abs(A_k));title('Valores de Modulo da série'); grid on;
subplot(2,1,2);stem(percorrer, angle(A_k)*(180/pi));title('Valores de Fase da série'); grid on;