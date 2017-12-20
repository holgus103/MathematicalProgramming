f = [8;-1;6;0];
A = [-6,-6,-3,3; -2, 6, 5, 0; 4, 4, -6, -4];
b = [-8; -7; -3];
lb = [0;0;0;0];
ub = [];
options = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'iter');
[x, fval, exitflag, output, lambda] = linprog(f, A, b, [], [], lb, ub, options);

f = [-1;-8;-3;5; -3];
A = [-3,-2,8,-3,8; 7, 7, 1, -3, -6; 7, -2, 6, -1, 3; 0, 4, 5, 0, -3];
b = [-18; -20; -18; -14];
lb = [0;0;0;0];
ub = [];
options = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'iter');
[x2, fval2, exitflag, output, lambda] = linprog(f, A, b, [], [], lb, ub, options);

