clc;clear;
s = tf('s');
G = -10*((s+10)/((s+4.0825)*(s-4.0825)));
bode(G); grid on; title('Resposta em frequência do sistema G(s)')
figure;
pzmap(G); title('Mapa de polos e zeros do sistema G(s)')
figure;
step(G); grid on; title('Resposta ao degrau do sistema G(s)')

%Variaveis de estado
a = [-1.66667 16.6667; 0.8334 1.6667];
b = [1.6667; 0.1667];
c = [0 -60];
d = 0;

[X,Y] = ss2tf(a,b,c,d);
G1=tf(X,Y)

a_1 = [0 -6 -60];
b_2 = [0.6 0 -10];
[a,b,c,d] = tf2ss(a_1, b_2);
[a_1,b_2] = ss2tf(a,b,c,d);
G=tf(a_1,b_2)

t = 0:0.01:15;  
u = max(0,min(t-1,1));
figure;
lsim(G1, u, t); grid on; title('Resposta ao degrau do sistema G(s)')