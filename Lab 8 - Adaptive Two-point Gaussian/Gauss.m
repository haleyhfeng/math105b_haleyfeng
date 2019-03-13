function [approx] = Gauss(f,a,b)
    t = 0.5773502692;
    x1 = ((b-a)*t+a+b)/2;
    x2 = ((b-a)*(-t)+a+b)/2;
    approx = double(f(x2)*(b-a)/2 + f(x1)*(b-a)/2);
end