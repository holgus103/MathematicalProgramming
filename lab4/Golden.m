function x = Golden(a, b, f, e)
% step 1
    c = 0.61804;
    d = b - a;
    x1 = b - c*d;
    x2 = a + c*d;
    fx1 = f(x1);
    fx2 = f(x2);
    % step 2
    while(d >= e)
        if(fx2 > fx1)
            % step 3
            b = x2;
            d = b - a;
            x2 = x1;
            fx2 = fx1; 
            x1 = b - c*d;
            fx1 = f(x1);
        else
            % step 4
            a = x1;
            d = b - a;
            x1 = x2;
            fx1 = fx2;
            x2 = a + c*d;
            fx2 = f(x2);
        end
    end
    x = (a + b) / 2;
end

