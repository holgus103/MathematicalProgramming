function x = MidpointNonDifferenciable(a, b, f, e, de)
    function res = dr(y)
        res = (f(y + de) - f(y - de))/ 2 /de;
    end
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
    x = (b-a)/2;
end

