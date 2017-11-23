function [x,flag] = PerturbationMethod(f, A, b)
    n=length(f);
    m=length(b);
    n = n;
    % allocate z
    z = zeros(1, n);
    % assign c
    c = f;
    % calculate z - c
    zmc = z-c;
    % assign value vector
    bf = b;
    % assign base values
    base = c(1:m);
    % get base indexes
    baseIndexes = 1:m;   
    it = 1;
    while 1
        % check for success
        if(all(zmc >= 0))
            x = zeros(1, n);
            x(baseIndexes) = bf;
            x = x(1:(n - m));
            flag = 1;
            return;
        else
            % check if solution exists
            for i = 1 : n
                % for every z-c < 0
                if(zmc(i) < 0)
                    if(all(A(:,i)<= 0))
                        % contradiciton
                        flag = -1;
                        x = [];
                        return;
                    end
                end
            end
            % no contradiction
            % get minimum value
            [valk, k] = min(zmc);
            % find row 
            validRows = find(A(:, k) > 0);
            newBf = bf(validRows) ./ transpose(A(validRows, k));
            valr = min(newBf(newBf >= 0));
            r = find(newBf == valr);
            if(length(r) >1)
                column = 1;
                while(length(r) > 1 && column < k)
                   validRows = find(A(:, k) > 0);
                   newBf = A(r, column) ./  A(r, k);
                   valr = min(newBf(newBf >= 0));
                   r = find(newBf == valr);
                end
            end
            r = validRows(r);
            eg = A(r, k);
            % divide row by main element
            A(r, :) = A(r,:) ./ eg;
            bf(r) = bf(r)/eg;
            for i = [1:(r-1), (r+1):m]
                el = A(i, k);
                A(i, :) = A(i,:) - el * A(r, :);
                bf(i) = bf(i) - el * bf(r);
            end
            baseIndexes(r) = k;
            base(r) = c(k);
            for i = 1:n
                z(i) = dot(base, A(:, i));
            end
            zmc = z - c; 
        end
    end
end

