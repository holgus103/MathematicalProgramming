function xb = HJ(f, x0, e, delta, alfa, beta, maxIter)
    function [xr, oldx0, fail] = trialStage(x0, maxIter)
        fail = 0;
        oldx0 = x0;
        k = 0;
        while 1
            xr = x0;
            fx = f(x0);
            for i = 1:n
                xn = xr + delta * vec(i, 1:n);
                fn = f(xn);
                if(fx > fn)
                    oldx0 = xr;
                    xr = xn;
                    fx = fn;
                else
                    xn = xr - delta  * vec(i, 1:n);
                    fn = f(xn);
                    if(fx > fn)
                        oldx0 = xr;
                        xr = xn;
                        fx = fn;
                    else
                        if(k == maxIter)
                            fail = 1;
                            return;
                        end
                        delta = beta * delta;
                        if(delta < e)
                            fail = 1;
                            return;
                        end
                        break;
                    end
                end
            end
            if(i == n)
                return;
            end
            k = k + 1;
        end
    end
    
    xb = x0;
    oldx = x0;
    n = size(x0, 2);
    vec = eye(n);
    while 1

        [xb, oldx, fail] = trialStage(xb, maxIter);
        if(fail == 1)
            return;
        end
        
         x = xb + alfa*(xb - oldx);
        
        [xt, a, fail] = trialStage(x, 1);
        if(fail == 0)
            xb = xt;
            oldx = a;
        else
            delta = delta * beta;   
            if(delta < e)
                return;
            end
        end
            
    end
end

