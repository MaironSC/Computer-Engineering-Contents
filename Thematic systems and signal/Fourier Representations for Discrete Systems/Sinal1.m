%% a) Plote o sinal utilizando com -15<n<16.
clc;clear
interacao = -15:16;
x=zeros(size(interacao));

x(1) = 1;x(2) = 7; x(3) = 1; x(4) = 0; x(5) = 2; x(6) = 5; x(7) = 1; x(8) = 5; 

for index = 9:length(interacao)
        index2 = mod(index, 8);
        if index2 == 0
            index2 =8;
        end
        x(index)=x(index2);
end
percorrer=-15:16;
subplot(3,1,1);stem(percorrer,x);title('x[n]');xlabel('n');
xlim([-15, 16]);
ylim([0, 7]);
grid on;

% b)Encontre manualmente a série de Fourier de tempo discreto deste sinal. Anexe os cálculos em um arquivo .pdf no relatório
k = -15:1:16;
A_calculado = 1/8*(exp(-1i*k*pi/4) + 7*exp(2*-1i*k*pi/4) + exp(3*-1i*k*pi/4)+2*exp(5*-1i*k*pi/4)+5*exp(6*-1i*k*pi/4)+exp(7*-1i*k*pi/4)+5*exp(8*-1i*k*pi/4));
index = (1:length(A_calculado));

% c)Plote os diagramas de modulo e fase da representação de Fourier deste sinal.
%Lembre-se que a representação de Fourier de um sinal periódico é discreta, portanto
%utilize o comando stem.
subplot(3,1,2);stem(k, abs(A_calculado));title('|x[n]|'); grid on; xlabel('n');  xlim([-15, 16]);
subplot(3,1,3);stem(k, angle(A_calculado)*(180/pi));title('\angle x[n]'); grid on; ylabel('Graus');xlim([-15, 16]); xlabel('n');


% d)Caso o sinal x[n] tivesse sido originado de um processo de amostragem com
%frequência de 1 Hz, reconstrua o sinal original utilizando um reconstrutor “ideal”. 

n=-15:16;
t = -15:0.01:16;
x_reconstruido = (x(1:length(interacao))*sinc(t-(n')));

figure (2);
plot(t, x_reconstruido);  grid on; title('Sinal reconstruído');xlabel('n');
xlim([-15, 16]);
ylim([-1.6, 7.5]);



