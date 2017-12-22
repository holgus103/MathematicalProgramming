function [f,grad, hes] = func(x)
    f=(x(1)-x(2))^4+(x(2)-2*x(3))^2+(2*x(3)-x(1))^2;
    x1=x(1);
    x2=x(2);
    x3=x(3);
    
    grad1= 4 *(x1-x2)^3 -2*(x3-x1);
    grad2= -4 *(x1-x2)^3 + 2 *(x2 - 2 *x3);
    grad3= -4 *(x2 - 2*x3) + 4 * (2* x3 - x1);
    grad = [grad1; grad2; grad3];
    
end