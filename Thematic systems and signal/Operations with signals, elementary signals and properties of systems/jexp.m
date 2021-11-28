function [y] = jexp(delta, w, t)
%s = delta +j*w
y = exp((delta+(1i*w))*t);
end

