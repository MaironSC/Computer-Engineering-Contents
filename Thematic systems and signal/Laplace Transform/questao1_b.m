b = [50 250]; %var�aveis do polin�mio no numerador
a = [1 6 5]; %var�aveis do polin�mio no denominador
[Costantes,raizes] = residue(b,a);
disp('Raizes iguais a');
disp(raizes);
disp('Constantes iguais a');
disp(Costantes);