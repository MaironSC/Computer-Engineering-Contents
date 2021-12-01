FourierDsc = zeros(1, length(t));
FourierDsc1 = zeros(1, length(t));
FourierDsc2 = zeros(1, length(t));
k=-15:15;

for n=1:length(k) 
       FourierDsc(n) =(testf(k(n)));
       FourierDsc1(n) =(testf2(k(n)));
       FourierDsc2(n) =(testf3(k(n)));
end
figure(3);
subplot(3,1,1)
stem(k, abs(FourierDsc)); 
subplot(3,1,2); 
stem(k, abs(FourierDsc1))
subplot(3,1,3); 
stem(k,abs(FourierDsc2))


figure (4);
subplot(3,1,1)
stem(k, angle(FourierDsc)*(180/pi));
subplot(3,1,2); 
stem(k, angle(FourierDsc1)*(180/pi));
subplot(3,1,3); 
stem(k, angle(FourierDsc2)*(180/pi));
function [x] = testf(k)
    if k==0 
        x = 1;
    else 
        x = - (2^(1/2)*(exp(-(pi*k*1i)/2)/2 - exp((pi*k*1i)/2)/2))/(((k*pi*1i)/2)^(1/2)*((k*pi*1i)/4)^(1/2)) + (2*exp(-(pi*k*1i)/2)*(pi*k*1i + 2))/(k^2*pi^2) + (2*exp((pi*k*1i)/2)*(pi*k*1i - 2))/(k^2*pi^2);
    end
end
    
    function [y] = testf2(k)
    if k==0 
        y = 1;
    else 
        y = (2*exp(-(pi*k*1i)/2)*(pi*k*1i + 2))/(k^2*pi^2) - (2*exp(-(pi*k*3i)/2)*(pi*k*3i + 2))/(k^2*pi^2) ;
    end
    end
    
        function [z] = testf3(k)
    if k==0 
        z = 1;
    else 
        z = -((exp(-(pi*k*1i)/2) - exp(-(pi*k*3i)/2))*6i)/(k*pi);
    end
        end
    