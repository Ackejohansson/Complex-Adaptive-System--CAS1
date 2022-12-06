%% 15.7
clc, clear all, clf
N=40;
nrAnts = 20;
maxNrSteps = 40;
S=100;

alpha = 0.8;
beta = 1;
rho  = 0.5;
tau0 = 1;
Q = 1;
startNode = N;
endNode   = randi(N-1);
shortestPath = [];
shortestPathLength = inf;


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
tau = ComputePheromoneLevels(simplifiedPath,tau,rho,Q,pathLength);
end



%%
function plotPheromoneLevels(nodes,shortestPath)
figure(1)
for i=1:size(shortestPath,1)
    path=nonzeros(shortestPath(i,:));
    for j=1:length(path)-1
        plot([nodes(path(j),1) nodes(path(j+1),1)],[nodes(path(j),2) nodes(path(j+1),2)],"Color", [1,0,0, 0.5])
        drawnow;
    end
end
end
