%% Create startingpoint
clc,clf, clear all
% Initialize
L = 1000;
N = 100;
v = 3;
dt = 1;
eta = 0.1;
R = 20;

%%
initPopulation = GenerateInitialConfiguration(N,L);
population = initPopulation;
voronoi(population(:,1),population(:,2))
axis([0 L 0 L])

%% Simulations from startingpoint

clc
% Simulation
% Step 1 - Update positions
population = initPopulation;
S = 10000;
x=linspace(0,S,S);
GA = zeros(S,1);
averageTheta = zeros(N,S);
h=10;

for t = 1:S
population = UpdatePositions(population,L,v,dt);
% Step 2 - Update orientation
[population(:,3),averageTheta] = UpdateThetaDelayAmanda(population,eta,dt,N,R,h,t,averageTheta);

voronoi(population(:,1),population(:,2));
axis([0 L 0 L])
drawnow;
end

