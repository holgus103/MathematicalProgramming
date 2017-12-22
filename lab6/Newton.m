function [x, it] = Newton(f, g, h, x0, e)
    x = x0;
    it = 0;
    grad = g(x);
    d = -inv(h(x)) * grad';
    while norm(grad) > e
        x = x + d';
        grad = g(x);
        d = -inv(h(x)) * grad';
        it = it + 1;
    end
end

