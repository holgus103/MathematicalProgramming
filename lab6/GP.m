function [x, it] = GP(f, g, x0, alfa, e)
    x = x0;
    it = 1;
    while 1
        old = x;
        x = x - alfa * g(x);
        if(norm(old - x) <= e)
            break;
        end
       it = it + 1; 
    end
end

