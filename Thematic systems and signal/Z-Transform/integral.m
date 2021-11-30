fun = @(t) t.*(u(t)-u(t-2));

q = integral(fun, 0, 2)