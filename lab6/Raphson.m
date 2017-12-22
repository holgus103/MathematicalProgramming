function x = Raphson(f, g, h, x0, e, minimizer, delta)
    x = x0;
    it = 0;
    grad = g(x);
    d = -inv(h(x)) * grad';
    while norm(grad) > e
        fun = @(a) f(x + a * d);
        gfun = @(a) g(x + a * d) .* d
        [a, b, c] = GetRange(fun, 0, delta);
        res = minimizer(a, c, f, gfun, e);
        x = x + res * d';
        grad = g(x);
        d = -inv(h(x)) * grad';
        it = it + 1;
    end
end

