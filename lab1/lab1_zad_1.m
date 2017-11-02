clc
% solve
f = [2; -3];
A = [1, -2; 6, 5; 3, -1; 1, 3];
b = [2; 15; 5; 6];
lb = [0; -Inf];
ub = [Inf; 0];
options = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'iter');
[x, fval, exitflag, output, lambda] = linprog(-f, A, b, [], [], lb, ub, options);
% draw chart
x1 = -2:0.1:2;
x2 = x1;
[X1, X2] = meshgrid(x1, x2);
hold on
grid on
F = f(1).* X1 + f(2).* X2;
[C, h] = contour(X1, X2, F, 'b-');
clabel(C,h)

% mark inner area
for i = 1:4
    G = A(i, 1) .* X1 + A(i, 2) .* X2 - b(i);
    contour(X1, X2, G, [0 0], 'r-');
    contour(X1, X2, G, -0.1:-0.1:-0.3, 'g-');
    % attach labels
    %gtext(sprintf('%d', i));
end
% find x1 and x2 for opt value
x_opt = [A(1,:); A(3,:)] \ [b(1); b(3)]
f_opt = f'*x_opt