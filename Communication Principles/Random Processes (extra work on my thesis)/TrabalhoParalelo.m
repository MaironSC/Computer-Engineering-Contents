Monte = 100;
dt = (1e-4); % Passo
JanelaHigh = 200e-3;
JanelaLow = -200e-3;
t = JanelaLow:dt:JanelaHigh-dt;
tc = [5e-3, 5e-3];
tau = JanelaLow*0.5:dt:(JanelaHigh*0.5)-dt; %
Rx = zeros(1, length(tau));
Ry = zeros(1, length(tau));
impact = 0.5;
x = zeros(1,length(t));
y = zeros(1,length(t));
var_x = 0;
avg_power_x = 0;
avg_power_y = 0;
var_y = 0;
p1=0;

for i=1:Monte
    x(1,:) = rtn_simple(t, dt, tc, impact);
    y(1,:) = filtro_pb(x, t, 1, dt);
    
    figure(1);
    plot(t, x); hold on; title('Sinal x(t)'); grid on;
    ylabel(['Amplitude']) ;xlabel(['t (s)']);
     
    figure(2);
    plot(t, y); hold on; title('Sinal filtrado y(t)'); grid on;
    ylabel(['Amplitude']) ;xlabel(['t (s)']);
    
    p=0;
    for j=1:length(t)
        p = p + dt*x(1, j)^2;
    end
    var_x = var_x + p;
    
    p1=0;
    var = 0;
    for j=1:length(t)
        p1 = p1 + dt*y(1, j)^2;
    end
    var_y = var_y + p1;
    
    for j = 1:length(Rx)
            Rx(j) =  Rx(j) + x(1, 0.5*(length(x(1,:)))) ... 
            * x(1, (0.5*(length(x(1,:)))) - (0.5*(length(tau))) + j);
        
            Ry(j) =  Ry(j)  + y(1, 0.5*(length(y(1,:)))) ... 
            * y(1, (0.5*(length(y(1,:)))) - (0.5*(length(tau))) + j);
    end
end

%% Potência
avg_power_x = (var_x)/(length(t)*Monte);
disp(['Potência média do sinal x (sem filtro) : ', num2str(avg_power_x)])
avg_power_y = (var_y)/(length(t)*Monte);
disp(['Potência média do sinal y (com filtro) : ', num2str(avg_power_y)])

%% Plots
figure(3);
subplot(2,1,1);
plot(tau, Rx/Monte); suptitle('Função de autocorrelação no tempo'); grid on;
legend('Rx(\tau)');
ylabel(['Magnitude da FFT']);xlabel(['\tau (s)'])

subplot(2,1,2)
plot(tau, Ry/Monte, 'color', 'r');   
legend('Ry(\tau)'); grid on;
ylabel(['Magnitude da FFT']);xlabel(['\tau (s)'])

figure(4);
subplot(2,1,1);
[f_1, Mag_x] = my_fft(Rx/Monte , 2*(1/dt));
plot(f_1, abs(Mag_x)); legend('RX(j\omega)');
ylabel(['Magnitude da FFT']);xlabel(['Frequência (rad/s)'])
[f_1, Mag] = my_fft(Ry/Monte , 2*(1/dt)); grid on;
subplot(2,1,2);
plot(f_1, abs(Mag), 'color', 'r'); legend('RY(j\omega)'); grid on;
ylabel(['Magnitude da FFT']);xlabel(['Frequência (rad/s)'])

figure(5);
subplot(2,1,1);
semilogx(f_1,mag2db(abs(Mag))); grid on; legend('RX(j\omega)');
ylabel(['dB']);xlabel(['Frequência (rad/s)'])
subplot(2,1,2);
semilogx(f_1,mag2db(abs(Mag_x)),  'color', 'r'); grid on; legend('RY(j\omega)');
ylabel(['dB']);xlabel(['Frequência (rad/s)'])

%%
function [y] = filtro_pb(x, t, i, dt)
             y = dt*(conv(h_t(t) , x(i, :), 'same'));
end
function [H_t] = h_t(t)
    for i = 1:length(t)
        if t(i) >= 0
            H_t(i) = (900)*exp(-1000*t(i));
        else
            H_t(i) = 0;
        end
    end
end
function [f, M] = my_fft(m, fs)
        N = length(m); % Tamanho da mensagem
        M = fftshift(fft(m, N)/abs(N)); % Faz a FFT divindo a amplitude.
        f = fs*[-N/2:N/2-1]/N; % Extração da frequência de amostragem da fft
end
