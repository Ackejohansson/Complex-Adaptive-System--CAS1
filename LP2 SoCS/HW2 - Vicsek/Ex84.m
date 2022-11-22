%% 84 
% Create startingpoint
clc,clf, clear all
% Initialize
dt=0.5;
eta = 0.01;
S = 1e4/dt;
v = 1;

% Settings
L = 100;
N = 100; % number of particles

initPopulation = GenerateInitialConfiguration(N,L);
population = initPopulation;
figure(1)
voronoi(population(:,1),population(:,2))
hold on
axis([0 L 0 L])

% Simulations from startingpoint
R = 1;
population = initPopulation;
GA = zeros(S,1);
c = zeros(S,1);

for t = 1:S
    population = UpdatePositions(population,L,v,dt);
    M = [population(:,1:2); population(:,1:2)+[0,L]; population(:,1:2)+[L,L];
         population(:,1:2)-[L,0]; population(:,1:2)+[-L,L] ; population(:,1:2)+[L,0];
         population(:,1:2)-[L,L]; population(:,1:2)-[0,L]; population(:,1:2)+[L,-L];];
    population = UpdateTheta(population,N,R,eta,dt,M);

    % Compute GA an Local
    GA(t)  = 1/N* abs(sum(exp(population(:,3)*1i)));
    c(t) = ComputeGCC(population,R,M);

    % voronoi(M(:,1),M(:,2));
    % axis([0 L 0 L])
    % title("\Psi: " + GA(t) + " and t: "+ t)
    % drawnow;
end

%
clf
figure(2)
x=linspace(0,S*dt,S);
plot(x,GA)
hold on
plot(x,c)
xlabel("t")
ylabel("\Psi, c")
legend("Global alignment \Psi","Global clustering c")
title("R="+R)
