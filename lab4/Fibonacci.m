function x = Fibonacci(a, b, f, n)
    fib = zeros(1, n + 1);
    fib(1) = 1;
    fib(2) = 1;
    for i = 3:(n + 1)
        fib(i)  = fib(i - 1) + fib(i - 2);
    end
    % step 1
    d = b - a;
    x1 = a + fib(n - 1) / f(n + 1)*d;
    x2 = a + fib(n) / f(n + 1)*d;
    fx1 = f(x1);
    fx2 = f(x2);
    for i= 2:(n-1)
        if(fx1 < fx2)
            b = x2;
            d = b - a;
            x2 = x1;
            fx2 = fx1;
            x1 = a + fib(n - i) / fib(n + 2 - i)*d;
            fx1 = f(x1);            
        else
            a = x1;
            d = b - a;
            x1 = x2;
            fx1 = fx2;
            x2 = a + fib(n + 1 - i) / fib(n + 2 - i)*d;
            fx2 = f(x2);   
        end
    end  
    x = x1;
end

