%% 811
% Create startingpoint
clc,clf, clear all
% Initialize
dt=1;
eta = 0.4;
S = 1e3;
v = 3;


% Settings
L = 1000;
N = 100; % number of particles

initPopulation = GenerateInitialConfiguration(N,L);
population = initPopulation;
voronoi(population(:,1),population(:,2))
hold on
axis([0 L 0 L])

%% Simulations from startingpoint
clc,clf
R = 20;
% Simulation
% Step 1 - Update positions
population = initPopulation;
GA = zeros(S,1);
c = zeros(S,1);
k=10;
averageTheta = zeros(N,S);

for t = 1:S
population = UpdatePositions(population,L,v,dt);
M = [population(:,1:2); population(:,1:2)+[0,L]; population(:,1:2)+[L,L];
     population(:,1:2)-[L,0]; population(:,1:2)+[-L,L] ; population(:,1:2)+[L,0];
     population(:,1:2)-[L,L]; population(:,1:2)-[0,L]; population(:,1:2)+[L,-L];];
population(:,3) = UpdateThetaVisionCone(population,eta,dt,N,k,L,R);
                                                        
% Compute GA an Local
GA(t)  = 1/N * abs(sum(exp(population(:,3)*1i)));
c(t) = ComputeGCC(population,R,M);
% voronoi(M(:,1),M(:,2));
% axis([0 L 0 L])
% title("\Psi: " + GA(t) + " and t: "+ t)
% drawnow;
end
%%
figure()
voronoi(M(:,1),M(:,2));
axis([0 L 0 L])
title("Number of nearest: " + k + ", after time: " + S)
drawnow;

%%
clf
figure(2)
x=linspace(0,S,S);
plot(x,GA)
hold on
plot(x,c)
xlabel("t")
ylabel("Global alignment \Psi")
