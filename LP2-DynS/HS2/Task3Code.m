%% Main
clear, clc
sigma = 10;
beta = 8/3;
r = 28;

dt = 1e-3;
T = 1e1;
N = T/dt;

x1 = 1;
x2 = 2;
x3 = 3;
f = @(t, var) [sigma*(var(2)-var(1)); r*var(1)-var(2)-var(1)*var(3);var(1)*var(2)-beta*var(3)];
[t,x] = ode45(f,0:1:10,[x1;x2;x3]);

n = length(t);

% Starting loop from this initial condition
x1 = x(n,1); x2 = x(n,2); x3 = x(n,3);

[t,x] = ode45(f,[0:dt:T],[x1;x2;x3]);
e1=0;
e2=0;
e3=0;

plot3(x(:,1),x(:,2),x(:,3),'.','MarkerSize',2);

JN = eye(3);
w = eye(3);
J = eye(3);
for k=1:N
% calculate next point on trajectory
x1 = x(k,1);
x2 = x(k,2);
x3 = x(k,3);

J = (eye(3)+[-sigma,sigma,0;-x3+r,-1,-x1;x2,x1,-beta]*dt);
w = orth(J*w);
e1=e1+log(norm(w(:,1)));
e2=e2+log(norm(w(:,2)));
e3=e3+log(norm(w(:,3)));


w(:,1) = w(:,1)/norm(w(:,1));
w(:,2) = w(:,2)/norm(w(:,2));
w(:,3) = w(:,3)/norm(w(:,3));
end

e1=e1/T; % Lyapunov exponents
e2=e2/T;
e3=e3/T;
l1=exp(e1); % Lyapunov numbers
l2=exp(e2);
l3=exp(e3);
[e1,e2,e3]
trace=e1+e2+e3
[l1,l2,l3]


