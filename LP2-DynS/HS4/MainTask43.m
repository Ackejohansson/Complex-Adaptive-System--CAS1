%% Task 4.3
clear all, clc

% Settings
a = 1.4;
b = 0.3;
nrOfInitConditions = 1000;
nrOfIterations = 2000;
transient = 10;

% Create trajectory
[xList, yList] = CreateHenonMap(a,b,nrOfInitConditions,nrOfIterations,transient);

nEpsilons = 10;
epsilon = linspace(1e-3, 1e-2,nEpsilons);
Qlist = [0,1,2, linspace(0.1,4,nEpsilons-3)];
Iq = zeros(nEpsilons,nEpsilons);

for i = 1:nEpsilons
    [H, nTot] = CreateHistogram(epsilon(i), xList, yList);
    
    % Iq 0
    Iq(1,i) = sum(sum(H>0));

    % Iq 2
    tmpH = H./nTot .* log(1./(H/nTot));
    Iq(2,i) = sum(tmpH(~isnan(tmpH)));
    
    % Iq 3
    Iq(3,i) = sum(sum((H/nTot).^2));

    % Iq more
    for j = 1:nEpsilons-3
        Iq(j+3,i) = sum(sum((H/nTot).^Qlist(3+j)));
    end
end

% c) Boxcounting, information and correlation
[D, DqOfq] = FitPolynomial(Iq, epsilon, Qlist);
disp("[D0,D1,D2]= [" + D(1,1) + ", " + D(2,1) + ", " + D(3,1)+"]")

% e) Lyaponov exponents 
lambda = zeros(2,1);
Q = eye(2);
for k=1:length(xList(end,:))  
    M = [-2*a*xList(end,k), 1; b, 0];
    [Q,R] = qr(M*Q);
    lambda = lambda + log(abs(diag(R)));
end
lambda = sort(lambda /length(xList(end,:)), 'descend');
fprintf('Lyapunov exponents are %c%c = %.3f, %c%c = %.3f \n',955,8321,lambda(1),955,8322,lambda(2))

% f) DL
DL = 1 - lambda(1)/lambda(2);
disp("DL = " + DL)

%% Plots
% Plots Heinon attractor
figure(1)
clf
plot(xList, yList, '.')
xlabel("x")
ylabel("y")
axis equal

% Plots Heinon attractor but with histo (not asked for)
figure(2)
clf
colormap(flipud(gray))
imagesc(H'>1)
set(gca, 'YDir', 'normal')
xlabel("x")
ylabel("y")

% Plots D (not asked for)
figure(3)
clf
q = linspace(-20,20,1000);
Dq = (1./(1-q).*log( (1-2/3).^q + (2/3).^q ) /log(3));
plot(q,Dq,'.')
xlabel("q")
ylabel("D_q")

% b)
figure(4)
clf
hold on
plot(log(1./epsilon), log(Iq(1,:)), '-x')
plot(log(1./epsilon), Iq(2,:), '-o')
plot(log(1./epsilon), -log(Iq(3,:)), '-*')
legend('q = 0', 'q = 1', 'q = 2', 'Location', 'northwest')
xlabel('ln(1 / \epsilon)')
title('(1 - q)^{-1} ln[I(q, \epsilon)] / \Sigma_1^{N_{boxes}} [p_k ln(1 / p_k)]')
hold off

% d)
figure(5)
clf
hold on
plot(Qlist,D(:,1),'x')
plot(Qlist, DqOfq(:,1)*Qlist+DqOfq(:,2))
xlabel("q")
ylabel("D_q")
title("All Dq points and a line fitted")
