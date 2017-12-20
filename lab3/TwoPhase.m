function [x,flag] = TwoPhase(f, A, b)
    n=length(f);
    m=length(b);
    n = n + m + m;
    % extend A
    A = [A -eye(m) eye(m)];
    % allocate z
    z = zeros(1, n);
    % assign c
    c = zeros(1, n);
    % assign value vector
    bf = b;
    % assign base values
    base = -ones(1, m);
    c((n - m + 1): n) = -ones(1, m);
    for i = 1:n
        z(i) = dot(base, A(:, i));
    end
    % calculate z - c
    zmc = z-c;

    % get base indexes
    baseIndexes = (n - m)+1 : n;   
    it = 1;
    [A, x, baseIndexes, base, bf] = solve(A, bf, baseIndexes, base, z, zmc, c, n, m);
    n = n - m;
    A = [A(:, 1:(n))];
    z = zeros(1, n);
    c = [f  zeros(1, m)];
    base = c(baseIndexes);
    for i = 1:n
        z(i) = dot(base, A(:, i));
    end
    zmc = z - c;
    [A, x, baseIndexes, base, bf] = solve(A, bf, baseIndexes, base, z, zmc, c, n, m);
end

function [A, x, baseIndexes, base, bf] = solve(A, bf, baseIndexes, base, z, zmc, c, n, m)
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
