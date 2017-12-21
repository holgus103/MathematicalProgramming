function [x, it] = NS(f, g, x0, e, delta, minimizer)
    x = x0;
    it = 1;
    while 1
        old = x;
        grad = g(x);
        fun = @(alfa)f(x - alfa * grad);
        [a, b, c] = GetRange(fun, 0, delta);
        res = minimizer(a, c, fun, e);
        x = x - res * grad;
        if(norm(grad) < e || (norm(x - old) < e))
            break;
        end 
        it = it + 1;
    end
end

