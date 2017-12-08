function [x, i] = Fibonacci(a, b, f, e)
    d1 = b - a;
    fib(1) = 1;
    fib(2) = 1;
    i = 2;
    while((d1 / e) > fib(i))
        i = i + 1;
        fib(i)  = fib(i - 1) + fib(i - 2);
    end
    % step 1
    d = b - a;
    x1 = a + fib(i - 2) / fib(i)*d;
    x2 = a + fib(i - 1) / fib(i)*d;
    fx1 = f(x1);
    fx2 = f(x2);
    for j= 2:(i-1)
        if(fx1 < fx2)
            b = x2;
            d = b - a;
            x2 = x1;
            fx2 = fx1;
            x1 = a + fib(i - j) / fib(i + 2 - j)*d;
            fx1 = f(x1);            
        else
            a = x1;
            d = b - a;
            x1 = x2;
            fx1 = fx2;
            x2 = a + fib(i + 1 - j) / fib(i + 2 - j)*d;
            fx2 = f(x2);   
        end
    end  
    x = x1;
end

