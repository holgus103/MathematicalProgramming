function [x,flag] = SimplexM(f, A, b, M)
    m=length(b);
    f = [f repelem(-M, m)]
    n=length(f);
    % extend A
    A = [A eye(m)];
    % assign c
    c = f;
    % assign base values
    base = repelem(-M, m);
    % allocate z
    for i = 1:n
        z(i) = dot(base, A(:, i));
    end

    % calculate z - c
    zmc = z-c;
    % assign value vector
    bf = b;

    % get base indexes
    baseIndexes = (n - m + 1) : n;   
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
                        return;
                    end
                end
            end
            % no contradiction
            % get minimum value
            [valk, k] = min(zmc);
            % find row 
            newBf = bf ./ transpose(A(:, k));
            valr = min(newBf(newBf > 0));
            r = find(newBf == valr, 1); 
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

