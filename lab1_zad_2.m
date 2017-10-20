% min(5x1 + 2x2 + 3x3 + 5x4)
% x in omega
% x1 - x2 + 7x3 + 3x4 >= 4
% x1 + 2x2 + 2x3 + x4 = 9
% 2x1 + 3x2 + x3 - 4x4 <= 5
% x >= 0

f = [5; 2; 3; 5];
A = [-1, 1, -7, -3; 2, 3, 1, -4];
b = [-4, 5];
Aeq = [1, 2, 2, 1]
beq = [9]
lb = [0, 0, 0, 0];
options = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'iter');
[x, fval, exitflag, output, lambda] = linprog(f, A, b, Aeq, beq, lb, [], options);