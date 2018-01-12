function x = GradientCasting(D, c, A, b, Aeq, beq, x0, eps)
    neq = length(beq);
    n = length(b);
    m = length(x0);
   
    x = x0;
    it = 0;

    while true
        A1 = [];
        A2 = [];
        % step 1
        Uk = Aeq';
        % evaluate conditons and append to Uk
        p = 0;
        m2 = size(Aeq, 1);
        for i= 1:neq
            if(abs(A(i, :) * x - b(i)) < eps)
                Uk = [A(i, :)' Uk];
                p = p+1;
                % append condition to equality matrix
                A1 = [A1; A(i, :)];
            else
                % append condition to le matrix
                A2 = [A2; A(i, :)];
            end
        end
        r = p + m2;
        % step 2 - get Pk matrix
        if(abs(r) < eps)
            Pk = eye(m);
        else
            Pk = Pk - Uk*(inv(Uk'*Uk))*Uk';
        end

        grad = D * x + c;
        % step 3 - get direction vector
        dk = -Pk * grad;

        if(norm(dk) < eps)
            % step 4 - check exit condition
            if(abs(r) < eps)
                return;
            else
                lambdas = -inv(Uk' * Uk) * Uk' * grad;
                lambdap = lambdas(1:p);
                lambdam2 = lambdas(p1:m2);
                % check another exit condition
                % step 5
                if(norm(lambdap))
                    return;
                end
                % step 6
                [min, index] = min(lambdap);
                p = p - 1;
                r = r - 1;
                Uk(:, index) = [];
            end
        else
            % step 7
            % get step 
            alfa = (-grad'*dk)/(dk'*D*dk);  
            alfa_max=Inf;
            Ad = [];
            if(A2 ~= [])
                Ad=A2*dk;
            end
            % calculate max step
            for i=1:length(Ad)
                if Ad(i)>0
                    alfa_tmp=(b(i)-A(i,:)*x)/Ad(i);
                    if alfa_tmp<alfa_max
                       alfa_max=alfa_tmp; 
                    end 
                end
            end
            % saturate step
            if alfa>alfa_max
               alfa=alfa_max;
            end
            
            x = x + dk * alfa;
            it = it + 1;
        end
    end
end

