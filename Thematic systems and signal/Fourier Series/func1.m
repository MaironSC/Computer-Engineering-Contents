function [x] = func1(k)
    if k==0 
        x = 1;
    else 
        x = - 1/(k^2*pi^2) - ((exp(-pi*k*1i) - exp(-pi*k*2i))*2i)/(k*pi) + (exp(-pi*k*1i)*(pi*k*2i + 2))/(k^2*pi^2) - (exp(-pi*k*2i)*(pi*k*4i + 2))/(2*k^2*pi^2);
    end
end