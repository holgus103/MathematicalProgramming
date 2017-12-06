function x = Dichotomy(a, b, f, e)
% step 1
    xm = (a + b)/2;
    d = b - a;
    fxm = f(xm);
    
    while d > (2*e)
        % step 2
        x1 = a + (d/4);
        x2 = b - (d/4);
        fx1 = f(x1);
        fx2 = f(x2);
        % step 3
        if(fx1 < fxm)
            b = xm;
            d = b - a;
            xm = x1;
            fxm = fx1;
        else
            % step 4
            if(fx2 < fxm)
                a = xm;
                d = b - a;
                xm = x2;
                fxm = fx2;
            else
                % step 5
                a = x1;
                b = x2;
                d = b - a;
            end
        end
    end
    x = xm;
end

