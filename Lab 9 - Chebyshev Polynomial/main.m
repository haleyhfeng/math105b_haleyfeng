% Compute Chebyshev polynomial approx. of exp(x) 
syms x
f(x) = exp(x);
N = 7;
a = cheby_coeff(f,N) % Chebycheff coefficients

% To ensure error is less than 1e-6 over the interval
x = linspace(-1,1,100);
error = zeros(1,length(x));

for i = 1:length(x)
    sum = 0;
    for j = 1:N+1
        T = double(cos((j-1)*acos(x(i))));
        approx = double(a(j)*T);
        sum = sum + approx;
    end
error(i) = abs(f(x(i)) - sum);
end
error = double(error); % all error evaluated at N numbers of x
max_error = max(error) % = 2.1083e-07 < 1e-6

% Compute Chebyshev approx for increasing M = 2,3,4,5 for the following
syms x
g(x) = piecewise(x < 0, -1, x > 0, 1, 0);
M = [2,3,4,5];
b = cheby_coeff(g,5) % Chebycheff coefficients for N = 5

y = linspace(-1,1,100);
error_2 = zeros(1,length(y));
for n = 1:length(M)
    N = M(n);
    for i = 1:length(y)
        sum = 0;
        for j = 1:N+1
            T = cos((j-1)*acos(y(i)));
            approx = b(j)*T;
            sum = sum + approx;
        end
    error_2(i) = abs(g(y(i)) - sum);
    end
error_2 = double(error_2); % all error evaluated at N numbers of x
max_error_2(n) = max(error_2);
end
max_error_2 % maximum error of each M