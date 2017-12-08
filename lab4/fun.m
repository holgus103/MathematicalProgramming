function [v, g] = fun()
    syms f(x1, x2, x3);
    f(x1, x2, x3) = (x1 - x2)^4 + (x2 - 2*x3)^2 + (2*x3 - x1)^2;
    v = matlabFunction(f);
    g = matlabFunction(gradient(f));
end

