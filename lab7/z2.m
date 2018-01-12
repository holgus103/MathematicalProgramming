    D=diag([2;2;2;6]);  
    
    c=[-1;-4;1;2];
    
    A=[ 2,  5,  4, -3;  
        1, -1,  1, -1];
    
    b=[4;2];
    
    x0=[-1;-1;-1;1];
    
   [x,fval,exitflag,output,lambda] = quadprog(D, c, A, b)
   lambda.ineqlin
   
   [x, it, fval, lambdas] = ActiveCond(D, c, A, b, [],[], x0, 0.000001);