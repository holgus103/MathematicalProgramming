function [x, it] = NS(f, g, x0, e, delta, minimizer, t)
    x = x0;
    it = 1;
    while 1
        old = x;
        grad = g(x);
        fun = @(alfa)f(x - alfa * grad);
        [a, b, c] = GetRange(fun, 0, delta);
        if(t == 1)
            res = minimizer(a, c, fun, e);
        else            
            fx = @(a) f(x - grad * a);
            [a, b, c] = GetRange(fx, 0, 0.1);
            res = minimizer(fx, -grad .* grad ,1, 0.2, 2, e);

        end
        x = x - res * grad;
        if(norm(grad) < e || (norm(x - old) < e))
            break;
        end 
        it = it + 1;
    end
end

