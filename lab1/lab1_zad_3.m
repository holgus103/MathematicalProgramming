% cutting planks
f = [1; 1; 1];
A = [-2 -1 0; -1 -4 -6];
b = [-21, -14];
lb = [0, 0, 0]
options = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'iter');
[x, fval, exitflag, output, lambda] = linprog(f, A, b, [], [], lb, [], options);