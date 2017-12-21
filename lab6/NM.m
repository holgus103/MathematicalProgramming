function p = NM(f, n, e, alfa, beta, gamma, delta)
    vert = [eye(n); [1 1] zeros(1, n-2)]; 
    fxs = zeros(n, 1);
    while 1
        for i = 1:(n+1)
            fxs(i) = f(vert(i, 1:n));
        end
        [valmin, mini] = min(fxs);
        [valmax, maxi] = max(fxs);
        pmin = vert(mini, 1:n);
        pmax = vert(maxi, 1:n);
        finito = 1;
        for i = 1:(n+1)
            if(norm(pmin - vert(i, 1:n)) > e)
                finito = 0;
            end
        end

        sum = 0;
        for i = 1:(n+1)
            if(i == maxi)
                continue;
            end
            sum = sum + vert(i, 1:n);
        end
        p = sum / n;
        if(finito == 1)
            return;
        end
        pr = p + alfa*(p - pmax);
        if(f(pr) < f(pmax))
            pe = p + beta*(pr - p);
            if(f(pe) < f(pr))
                vert(maxi, 1:n) = pe;
                pmax = pe; %expand
            else
                vert(maxi, 1:n) = pr;
                pmax = pr; % reflect
            end
        else
            if(f(pmin) <= f(pr) && f(pr) < f(pmax))
                pmax = pr;
                vert(maxi, 1:n) = pr; % reflect
            else
                pc = p + gamma*(pmax - p);
                if(f(pc) >= f(pmax))
                    for i = 1:(n+1)
                        if(i == mini)
                            continue
                        end
                        vert(i, 1:n) = delta*(vert(i, 1:n) + pmin);
                    end
                    %reduction
                else
                    pmax = pc;
                    vert(maxi, 1:n) = pc; % contraction
                end
            end
                
        end
    end
end

