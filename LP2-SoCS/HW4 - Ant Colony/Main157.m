%% 15.7
clc, clear, clf
N=200;
nrAnts = 20;
maxNrSteps = 400;
S = 100;

alpha = 1;
beta = 1;
rho  = 0.5;
tau0 = 1;
Q = 1;
startNode = randi(N);%23
endNode   = randi(N);%89;%;%randi(N-1);
shortestPath = [];
shortestPathLength = inf;
shortestPathsLoop = zeros(S,1);


% Initialize
[nodes,M,D,W,tau] = InitializePopulation(N,tau0);
PlotConfig(nodes,shortestPath,startNode,endNode)

% Main loop
for n = 1:S
paths = GeneratePaths(nrAnts,maxNrSteps,alpha,beta,W,tau,startNode,endNode);
simplifiedPath = SimplifyPath(paths,maxNrSteps);
[pathLength, indexShortestPath] = ComputePathLength(simplifiedPath,D);

if pathLength(indexShortestPath) < shortestPathLength
    shortestPath = nonzeros(simplifiedPath(indexShortestPath,:))';
    shortestPathLength = pathLength(indexShortestPath);
    PlotConfig(nodes,shortestPath,startNode,endNode)
end
%plotPheromones(nodes,tau,startNode,endNode)
tau = ComputePheromoneLevels(simplifiedPath,tau,rho,Q,pathLength);

shortestPathsLoop(n) = pathLength(indexShortestPath);
end

% Figures
figure(1)
PlotConfig(nodes,shortestPath,startNode,endNode)
title("Shortest path for, S=" + S + " with " + nrAnts + " ants")

figure(2)
plot(1:S,shortestPathsLoop)
xlabel('n')
ylabel('L(n)')
title('Minimum path length over iteration')

figure(3)
plotPheromones(nodes,tau,startNode,endNode)
title("Pheromone level with " + nrAnts + " ants after " + S + " iterations")


