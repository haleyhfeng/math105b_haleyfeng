X = [0.0,0.1,0.3,0.6,1.0];
Y = [-6.0,-5.89483,-5.65014,-5.17788,-4.28172];
x = 0.05; % evaluation point

poly = [Y(1)]; % list of coefficient
eval_x = []; % list of lagrange interpolating polynomial

n = length(X);
sum = Y(1); 

for i = 1:n-1
    product = 1;
    for j = 1:i  
        F = newton(X(i-j+1:i+1),Y(i-j+1:i+1));
        product = product * (x-X(j));
        if i == j % storing the first term of the ith degree
            poly = [poly,F];
        end
    end
sum = sum + poly(i+1)*product; 
eval_x = [eval_x,sum];
end
poly
eval_x

% Error of using the forth degree Lagrange interpolating polynomial
Error = eval_x(4)-eval_x(3)

% Adding the point x = 1.1, f(x) = -3.99583
X = [0.0,0.1,0.3,0.6,1.0,1.1];
Y = [-6.0,-5.89483,-5.65014,-5.17788,-4.28172,-3.99583];

x = 1.05; % evaluation point
n = length(X);

% To create new order of X and Y for better an approximation of x
small_diff = abs(X(1)-x);
new_X = [X(1)];
new_Y = [Y(1)];
for i = 2:n
    if abs(X(i)-x) <= abs(small_diff)
        small_diff = X(i)-x;
        new_X = [X(i),new_X];
        new_Y = [Y(i),new_Y];
    else
        new_X = [new_X,X(i)]; 
        new_Y = [new_Y,Y(i)];
    end
end

X = new_X
Y = new_Y

poly = [Y(1)]; % list of coefficient
eval_x = []; % list of lagrange interpolating polynomial

sum = Y(1); 
for i = 1:n-1
    product = 1;
    for j = 1:i  
        F = newton(X(i-j+1:i+1),Y(i-j+1:i+1));
        product = product * (x-X(j));
        if i == j
            poly = [poly,F];
        end
    end
sum = sum + poly(i+1)*product;
eval_x = [eval_x,sum];
end
poly
eval_x

% Error of using the fifth degree Lagrange interpolating polynomial
Error = eval_x(5)-eval_x(4)
