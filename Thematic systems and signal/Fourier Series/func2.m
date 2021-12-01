function [x] = func2(k)
    if k==0 
        x = 1;
    else 
        x = - ((exp(-(pi*k*1i)/4) - exp(-(pi*k*7i)/4))*1i)/(2*k*pi) - ((exp(-(pi*k*3i)/4) - exp(-(pi*k*5i)/4))*1i)/(2*k*pi);
    end