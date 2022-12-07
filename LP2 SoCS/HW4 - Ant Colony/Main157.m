%% 15.7
tic
clc, clear, clf
N=200;
nrAnts = 100;
maxNrSteps = 400;
S=100;

alpha = 1;
beta = 1;
rho  = 0.5;
tau0 = 1;
Q = 1;
startNode = 23;%randi(N);
endNode   = 89;%randi(N);%randi(N-1);
shortestPath = [];
shortestPathLength = inf;

[nodes,M,D,W,tau] = InitializePopulation(N,tau0);
PlotConfig(nodes,shortestPath,startNode,endNode)

shortestPathsLoop = zeros(S,1);
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
tau(tau<1e-5) = 0;
%
figure(1)
PlotConfig(nodes,shortestPath,startNode,endNode)
title('Shortest path, S=200 with 100 ants')
%

figure(2)
plot(1:S,shortestPathsLoop(:,1))
xlabel('n')
ylabel('L(n)')
title('Minimum path length over iteration')
%
figure(3)
plotPheromones(nodes,tau,startNode,endNode)
title('Pheromone level with 100 ants after 200 iterations')
toc
%%
function plotPheromones(nodes,pheromones,startNode,endNode)
clf
hold on
DT = delaunayTriangulation(nodes);
triplot(DT,'.-','MarkerSize',14,'Color',[0,0,0,0.5])%triplot(DT)
plot(nodes(startNode,1),nodes(startNode,2),'o',"MarkerEdgeColor",'g','MarkerSize',14)
plot(nodes(endNode,1), nodes(endNode,2),'o',"MarkerEdgeColor",'r','MarkerSize',14)

for i=1:size(pheromones,1)
    for j=i:size(pheromones,2)
        if pheromones(i,j)>0
            plot([nodes(i,1) nodes(j,1)],[nodes(i,2) nodes(j,2)],"Color", [1,0,0],'LineWidth',5*pheromones(i,j))
        end
    end
end
drawnow;
end
