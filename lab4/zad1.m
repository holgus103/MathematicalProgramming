% zad 1
[f, g] = fun();
d = g(4, 4, -4);
ad = -d;
fx = @(x) f(ad(1) * x + 4, 4 + x*ad(2), -4 + ad(3) * x);
gx()
[x1, x2, x3] = GetRange(fx, 0, 0.05);
fplot(fx, [0, 1])
options = optimset('Display','iter');
opt = fminbnd(fx, 0, 1, options);
% zad 2 
y = Fibonacci(x1, x3, fx, 0.0001);

% zad 3
y2 = ArmijoII(fx, [ad(1) * 4, ad(2)*4, -4*ad(3)], x1, 0.5, 2, 0.0001)





