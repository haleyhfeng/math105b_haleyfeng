% Question 2
n = 3;
X = linspace(1,2.9,n);
Y = 1./X;
f = 1./3;
P = f_lagrange(X,Y,3);
f - P

% Question 3
for n = 3:6
X = linspace(1,2.9,n);
Y = 1./X;
f = 1./3;
P = f_lagrange(X,Y,3,n); %modify function f_lagrange with extra input n
diff = f - P; 
scatter(n,abs(diff))
hold on
end

% Question 4
for n = 3:6
if n == 5
continue
end
X = linspace(1,2.9,n);
Y = 1./X;
x = linspace(1,3,100);
for i = 1:100
y(i) = f_lagrange(X,Y,x(i),n); 
end
plot(x,y)
hold on
plot(x,1./x,'-r')
end