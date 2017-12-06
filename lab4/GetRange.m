function x = GetRange(f, a, delta)
    b = a + delta;
    if(f(a) <= f(b))
        a1 = a;
        a3 = b;
        a2 = (a1 + a3)/2
        while(f(a1) < f(a2) || f(a3) < f(a2))
            a2 = (a1 + a2) / 2;
        end
    else
        a2 = b;
        a1 = a;
        a3 = a2 + delta;
        while(f(a1) < f(a2) || f(a3) < f(a2))
            delta = 2 * delta;
            a3 = a2 + delta;
        end
    end
    x = [a1, a2, a3];
end

