%% Main Ants 15.1
clc,clear
N = 10;
maxNrOfConnections = 4;
tau0 = 0.1;
startNode = 1;
k=N-1;

[nodes,M,D,W] = InitializePopulation(N,maxNrOfConnections);
pheromoneLevel = InitializePheromoneLevels(M,tau0,N);
path = GeneratePath(M,startNode,k)
pathLength = ComputeDistance(D,path)
simplifiedPath = SimplifyPath(path,k)



%%%%%%%%%%%%%%%%%%    FUNKTIONER        %%%%%%%%%%%%%%%%%%%%%%%%%%%

function [nodes,M,D,W] = InitializePopulation(N,maxNrOfConnections)
nodes = datasample(RandStream('mlfg6331_64'),1:N^2,N,'Replace',false);
[row,col] = ind2sub([N N],nodes);
nodes = [row',col'];
M = zeros(N);
D = inf(N);
for i=1:length(nodes)
    nrConnections = randi(maxNrOfConnections);
    connections = randsample(1:length(nodes),nrConnections);
    for j=1:nrConnections
        M(i,connections(j)) = 1;
        M(connections(j),i) = 1;
        randDist = randi(N);
        D(i,connections(j)) = randDist;
        D(connections(j),i) = randDist;
    end
end
M(1:N+1:end) = 0;
D(1:N+1:end) = inf;
W = 1./D;
end

function pheromoneLevel = InitializePheromoneLevels(M,tau0,N)
pheromoneLevel = zeros(N);
pheromoneLevel(M>0)=tau0;
end

function path = GeneratePath(M,startNode,k)
path=startNode;
while length(path)<k
    index=find(M(:,path(end))==1);
    if length(index)==1
        path=[path index];
    else
        nextNode=randsample(index,1);
        path=[path nextNode];
    end   
end
end

function pathLength = ComputeDistance(D,path)
pathLength=0;
for i=1:length(path)-1
    pathLength = pathLength + D(path(i),path(i+1));
end
end