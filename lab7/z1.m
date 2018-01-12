   D=[ 17,   -14,    21 ;
       -14,    29,    -6 ;
        21,    -6,    34  ];
    
   c=[-1;-4;1];
    
   A=[ 2, 5 , 4;   
        2, 1,  -1];
    
   b=[3;4];
   x0=[1;1;-1]; 
   
   [x,fval,exitflag,output,lambda] = quadprog(D, c, A, b)
   lambda.ineqlin
   
   [x, it, fval, lambdas] = ActiveCond(D, c, A, b, [],[], x0, 0.000001);
   