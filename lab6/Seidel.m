function [x, i] = Seidel(f, x0, k, delta, minimizer, e) 
    n = size(x0, 2);
    x = x0;
    vec = eye(n);
    vec = [vec ;-vec];
    for i = 2*n
        v = vec(i, 1:n);
        fun = @(alfa) f(x + alfa * v);
        [a, b, c] = GetRange(fun, 0, delta);
        res = minimizer(a, c, fun, e);
        x = x + res * v;
        if(abs(res) < e)
            return;
        end
        if(i >= k)
            return;
        end
        k = k + 1;
    end
end

