function [a,b,c,d] = natural_splines(X,Y)
    n = length(X);
    a = Y; 
    b = zeros(1,n-1);
    c = zeros(1,n);
    d = zeros(1,n-1);
    h = zeros(1,n);
    for i = 1:n-1 % STEP 1
        h(i) = X(i+1)-X(i);
    end
    alp = zeros(1,n);
    for i = 2:n-1 % STEP 2
        alp(i) = (3/h(i))*(a(i+1)-a(i))-(3/h(i-1))*(a(i)-a(i-1));
    end
    L = zeros(1,n); % STEP 3
    L(1) = 1; 
    mu = zeros(1,n);
    mu(1) = 0;
    z = zeros(1,n);
    z(1) = 0;
    for i = 2:n-1 % STEP 4
        L(i) = 2*(X(i+1)-X(i-1))-h(i-1)*mu(i-1);
        mu(i) = h(i)/L(i);
        z(i) = (alp(i)-h(i-1)*z(i-1))/L(i);
    end
    L(n) = 1; % STEP 5
    z(n) = 0;
    c(n) = 0;
    for j = n-1:-1:1 % STEP 6
        c(j) = z(j)-mu(j)*c(j+1);
        b(j) = (a(j+1)-a(j))/h(j)-h(j)*(c(j+1)+2*c(j))/3;
        d(j) = (c(j+1)-c(j))/(3*h(j));
    end
a = a(1:end-1); b; c = c(1:end-1); d;
end