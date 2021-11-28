figure(1) % Cria uma janela de figura tornando-a visível na tela
x = inline('2*(t>0 & t<=1) + (t >1 & t<=2)' );
h = inline('-0.5668*exp(-0.3542*t) + 0.5668*exp(-5.6457*t)');
dtau = 0.005; tau = 0:dtau:10;
ti = 0; tvec = 0:.1:10;
   
y = NaN*zeros(1, length(tvec)); 

for t = tvec,
    ti = ti+1; 
    xh = x(t-tau).*h(tau); lxh = length(xh);
    y(ti) = sum(xh.*dtau); 
    subplot(2, 1, 1), plot(tau, h(tau), 'k-', tau, x(t-tau), 'k--', t, 0, 'ok');  title('Operação de convolução');
    axis([tau(1) tau(end) -2.0 2.5]);
    patch([tau(1:end-1); tau(1:end-1); tau(2:end); tau(2:end)], ...
        [zeros(1, lxh - 1); xh(1:end-1);xh(2:end);zeros(1,lxh-1)], ...
        [.8 .8 .8], 'edgecolor', 'none');
    xlabel('\tau'); legend('h(\tau)', 'x(t-\tau)', 't', 'h(\tau)x(t-\tau)');
    c = get(gca, 'children'); set(gca, 'children', [c(2);c(3);c(4);c(1)]);
    subplot(2,1,2), plot(tvec, y, 'k', tvec(ti), y(ti), 'ok');
    xlabel('t'); ylabel('y(t) = \int h(\tau)x(t-\tau) d\tau');
    axis([tau(1) tau(end) -1.5 2]); grid;
    drawnow;
end