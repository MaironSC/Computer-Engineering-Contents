function [t, x] = Manchester(bits, Ts, dt)
            x = [ ];
            for i = 1:length(bits)
                if bits(i) == 1 %Verifica se o valor de bits na posição i é igual a 1 => Se for atribui -1 em um tempo de 0.5*Ts
                    x = [x ones(1, round((0.5*Ts)/dt)) -1*ones(1, round((0.5*Ts)/dt))];
                elseif bits(i) == 0 %Verifica se o valor de bits na posição i é igual a 0 => Se for atribui 1 em um tempo de 0.5*Ts
                    x = [x -1*ones(1, round((0.5*Ts)/dt)) ones(1, round((0.5*Ts)/dt))];
                end
            t = 0:dt:((length(x) - 1)*dt); %Gera um termo t que será usado para percorrer o vetor codificado
            end
end