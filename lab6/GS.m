function [x, k] = GS(f, g, x0, delta, e, minimizer)
    x = x0;
    k = 0;
    grad = g(x);
    d = -grad;
    while norm(grad) > e
        old = x;
        oldgrad = grad;
        fun = @(alfa) f(x + alfa * d);
        [a, b, c] = GetRange(fun, 0, delta);
        res = minimizer(a, c, fun, e);
        x = x + res * d;
        grad = g(x);
        d = g(x) + norm(grad)^2/(norm(oldgrad)^2) * d;
        k = k + 1;
    end
end

