function [x,it] = DFP(f, g, x0, delta, e, minimizer)
    n = size(x0, 2);
    x = x0;
    H = eye(n);
    it = 0;
    grad = g(x);
    while(norm(grad) > e)
        oldx = x;
        oldgrad = grad;
        d = -H * grad';
        fun = @(alfa) f(x + alfa * d');
        [a, b, c] = GetRange(fun, 0, delta);
        res = minimizer(a, c, fun, e);
        x = x + res * d';
        grad = g(x);
        r = grad - oldgrad;
        s  = x - oldx;
        
        H = H + (s' * s)/(s*r') ...
            - (H * r' * r * H)/(r * H  * r');
        
        it = it + 1;
    end
end

