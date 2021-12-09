clc;clear;
s = tf('s');
G = 10*((s+10)/((s+4.0825)*(s-4.0825)))
Integrador = 1/s

%----------------Cálculo do polo dominante-------------
ol = atan(5.0825/20);
angulo_1 = rad2deg(ol) + 90;
ol = atan(1/20);
angulo_2 = rad2deg(ol) + 90;
ol = atan(20/3.0825);
angulo_3 = rad2deg(ol);
ol = atan(20/9);
angulo_4 = rad2deg(ol);
x = 180 - (angulo_1 + angulo_2 + angulo_3 - angulo_4);
%-----------------------------------------------------
%limite superior > 32,5769; limite inferior aprox > 0

z=-30;
o_z = rad2deg(atan(20/(abs(z) - 1)));
o_p = (o_z + x);
p = -(20/tan((deg2rad(o_p)))+1);

C = (s-z)/(s-p)
k = 619
T = feedback(k*C*G*Integrador, +1)
step(T, (0:0.001:10));
legend('Resposta ao degrau');
figure(); rlocus(T);
figure(); pzmap(T);
xlim([-570 15])
figure();

G = 10*((s+10)/((s+4.0825)*(s-4.0825)))
Potencia = feedback(Integrador*C*k, G); step(Potencia);legend('Esforço');

