function [x, k] = GS(f, g, x0, delta, e, minimizer, t)
    x = x0;
    k = 0;
    grad = g(x);
    d = -grad;
    while norm(grad) > e
        old = x;
        oldgrad = grad;
        fun = @(alfa) f(x + alfa * d');
        [a, b, c] = GetRange(fun, 0, delta);
        if(t == 1)
            res = minimizer(a, c, fun, e);
        else
            res = minimizer(fun, d' * grad ,1, 0.2, 2, e);
        end
        x = x + res * d';
        grad = g(x);
        %d = -g(x) + norm(grad)^2/(norm(oldgrad)^2) * d;
        d = -g(x) + (grad - oldgrad) * grad' / (norm(oldgrad)^2) * d;
        k = k + 1;
    end
end

