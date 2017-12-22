function x = HJ(f, x0, e, delta, alpha, beta)    
    x = x0;
    oldx = x0;
    n = size(x0, 2);
    vec = eye(n);
    while delta > e
        while delta > e
            fx = f(x);
            for i = 1:n
                xn = x + delta * vec(i, 1:n);
                fn = f(xn);
                if(fx > fn)
                    x = xn;
                    fx = fn;
                else
                    x = x - delta  * vec(i, 1:n);
                    fn = f(xn);
                    if(fx > fn)
                        x = xn;
                        fx = fn;
                    end
                end
            end
            if(oldx == x)
                delta = delta * beta;
            else
                if f(x)>=f(oldx)
                    x = oldx;
                    delta = delta*beta;
                else
                    break;
                end
            end
        end
        oldoldx = oldx;
        oldx = x;
        x = alpha*(oldx - oldoldx);
   end
            
end

    

