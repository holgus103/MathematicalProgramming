function x = MidpointFunctionHandles(a, b, f, g, e)
    dr = g
    while((b - a) > e)
        z = (a + b) / 2;
        if(dr(z) > 0)
            b = z;
        else
            if(dr(z) < 0)
                a = z;
            else
                x = z;
                break;
            end
        end
    end
    x = (b+a)/2;
end
