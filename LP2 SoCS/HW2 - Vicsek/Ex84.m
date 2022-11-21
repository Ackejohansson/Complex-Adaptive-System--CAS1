%% 84 
% Create startingpoint
clc,clf, clear all
% Initialize
dt=1;
eta = 0.01;
S = 1e4;
v = 1;

% Settings
L = 100;
N = 100; % number of particles

initPopulation = GenerateInitialConfiguration(N,L);
population = initPopulation;
voronoi(population(:,1),population(:,2))
hold on
axis([0 L 0 L])

%% Simulations from startingpoint
clc
R = 1;
% Simulation
% Step 1 - Update positions
population = initPopulation;
GA = zeros(S,1);
c = zeros(S,1);

for t = 1:S
population = UpdatePositions(population,L,v,dt);
population = UpdateTheta(population,N,R,eta,dt);

% Compute GA an Local
GA(t)=1/N* abs(sum(exp(population(:,3)*1i)));
c(t) = ComputeGCC(population,R);

% voronoi(population(:,1),population(:,2));
% axis([0 L 0 L])
% title("\Psi: " + GA(t) + " and t: "+ t)
% drawnow;
end
%%
figure(2)
x=linspace(0,S,S);
plot(x,GA)
hold on
plot(x,c)
xlabel("t")
ylabel("Global alignment")
