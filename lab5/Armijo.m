function res = Armijo(f, a, ro, k, amax)
    fr = matlabFunction(f);
    dr = matlabFunction(diff(f));
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

