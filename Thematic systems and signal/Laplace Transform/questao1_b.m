b = [50 250]; %varíaveis do polinômio no numerador
a = [1 6 5]; %varíaveis do polinômio no denominador
[Costantes,raizes] = residue(b,a);
disp('Raizes iguais a');
disp(raizes);
disp('Constantes iguais a');
disp(Costantes);