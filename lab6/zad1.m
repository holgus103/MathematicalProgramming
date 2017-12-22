% zad 1
options = optimset('GradObj','on', 'Display', 'iter'); 
x0 = [2; -1; 1]
[xmin,fval,exitflag,output]  = fminunc(@func, x0, options);

options = optimset('Display', 'iter'); 
x0 = [2; -1; 1]
[xmin,fval,exitflag,output]  = fminsearch(@func, x0, options);

[f, g] = fun();

% zad 2
[x, it] = GS(@(x)f(x(1), x(2), x(3)), @(x)g(x(1), x(2), x(3)), x0', 0.1, 0.000001, @Fibonacci, 1)
[x, it] = GS(@(x)f(x(1), x(2), x(3)), @(x)g(x(1), x(2), x(3)), x0', 0.1, 0.000001, @ArmijoII, 2)


% zad 3
[x, it] = NS(@(x)f(x(1), x(2), x(3)), @(x)g(x(1), x(2), x(3)), x0, 0.0001, 0.1, @Fibonacci, 1);
[x, it] = NS(@(x)f(x(1), x(2), x(3)), @(x)g(x(1), x(2), x(3)), x0, 0.0001, 0.1, @ArmijoII, 2);