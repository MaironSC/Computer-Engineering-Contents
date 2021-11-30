syms s t
H=tf([10 66],conv([1 5.6457],[1 0.3542]));
num = H.numerator();
den = H.denominator();
[R,P, k] = residue(num{1},den{1});
y2 = (R(1)/(s-P(1))) + (R(2)/(s-P(2)));
y2 = ilaplace(y2);

t = -10:0.01:10;
yfinal = subs(y2);
yfinal= yfinal.*u(t);
subplot(2,1,1);
plot(t,yfinal,'color','r');
title('y_{nat}(t) extraído através do MATLAB');
legend('y(t)', 'Location', 'southwest');
grid on;

ycalculado = ((-1.8034*exp(-5.6457*t) + 11.8034*exp(-0.3542*t)).*u(t));
subplot(2,1,2);
plot(t,ycalculado, 'color', 'b');
title('y_{nat}(t) extraído através de cálculo teórico');
legend('y(t)', 'Location', 'southwest');
grid on;

