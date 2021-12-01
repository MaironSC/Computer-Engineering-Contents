function [x] = func3(k)
    if k==0 
        x = 1;
    else 
        x = - ((exp(-(pi*k*1i)/2) - exp(-(pi*k*3i)/2))*3i)/(2*k*pi) - (2^(1/2)*(exp(-(pi*k*1i)/2)/2 - exp((pi*k*1i)/2)/2))/(4*((k*pi*1i)/2)^(1/2)*((k*pi*1i)/4)^(1/2)) + (exp(-(pi*k*1i)/2)*(pi*k*1i + 2))/(k^2*pi^2) + (exp((pi*k*1i)/2)*(pi*k*1i - 2))/(2*k^2*pi^2) - (exp(-(pi*k*3i)/2)*(pi*k*3i + 2))/(2*k^2*pi^2);
    end