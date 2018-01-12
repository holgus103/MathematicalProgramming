function x = EliminationQR(A, b, D, c)
    n = size(A, 2); % variables
    m = size(A, 1); % conditions
    
    [Q, R] = qr(A');
    R = R(1:m, :);
    Q1 = Q(:, 1:m);
    Q2 = Q(:, m+1:n);
    
    S = Q1*inv(R');
    Z = Q2;
    
    x0 = S*b;
    x0
    y = -(inv(Z'*D*Z))*Z'*(c+D*x0); 
    x = x0 + Z*y;
    
end

