function res = ArmijoII(f, a, ro, k, e)
    fr = matlabFunction(f);
    dr = matlabFunction(diff(f));
    f0 = fr(0);
    d0 = dr(0);
    fa = fr(a);
    while 1
        if(fa > (f0 + ro * a * d0))
            % check if step is too small
            if((a - a/k) < e)
                res = a;
                return;
            end
            % contraction
            a = a/k;
            fa = fr(a);
            if(fa <= (f0 + ro * a * d0))
                res = a;
                return;
            end
        else
            res = a;
            return;
        end
    end
end