function [x,flag] = Simplex(f, A, b)
    n=length(f);
    m=length(b);
    n = n + m;
    % extend A
    A = [A eye(m)];
    % allocate z
    z = zeros(1, n);
    % assign c
    c = [f zeros(1,m)];
    % calculate z - c
    zmc = z-c;
    % assign value vector
    bf = b;
    % assign base values
    base = zeros(m, 1);
    % get base indexes
    baseIndexes = (n - m)+1 : n;   
    it = 1;
    while 1
        % check for success
        if(all(zmc >= 0))
            x = bf;
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
            r = find(newBf == valr); 
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

