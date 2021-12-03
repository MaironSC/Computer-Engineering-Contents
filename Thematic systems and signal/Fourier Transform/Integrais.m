syms w t

Valordaintegral_Sinal_1 = int(exp(-1i*w*t), t, -6, -2) + 3*int(exp(-1i*w*t), t, -2, 2) - 1*int(exp(-1i*w*t), t, 2, 4)
Valordaintegral_Sinal_2 = 2*int(sin(2*pi*t) * exp(-1i*w*t), t, -2, +2)
Valordaintegral_Sinal_3 = 2*int(sin(2*pi*t) * exp(-1i*w*t), t, -4, 0)