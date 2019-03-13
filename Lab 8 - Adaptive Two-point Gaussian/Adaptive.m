function [S] = Adaptive(f,S,a,b,level,N)
    tol = 10^(-7);
    level = level + 1;
    One_Gauss = Gauss(f,a,b);
    c = (a+b)/2;
    Two_Gauss = Gauss(f,a,c) + Gauss(f,c,b);
    if level > N
        error('Error: Max Depth Reached');
    else
        if abs(One_Gauss - Two_Gauss) < tol
            S = S + Two_Gauss;
            [a,b] % subinterval
            sprintf('Contribution of subinterval is %s with depth %d',S,level)
        else
            S = Adaptive(f,S,a,c,level,N) + Adaptive(f,S,c,b,level,N);
        end
    end
end
            
