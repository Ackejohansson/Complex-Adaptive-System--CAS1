%% Create startingpoint
clc,clf
% Initialize
L = 1000;
N = 100;
v = 3;
dt = 1;
eta = 0.4;
R = 20;
%
initPopulation = GenerateInitialConfiguration(N,L);
population = initPopulation;
voronoi(population(:,1),population(:,2))
axis([0 L 0 L])

%% Simulations from startingpoint

clc
% Simulation
% Step 1 - Update positions
h=0;
S = 1e4;
GA = zeros(S,1);
c = zeros(S,1);
s=5;

% for o=1:25
%     h=o;
    averageTheta = zeros(N,S);
    population = initPopulation;
for t = 1:S    
    M = [population(:,1:2);       population(:,1:2)+[0,L];  population(:,1:2)+[L,L];
         population(:,1:2)-[L,0]; population(:,1:2)+[-L,L]; population(:,1:2)+[L,0];
         population(:,1:2)-[L,L]; population(:,1:2)-[0,L];  population(:,1:2)+[L,-L];];
    population = UpdatePositions(population,L,v,dt);
    % Step 2 - Update orientation
    population = UpdateTheta(population,N,R,eta,dt,M);
    GA(t)  = 1/N*abs(sum(exp(population(:,3)*1i)));
    c(t) = ComputeGCC(population,R,M);

    % voronoi(population(:,1),population(:,2));
    % axis([0 L 0 L])
    % drawnow;
end
%
clf
figure(2)
plot(1:S,GA)
hold on
plot(1:S,c)
xlabel("t")
ylabel("\Psi, c")
legend("Global alignment \Psi","Global clustering c")
title("Negative delay: " + h + " and s="+s)

%%
clc
avgGA= mean(GA,1);
avgC = mean(c,1);

figure(1)
plot(1:length(avgGA),avgGA,'o')
xlabel("h")
ylabel("\Psi")
title("The effects of delay for global alignment \Psi")
%
figure(2)
plot(1:length(avgCavgCCnew,'o'))
xlabel("h")
ylabel("c")
title("The effects of delay for global clustering c")


% voronoi(population(:,1),population(:,2));
% axis([0 L 0 L])
% drawnow;
%%

clf
figure(2)
plot(1:S,GA)
hold on
plot(1:S,c)
xlabel("t")
ylabel("\Psi, c")
legend("Global alignment \Psi","Global clustering c")
title("Number of particles: "+N + ", Noise level: "+eta)
