function [a] = cheby_coeff(f,N)
    a = zeros(1,N+1);
    for j = 1:N+1
        syms d
        x = cos(d); 
        if j == 1
            func = f(x);
            a(j) = (1/pi)*double(int(func,0,pi));
        else
            func = f(x)*cos((j-1)*d);
            a(j) = (2/pi)*double(int(func,0,pi));
        end
    end
end