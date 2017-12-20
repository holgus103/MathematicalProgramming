function x = Newton(a, f, e)
    ao = a - e - e;
    f1 = matlabFunction(diff(f));
    f2 = matlabFunction(diff(diff(f)));
    while abs(a - ao) > e && abs(f1(a)) > e
        ao = a;
        a = a - (f1(a)/f2(a));
    end
    x = a;
end

