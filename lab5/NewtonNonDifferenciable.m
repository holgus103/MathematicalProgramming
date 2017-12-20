function x = NewtonNonDifferenciable(a, f, e, de)
    function res = dr(y)
        res = (f(y + de) - f(y - de))/ 2 / de;
    end
    function res = dr2(y)
        res = (f(y + de) - 2*f(y) + f(y - de)) / de / de;
    end
    ao = a - e - e;
    f1 = @(x) dr(x);
    f2 = @(x) dr2(x);
    while abs(a - ao) > e && abs(f1(a)) > e
        ao = a;
        a = a - (f1(a)/f2(a));
    end
    x = a;
end

