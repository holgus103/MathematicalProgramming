function [x, it, fval, lambdas]  = ActiveCond(D, c, A, b, Aeq, beq, x0, eps)
    neq = length(beq);
    n = length(b);
    m = size(D, 2);
    % mark active conditions
    active = [ones(1, neq) zeros(1, n)];
    for i = 1:n
        if(abs(A(i, :) * x0 - b(i)) <eps)
            active(i) = 1;
        end
    end
    x = x0;
    it = 0;
    while 1
        
        % step 1
        g = D*x + c;
        
        %step 2 - create subproblem
        subA = Aeq;
        % for every active condition
        for i = 1:n
            if(active(i) == 1)
                subA = [subA; A(i, :)];
            end
        end
        % KTC
        activeCount = size(subA, 1);
        E = [D subA'; subA zeros(activeCount)];
        F = [-g; zeros(activeCount, 1)];
        sol = inv(E) * F;
        % find direction
        d = sol(1:m);
        lambdas = sol(m+1:end);
        if(norm(d)< eps)
            % check for exit condition
            % step 6
            [val, removeIndex] = min(lambdas);
            if(val >=0)
                % exit, all lambdas >= 0
                fval = 0.5 *x'*D*x + c' * x ;
                
                return;
            else
                counter=0;
                for i=1:n
                   if active(neq+i)==1
                      counter=counter+1;
                      if counter==removeIndex
                          active(neq+i)=0;
                      end
                   end
                end
            end
        else
            % step 4 - calculate step
            
            Ad=A*d;
            alfa=1;
            % for all nonactive conditions check the max step
            for i=1:n
                if Ad(i)>0 && active(i)==0 
                    newAlpha=(b(i)-A(i,:)*x)/Ad(i);
                    if newAlpha<alfa
                       alfa=newAlpha; 
                    end
                end
            end
            
            % update optimal solution
            x = x + d*alfa;
            it = it + 1;
            
            % update active conditions
            active = [ones(1, neq) zeros(1,n)];
            for i = 1:n
                if(abs(A(i, :) * x - b(i)) <eps)
                    active(i+neq) = 1;
                else
                    active(i+neq) = 0;
                end
            end

        end     
    end 
end

