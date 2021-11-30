%Quest�o e
syms s t %declara como simbolo (vari�vel) s e t
t = -50:0.01:50;
H=tf([50 50*5],conv([1 5],[1 1])); %fun��o de transfer�ncia que come�a calculando no dom�nio tempo
X = tf([1], [1 0 1]);

%Quest�o f
Y = H*X;

%Quest�o h
num = Y.numerator();
den = Y.denominator();
[R,P, k] = residue(num{1},den{1});

%Quest�o h
y2 = (R(1)/(s-P(1))) + (R(2)/(s-P(2))) + (R(3)/(s-P(3))) + (R(4)/(s-P(4))); %No formato (K1/s-R1)
y2 = ilaplace(y2); %Transformada inversa

yfinal = subs(y2);%Substitui "t" na equa��o
yfinal= yfinal.*u(t);
subplot(3,1,1);
plot(t,yfinal,'color','r');
title('Fun��o extra�da atrav�s da transformada inversa de Laplace no MATLAB.');
legend('L^{-1}[{(25/s+1) + (0/s+5) + ((-12,5-j12,5)/(s-j)) + ((-12,5+j12,5)/(s+j))}]', 'Location', 'southwest');
grid on;

ycalculado = (25*exp(-t) +17.677*exp(-2.35i +1i*t)+17.677*exp(2.35i-1i*t)).*u(t);%y(t) calculado atrav�s dos exemplos.
subplot(3,1,2);
plot(t,ycalculado,'color','b');
title('Fun��o extra�da atrav�s do c�lculo da transformada inversa de Laplace.');
legend('y(t) = (25*exp(-t) +17.677*exp(-2.35i +1i*t)+17.677*exp(2.35i-1i*t)).*u(t)', 'Location', 'southwest');
grid on;

%Compara��o com conv
x1 = sin(t).*u(t);
h1 = 50*exp(-t).*u(t);
yconv = conv(x1,h1, 'same')*0.01;
subplot(3,1,3);
plot(t,yconv(1:length(t)), 'color','g');
title('Fun��o extra�da atrav�s da opera��o de convolu��o das fun��es no dom�nio tempo.');
legend('y(t) = (conv[sin(t)*u(t) || 50e^{-t}*u(t)]' ,'Location', 'southwest');
grid on;


