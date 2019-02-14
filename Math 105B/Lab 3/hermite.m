function [Q,z] = hermite1(X,Y,YP)
    n = length(X);
    z = zeros(1,2*n-1);
    Q = zeros(2*n,2*n);
    for i = 0:n-1
        z(2*i+1) = X(i+1);
        z(2*i+2) = X(i+1);
        Q(2*i+1,1) = Y(i+1);
        Q(2*i+2,1) = Y(i+1);
        Q(2*i+2,2) = YP(i+1);
        if i ~= 0
            Q(2*i+1,2) = (Q(2*i+1,1)-Q(2*i,1))/(z(2*i+1)-z(2*i));
        end
    end
Q;
z;
end