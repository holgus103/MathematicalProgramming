% no entiengo que pasa

minR=-5;
maxR=5;
rangeR = [minR maxR];
n=3;
m=2;
D=randi(rangeR, n, n);
%symetryczna, dodatnio okreœlona
D=D*D';
c=randi(rangeR,n,1);
A=randi(rangeR,m,n);
b=randi(rangeR,m,1);
x0=zeros(n,1);
eps=0.00001;

disp(sprintf('Quadprog\n'))
x = quadprog(D,c,[], [], A, b);
disp(x);

disp(sprintf('Elimination\n'))
x = Elimination(A,b, D, c);
disp(x);


disp(sprintf('EliminationQR\n'))
x = EliminationQR(A,b, D, c);
disp(x);

%disp(sprintf('Eliminacja \n'))
%x = eliminacja(D,c,A,b);
%disp(x);


%disp(sprintf('Aktywne 1
%[x,f,~] = ogr_akt(D, c, A, b, x0, eps);
%disp(x')
%disp(f)

x = quadprog(D,c,A, b);
disp(sprintf('Eliminacja \n'))
x = ActiveCond(D,c,A,b, [], [], x0, eps);
disp(x);

x = GradientCasting(D,c,A,b, [], [], x0, eps);

