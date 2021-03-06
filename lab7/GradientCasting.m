function x = GradientCasting(D, c, A, b, Aeq, beq, x0, eps)
    neq = length(beq);
    n = length(b);
    m = length(x0);
    Pk = [];
    x = x0;

    it = 0;
        A1 = [];
        b2 = []';
        A2 = [];
        % step 1
        Uk = Aeq';
        % evaluate conditons and append to Uk
        p = 0;
        m2 = size(Aeq, 1);
        for i= 1:n
            if(abs(A(i, :) * x - b(i)) < eps)
                Uk = [A(i, :)' Uk];
                p = p+1;
                % append condition to equality matrix
                A1 = [A1; A(i, :)];
            else
                % append condition to le matrix
                A2 = [A2; A(i, :)];
                b2 = [b2; b(i)];
            end
        end
        r = p + m2;
    while true

        % step 2 - get Pk matrix
        if(abs(r) < eps)
            Pk = eye(m);
        else
            Pk = eye(m) - Uk*(inv(Uk'*Uk))*Uk';
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
                lambdam2 = lambdas(p+1:m2);
                % check another exit condition
                % step 5
                [val, index] = min(lambdap);
                if(val>=0)
                    return;
                end
                % step 6

                p = p - 1;
                r = r - 1;
                Uk(:, index) = [];
            end
        else
            % step 7
            % get step 
            alfa = (-grad'*dk)/(dk'*D*dk); 
            %alfa 
            %dk
            %f = @(alfa) 0.5 * (x + alfa * dk)' * D * (x + alfa * dk) + c' * (x + alfa * dk);
            %alfa = Fibonacci(0, alfa, f, 0.0001);
            alfa_max=Inf;
            Ad = [];
            if(~isempty(A2))
                Ad=A2*dk;
            end
            % calculate max step
            for i=1:length(Ad)
                if Ad(i)>0
                    alfa_tmp=(b2(i)-A2(i,:)*x)/Ad(i);
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
            A1 = [];
            A2 = [];
            b2 = []';
            % step 1
            Uk = Aeq';
            % evaluate conditons and append to Uk
            p = 0;
            m2 = size(Aeq, 1);
            for i= 1:n
                if(abs(A(i, :) * x - b(i)) < eps)
                    Uk = [A(i, :)' Uk];
                    p = p+1;
                    % append condition to equality matrix
                    A1 = [A1; A(i, :)];
                else
                    % append condition to le matrix
                    A2 = [A2; A(i, :)];
                    b2 = [b2; b(i)];
                end
            end
            r = p + m2;
            end
    end
end

