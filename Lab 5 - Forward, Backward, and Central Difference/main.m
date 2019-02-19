syms f(x)
f(x) = 1/(1+x^2);
df_1 = diff(f,x,1); % first derivative
df_2 = diff(f,x,2); % second derivative
df_3 = diff(f,x,3); % second derivative
df_4 = diff(f,x,4); % fourth derivative
n = [11,21,51,101];

% Approximate f'(xi) for i = 1,..,n-1 using forward, backward, and central difference
for i = 1:length(n)
    E = zeros(1,n(i)-1); % empty list to store values 
    F = zeros(1,n(i)-1);
    B = zeros(1,n(i)-1);
    C = zeros(1,n(i)-1);
    est_error_1 = zeros(1,n(i)-1);
    est_error_2 = zeros(1,n(i)-1);

    h = 10/n(i);
    
    for j = 1:n(i)-1
        
        x(j) = -5 + j*h;
        E(j) = df_1(x(j)); % exact solution
        F(j) = double((f(x(j)+h) - f(x(j)))/h); % forward difference
        B(j) = double((f(x(j)) - f(x(j)-h))/h); % backward difference
        C(j) = double((f(x(j)+h) - f(x(j)-h))/(2*h)); % central difference
        
        M1 = abs(df_2(x(j)));
        M2 = abs(df_3(x(j)));
        est_error_1(j) = M1*h/2; % error estimate for forward/backward
        est_error_2(j) = M2*(h^2)/6; % error estimate for central

    end
    
subplot(2,2,i)
plot(x,F) 
hold on
plot(x,B)
hold on
plot(x,C)
hold on
plot(x,E)
title(['n = ',num2str(n(i))])
legend('Forward Diff','Backward Diff','Central Diff','Real first derivative')

max_1(i) = double(max(abs(E - F))); % max error of forward
max_2(i) = double(max(abs(E - B))); % max error of backward
max_3(i) = double(max(abs(E - C))); % max error of central

 % max error of error estimate of fourward & backward
max_est_error_1(i) = max(est_error_1);
 % max error of error estimate of central difference
max_est_error_2(i) = max(est_error_2);
end

% Exact Error and Error Estimate

max_1
max_2
max_3
max_est_error_1
max_est_error_2

figure(2)
subplot(2,1,1)
plot(n,max_1)
hold on 
plot(n,max_2)
hold on
plot(n,max_est_error_1)
xlabel('n')
ylabel('Maximum Absolute Error')
legend('Error of Forward','Error of Backward','Estimate Error')
subplot(2,1,2)
plot(n,max_3)
hold on
plot(n,max_est_error_2)
xlabel('n')
ylabel('Maximum Absolute Error')
legend('Error of Central','Estimate Error')


% Approximate f''(xi) for i = 1,..,n-1 using central difference
figure(3)
for i = 1:length(n)
    x = zeros(1,n(i)-1); % empty list to store values 
    E = zeros(1,n(i)-1); 
    C = zeros(1,n(i)-1);
    est_error = zeros(1,n(i)-1);

    h = 10/n(i);

    for j = 1:n(i)-1
        x(j) = -5 + j*h;
        E(j) = df_2(x(j)); % exact solution
        C(j) = double((f(x(j)-h) - 2*f(x(j))+f(x(j)+h))/(h^2)); % central difference
        
        M = df_4(x(j));
        est_error(j) = M*(h^2)/12; % error estimate
    end
    
subplot(2,2,i)
plot(x,C)
hold on
plot(x,E)
title(['n = ',num2str(n(i))])
legend('Central Diff','Real second derivative')

error = abs(E-C); % absolute error
max_cent(i) = double(max(error)); % max error of central
max_est_error(i) = max(est_error); % max error of error estimate
end

max_cent
max_est_error

figure(4)
plot(n,max_cent)
hold on
plot(n,max_est_error)
xlabel('n')
ylabel('Maximum Absolute Error')
legend('Error of Central','Estimate Error')

% Calculate the derivative f'(0) using forward difference
N = [1,2,5,10,20,40];
for i = 1:length(N)
    n = N(i);
    D(i) = (f(10^(-n))-f(0))/(10^(-n)); % forward difference
end

D = double(D)
df_1(0)
 

