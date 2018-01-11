function x = Elimination(A, b, D, c)
    n = size(A, 2); % variables
    m = size(A, 1); % conditions
    
    C = [A', [zeros(m,n-m); eye(n-m)]];
    C1 = inv(C);
    
    S = C1(1:m, :)';
    Z = C1(m:n, :)';
    
    x0 = S*b;
    
    y = -(inv(Z'*D*Z))*Z'*(c+D*x0); 
    x = x0 + Z*y;

end

