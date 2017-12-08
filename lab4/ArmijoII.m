function [res, i] = ArmijoII(f, g,  a, ro, k, e)
    fr = f;
    f0 = fr(0);
    d0 = sum(g);
    %sqrt(g(1)^2 + g(2)^2 + g(3)^2);
    fa = fr(a);
    i = 0;
    while 1
        i = i + 1;
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