omega_0 = 6000;
theta = [60 87]*(pi/180);

H = tf([5.6234 0 5.6234*omega_0^2], [1 2*omega_0*cos(theta(2)) omega_0^2]);
bode (H);
%pzmap(H);
hold on;

H1 = tf([5.6234 0 5.6234*omega_0^2], [1 2*omega_0*cos(theta(1)) omega_0^2]);
bode (H1, 'r--');
%pzmap(H1);

legend('\theta = 87^\circ ','\theta = 60^\circ');
grid on;
