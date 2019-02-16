% Question 1
syms x
f(x) = x*log(x);
a = 1;
b = 2;
exact = double(int(f,a,b)) % Exact Value

% Question 2

h_t = b - a;
trap = double((f(a) + f(b))*h_t/2) % Trapezoid Rule

df_2 = diff(f,x,2);
error_t = double(df_2(1)*h_t^3/12) % Error estimate of Trapezoid
exact_t = double(abs(exact-trap)) %  Absolute Error

h_s = (b - a)/2;
x_1 = a + h_s;
simp = double((f(a) + 4*f(x_1) + f(b))*h_s/3) % Simpson's Rule

df_4 = diff(f,x,4);
error_s = double(df_4(1)*h_s^5/90) % Error estimate of Simpson
exact_s = double(abs(exact-simp)) % Asolute Error

% Question 3 & 4

n = [10,20,50,100];
I = zeros(4,3); % empty matrix to stored all n composite simpson's integral estimate 
J = zeros(4,2); % empty matrix to stored all n composite trapezoid integral estimate 
for j = 1:length(n)
    h = (b-a)/n(j);
    I(j,1) = f(a) + f(b);
    J(j,1) = f(a) + f(b);
    for i = 1:n(j)-1
        x = a + i*h;
        J(j,2) = J(j,2) + f(x); 
        if rem(i,2) == 0
            I(j,3) = I(j,3) + f(x);
        else
            I(j,2) = I(j,2) + f(x);
        end
    end
comp_simp(j) = (I(j,1)+2*I(j,3)+4*I(j,2))*h/3;
comp_trap(j) = (J(j,1)+2*J(j,2))*h/2;

error_est_simp(j) = (b-a)*h^4*df_4(1)/180;
error_est_trap(j) = (b-a)*h^2*df_2(1)/12; 
end

comp_simp
comp_trap

error_est_simp = double(error_est_simp)  % Error estimate of Composite Simpson
error_est_trap = double(error_est_trap) % Error estimiate of Composite Trapezoid
error_comp_simp = abs(exact - comp_simp) % Absolute exact error of Composite Simpson
error_comp_trap = abs(exact - comp_trap) % Abolute exact error of Composite Trapezoid

subplot(2,1,1)
semilogy(n,comp_simp) % Plot of composite simpson
hold on
semilogy(n,comp_trap) % Plot of composite trapezoid
xlabel('n')
ylabel('Approximation to the integral')
legend('Composite Simpson','Composite Trapezoid')

subplot(2,1,2)
semilogy(n, error_comp_simp) % Plot of abs error of comp. simpsons
hold on
semilogy(n, error_comp_trap) % PLot of abs error of comp. trapezoid
xlabel('n')
ylabel('Absolute Error')
legend('Error of Composite Simpson','Error of Composite Trapezoid')

