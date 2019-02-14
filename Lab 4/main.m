X = [-2.4061, -1.083, -0.644, -0.4068, -0.2448, -0.1158, 0, 0.1158, 0.2448, 0.4068, 0.644, 1.083, 2.4061];
Y = [-0.3984, -0.7611, -0.9688, -0.9791, -0.7899, -0.4397, 0, 0.4397, 0.7899, 0.9791, 0.9688, 0.7611, 0.3984];

% Question 1
[a,b,c,d] = natural_splines(X,Y)
n = length(X);
x = linspace(-2,2,10);
for i = 1:length(x)
    for j = 1:n-1
        if X(j) <= x(i) && x(i) <= X(j+1)
            S(i) = a(j)+b(j)*(x(i)-X(j))+c(j)*(x(i)-X(j))^2+d(j)*(x(i)-X(j))^3;
            break
        end
    end 
end
S % cubic spline interpolants
subplot(3,1,1);
plot(x,S);

% Question 2
subplot(3,1,2);
for i = 1:length(x)
    L(i) = f_lagrange(X,Y,x(i));
end
L % coefficients of lagrange polynomial
plot(x,L)

% Question 3
subplot(3,1,3);
for i = 1:length(x)
    y(i) = x(i)/(1/4+x(i)^2); 
end
y = double(y) % actual function f(x) evaluated with x
plot(x,y)

error1 = double(y - S) % error between function and cubic spline interp.
error2 = double(y - L) % error between function and lagrange interp.

syms f(y)
f(y) = y/(1/4+y^2);
df = diff(f,y,4);
for i = 1:n
    M(i) = abs(double(df(X(i))));
end
M = max(M); % maximum differential of x at degree 4
for j = 1:length(x)
    m(j) = abs((X(j+1)-X(j)))^4;
end
m = max(m); % maximum difference of x(j+1) and x(j) to the power of 4

max_error = 5*M*m/384 % fourth-order error-bound



