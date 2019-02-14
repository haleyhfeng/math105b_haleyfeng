function [y] = f_lagrange(X,Y,x) 
sum = 0;
n = length(X);
for j = 1 : n 
    product = 1;
    for k = 1 : n 
        if k ~= j
            product = product * ((x - X(k))/(X(j) - X(k)));
        end
    end
sum = sum + Y(j) * product;
end
y = sum;
end