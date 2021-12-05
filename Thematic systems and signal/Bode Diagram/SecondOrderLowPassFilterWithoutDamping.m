Wn = 10; %Freq natural
z = 1; %Razão de amortecimento
s = tf('s');
H1  = Wn^2 / (s^2 +2*z*Wn*s + Wn^2);

z = 0.5;
H2  = Wn^2 / (s^2 +2*z*Wn*s + Wn^2);

z = 0.1;
H3  = Wn^2 / (s^2 +2*z*Wn*s + Wn^2);


z = 0;
H4  = Wn^2 / (s^2 +2*z*Wn*s + Wn^2);


figure (1);
bode(H1, 'r', H2, 'b', H3, 'm', H4, 'black')
legend({'Razão de amortecimento = 1', 'Razão de amortecimento = 0.5', 'Razão de amortecimento = 0.1 ', 'Razão de amortecimento = 0'})
grid on;

figure (2);
pzmap(H1, 'r', H2,'b', H3,'m', H4,'black');
legend({'Polos H1', 'Polos H2', 'Polos H3', 'Polos H4'})

H5  = (s^2 +2*z*Wn*s + Wn^2)/Wn^2; %adicionando dois polos complexos (parar o ganho em altas frequência, e normalizar a ordem do númerador como menor que a do denominador)

a=2; %-razão de distância de frequencia natural
z = 0;
H6 = (s^2 +2*z*Wn*s + Wn^2)/Wn;
H6 = H6 * (a*Wn)/(s+a*Wn);
H6 = H6 * (Wn/a)/(s+(Wn/a)); %2 vezes menor que o primeiro polo

figure(3);
bode(H5, H6);
legend({'H5 se comporta como (H4)^{-1}', 'H6 que em comparação com H5 adiciona dois polos complexos, normalizando o denominador e parando o ganho em altas frequências'});
hold all
grid on;

figure(4);
pzmap(H6);
legend({'Polos e zeros de H6'})