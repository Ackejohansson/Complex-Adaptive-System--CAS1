%% 84 
%% Create startingpoint
clc
% Initialize
dt=0.1;
eta = 0.01;
S = 1e4;
v = 1;

% Settings
L = 100;
N = 100; % number of particles
initPopulation = GenerateInitialConfiguration(N,L);
population = initPopulation;
voronoi(population(:,1),population(:,2))

%% Simulations from startingpoint
clc
population = initPopulation;
R = 1;
%%
% Simulation
% Step 1 - Update positions
for i = 1:10000
population = UpdatePositions(population,L,v,dt);
% Step 2 - Update orientation
population = UpdateTheta(population,N,R,eta,dt);
voronoi(population(:,1),population(:,2));
drawnow;
end

