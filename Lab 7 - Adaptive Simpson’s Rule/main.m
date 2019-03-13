% The exact value of the integral
syms x
f(x) = cos(2*x)*exp(-x);
df_4 = diff(f,x,4); % 4th degree differentiation
a = 0;
b = 2*pi;
exact = double(int(f,a,b)) % Exact Value

% Using the composite Simpson's rule
n = [10,20,50,100];
I = zeros(4,3); % empty matrix to stored all n composite simpson's integral estimate 
for j = 1:length(n)
    h = (b-a)/n(j);
    I(j,1) = f(a) + f(b);
    for i = 1:n(j)-1
        x = a + i*h;
        if rem(i,2) == 0
            I(j,3) = I(j,3) + f(x);
        else
            I(j,2) = I(j,2) + f(x);
        end
        M(i) = df_4(x); % Evaluating differentiation for error estimate
    end
comp_simp(j) = (I(j,1)+2*I(j,3)+4*I(j,2))*h/3;
error_est_simp(j) = (b-a)*h^4*max(M)/180;
end

comp_simp

error_est_simp = double(abs(error_est_simp))  % Error estimate of Composite Simpson
error_comp_simp = abs(exact - comp_simp) % Absolute exact error of Composite Simpson

semilogy(n, error_comp_simp) % Plot of abs error of comp. simpsons
xlabel('n')
ylabel('Absolute Error')
legend('Error of Composite Simpson')

% Using Adaptive Simpson's Rule
eps = 0.5*10^(-4); % desired accuracy
N = 20; % maximum number of levels
% N = 5 would not work
APP = 0; % STEP 1
i = 1;
eps(i) = 10*eps;
a(i) = a;
h(i) = (b-a)/2;
FA(i) = f(a);
FC(i) = f(a+h(i));
FB(i) = f(b);
S(i) = h(i)*(FA(i) + 4*FC(i) + FB(i))/3;
L(i) = 1;
while i > 0 % STEP 2
    FD = f(a(i) + h(i)/2);
    FE = f(a(i) + 3*h(i)/2);
    S1 = h(i)*(FA(i) + 4*FD + FC(i))/6;
    S2 = h(i)*(FC(i) + 4*FE + FB(i))/6;
    v1 = a(i);
    v2 = FA(i);
    v3 = FC(i);
    v4 = FB(i);
    v5 = h(i);
    v6 = eps(i);
    v7 = S(i);
    v8 = L(i);
    i = i - 1; % STEP 4, delete this level
    if abs(S1 + S2 - v7) < v6 % STEP 5
        APP = S1 + S2 + APP;
    else
        if v8 >= N
            fprintf('Level Exceeded');
            break % procedure fails
        else % data for right half subinterval
            i = i + 1;
            a(i) = v1 + v5;
            FA(i) = v3;
            FC(i) = FE;
            FB(i) = v4;
            h(i) = v5/2;
            eps(i) = v6/2;
            S(i) = S2;
            L(i) = v8 + 1;
            i = i + 1; % data for left half subinterval
            a(i) = v1;
            FA(i) = v2;
            FC(i) = FD;
            FB(i) = v3;
            h(i) = h(i-1);
            eps(i) = eps(i-1);
            S(i) = S1;
            L(i) = L(i-1);
        end
    end
end
APP = double(APP)