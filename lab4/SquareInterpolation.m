function x = SquareInterpolation(a, d, f, e)
    function res =  NextA()
        res = (f1*(x2^2 - x3^2) + f2*(x3^2 - x1^2) + f3*(x1^2 - x2^2)) ...
            / (f1*(x2 - x3) + f2*(x3 - x1) + f3*(x1 - x2));
    end

    [x1, x2, x3] = GetRange(f, a, d);
    while 1
        f1 = f(x1);
        f2 = f(x2);
        f3 = f(x3);
        a = NextA();
        if(abs((a - x2)) < e)
            x = a;
            return;
        end
        fa = f(a);
        if(a < x2)
            if(fa <= f2)
                x3 = x2;
                f3 = f2;
                x2 = a;
                f2 = fa;
            else
                x1 = a;
                f1 = fa;
            end
        else
            if(f2 >= fa)
                x1 = x2;
                f1 = f2;
                x2 = a;
                f2 = fa;
            else
                x3 = a;
                f3 = fa;
            end
        end  
    end
end



