function [x,flag] = DualSimplex(f, A, b)
    n=length(f);
    m=length(b);
    n = n + m;
    % extend A
    A = [A -eye(m)];
    A = -A;
    % allocate z
    z = zeros(1, n);
    % assign c
    c = -[f zeros(1,m)];
    % calculate z - c
    zmc = z-c;
    % assign value vector
    b = -b;
    bf = b;
    % assign base values
    base = zeros(m, 1);
    % get base indexes
    baseIndexes = (n - m)+1 : n;   
    it = 1;
    while 1
        % check for success
        if(all(bf >= 0))
            x = zeros(1, n);
            x(baseIndexes) = bf;
            x = x(1:(n - m));
            flag = 1;
            return;
        else
            % get minimum value and row index
            [valr, r] = min(b);
            
            % check if solution exists
            if(all(A(1, :)>=0))
                % contradiciton
                flag = -1;
                x = [];
                return;
            end            
            % no contradiction
            % find column
            tmp = zmc ./ A(r, :);
            valk = max(tmp(tmp<0));
            k = find(tmp == valk); 
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

