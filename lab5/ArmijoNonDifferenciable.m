function res = ArmijoNonDifferenciable(f, a, ro, k, amax, de)
    function res = dr(y)
        res = (f(y + de) - f(y - de))/ 2 /de;
    end
    fr = f;
    f0 = fr(0);
    d0 = dr(0);
    fa = fr(a);
    while 1
        if(fa <= (f0 + ro * a * d0))
            % expansion
            if(k*a > amax)
                res = a;
                return;
            end
            a = k*a;
            fa = fr(a);
            if(fa > (f0 + ro * a * d0) )
                res = a;
                return;
            end
        else
            % contraction
            a = a/k;
            fa = fr(a);
            if(fa <= (f0 + ro * a * d0))
                res = a;
                return;
            end
        end
    end
end

