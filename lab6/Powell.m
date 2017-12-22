function [x, it] = Powell(f, x0, U, e, delta, minimizer, N)
    function res = minimize(x, d)
            fun = @(a)f(x + a * d);
            [a, b, c] = GetRange(fun, 0, delta);
            res = minimizer(a, c, fun, e);
    end
    function x = tryBothDirections(x, d)
        res = minimize(x, d);
        if(res < e || norm(f(x + res * d) - f(x)) < e)
            d = -d;
            res = minimize(x, d);
        end
        x = x + res * d; 
    end
    it = 0;
    n = size(U, 1);
    while it < N
        x = x0;
        for i = 1:n
            x = tryBothDirections(x, U(i, :));            
        end
        if(norm(x0 - x) < e || norm(f(x) - f(x0)) < e)
            break; % finito amigo
        end
        for i = 1:(n-1)
            U(i, :) = U(i+1, :);
        end
        U(n, :) = x - x0;
        U(n, :) = U(n, :) / norm(U(n, :));
        d = U(n, :);
        x = tryBothDirections(x, d);
        x0 = x;
        it = it + 1;
    end
end

