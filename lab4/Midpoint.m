% takes symbolic function as input
function x = Midpoint(a, b, f, e)
    dt = diff(f);
    dr = matlabFunction(dt);
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

