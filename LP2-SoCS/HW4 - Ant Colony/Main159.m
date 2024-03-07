%% 15.9
clc, clear all, clf
N=20^2;
nrAnts = 20;
maxNrSteps = 500;
S=100;

alpha = 0.7;
beta = 1;
rho  = 0.5;
tau0 = 1;
Q = 1;
startNode = N;
endNode   = 10;
shortestPath = [];
shortestPathLength = inf;


[nodes,M,D,W,tau] = InitializePopulationSquare(N,startNode,endNode);

% Main loop
for n = 1:S
paths = GeneratePaths(nrAnts,maxNrSteps,alpha,beta,W,tau,startNode,endNode);
simplifiedPath = SimplifyPath(paths,maxNrSteps);
[pathLength, indexShortestPath] = ComputePathLength(simplifiedPath,D);

if pathLength(indexShortestPath) < shortestPathLength
    shortestPath = nonzeros(simplifiedPath(indexShortestPath,:))';
    shortestPathLength = pathLength(indexShortestPath);
    PlotConfigSquare(nodes,N,shortestPath,startNode,endNode)
end
tau = ComputePheromoneLevels(simplifiedPath,tau,rho,Q,pathLength);
%plotPheromonesSquare(nodes,tau,startNode,endNode)
end

%%
function plotPheromonesSquare(nodes,pheromones,startNode,endNode)
pheromones(pheromones<1e-5) = 0;
hold on
plot(nodes(startNode,1),nodes(startNode,2),'o',"MarkerEdgeColor",'g','MarkerSize',14)
plot(nodes(endNode,1), nodes(endNode,2),'o',"MarkerEdgeColor",'r','MarkerSize',14)

for i=1:size(pheromones,1)
    for j=i:size(pheromones,2)
        if pheromones(i,j)>0
            plot([nodes(i,1) nodes(j,1)],[nodes(i,2) nodes(j,2)],"Color", [1,0,0],'LineWidth',10*pheromones(i,j))
        end
    end
end
drawnow;
end
