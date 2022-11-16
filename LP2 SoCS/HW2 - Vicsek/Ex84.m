%% 84 
%% Create startingpoint
clc
% Initialize
deltat=1;
nu = 0.01;
S = 1e4;
v = 1;

% Settings
L = 100;
N = 100; % number of particles
[C,a,b] = GenerateInitialConfiguration(N,L);
initialPopulation = GeneratePopulation(a,b,N);
h = voronoi(a,b)

%% Simulations from startingpoint
clc
R = 1;
population = initialPopulation;

population = SimulateParticles(population,v,R)

