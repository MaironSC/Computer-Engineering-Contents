%Execução section por section
%%1)
clc;clear;
s = tf('s');
k = -1;
G = -10*((s+10)/((s+4.0825)*(s-4.0825)));
C = k*(1+1/s);
T = G*C
bodeplot(T); 
grid on;
title('Diagrama de Bode');
legend('k = -1 ')
%% 2)
clc;clear;
s = tf('s');
k = -0.242561; % -12.3 = 20 log_10(k)
G = -10*((s+10)/((s+4.0825)*(s-4.0825)));
C = k*(1+1/s);
T = G*C
bodeplot(T); 
grid on;
title('Diagrama de Bode');
legend('k = -0.242661 ')
%% 3)
clc;clear;
s = tf('s');
k = -0.242424 % k<-0.2424242424242424; 
G = -10*((s+10)/((s+4.0825)*(s-4.0825)));
C = k*(1+1/s);
T = G*C;
bodeplot(T); 
%T2 = feedback(T, 1);
%step(T2);
grid on;
title('Diagrama de Bode');
legend('k = -0.242424')
%% 4)
clc;clear;
s = tf('s');
k = -1;
G = -10*((s+10)/((s+4.0825)*(s-4.0825)));
C = k*(1+1/s);
T = G*C
nyquist(T)
legend('k = -1');
xlim([-7 1])
figure();
k = -0.2425;
G = -10*((s+10)/((s+4.0825)*(s-4.0825)));
C = k*(1+1/s);
T = G*C;
nyquist(T)
xlim([-4 2])
legend('k = -0.2425');
%% 5)
clc;clear;
s = tf('s');
k = -0.6;
G = -10*((s+10)/((s+4.0825)*(s-4.0825)));
C = k*(1+1/s);
T = (G*C);
nyquist(T+1); 
xlim([-2 1])
hold on; 

k = -0.2;
G = -10*((s+10)/((s+4.0825)*(s-4.0825)));
C = k*(1+1/s);
T = (G*C);
nyquist(T+1)
xlim([-2 2])
legend('k = -0.6', 'k = -0.2');

