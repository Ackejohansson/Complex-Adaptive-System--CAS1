%% Home set 3.3
clc; clear

sigma = 10;
b = 8/3;
r = 28;

% sigma = 16;
% b = 5;
% r = 320;

T=100;
dt=0.0001;
N=T/dt;

f = @(t, x) [sigma*(x(2)-x(1)); r*x(1)-x(2)-x(1)*x(3);x(1)*x(2)-b*x(3)];

% Solve for x'=f(x)
x1=0.1; x2=0.1; x3=0.1;
[t,x] = ode45(f,0:dt:T,[x1;x2;x3]);

x1=x(length(t),1); 
x2=x(length(t),2); 
x3=x(length(t),3);

[t,x] = ode45(f,0:dt:T,[x1;x2;x3]);

lambda1=0;
lambda2=0;
lambda3=0;

plot3(x(:,1),x(:,2),x(:,3),'.','MarkerSize',2);
Q = eye(3);

for k=1:N    
    M = (eye(3)+[-sigma, sigma, 0; r-x(k,3), -1, -x(k,1); x(k,2), x(k,1), -b].*dt);
    [Q,R]=qr(M*Q);
    lambda1=lambda1+log(norm(R(1,1)));
    lambda2=lambda2+log(norm(R(2,2)));
    lambda3=lambda3+log(norm(R(3,3)));
end
lambda1=lambda1/T; % Lyapunov exponents
lambda2=lambda2/T;
lambda3=lambda3/T;
disp("1: "+ lambda1 + "2: "+ lambda2 + "3: "+ lambda3)
l1=exp(lambda1); % Lyapunov numbers
l2=exp(lambda2);
l3=exp(lambda3);
trace=lambda1+lambda2+lambda3