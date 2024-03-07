%% Exercise 15.1
clc; clear; clf;
N=10;
c=3; % max number of connections
beta=0.2;
alpha=0.5;
tau0=0.1;

nodes = datasample(RandStream('mlfg6331_64'),1:N^2,N,'Replace',false);
[row,col] = ind2sub([N N],nodes);
nodes=[row',col'];



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Initialize connections, distances, weights %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

connections=zeros(N);
distance=inf(N);
pheromones=zeros(N);

for i=1:size(nodes,1)
    r=randi(c);
    rndConnections=randsample(1:10,r);
    for j=1:r
        connections(i,rndConnections(j))=1;
        connections(rndConnections(j),i)=1;
        dist = randi(N);
        
        distance(i,rndConnections(j))=dist;
        distance(rndConnections(j),i)=dist;
    end
end

connections(1:N+1:end) = 0;
distance(1:N+1:end) = inf;
weights=1./distance;
pheromones(connections>1)=tau0;

plotNodes(nodes,connections,N)
path=GeneratePath(connections,1,N-1)
pathLength = ComputePathLength(path,distance)
path = SimplifyPath(path)



function path = GeneratePath(connections,startNode,k)
path=startNode;
while length(path)<k
    index=find(connections(:,path(end))==1);
    if length(index)==1
        path=[path index];
    else
        nextNode=randsample(index,1);
        path=[path nextNode];
    end   
end
end

function newPath = SimplifyPath(path)
newPath=[];
for i=1:length(path)
    index=find(newPath==path(i));
    if isempty(index)
        newPath=[newPath path(i)];
    else
        newPath(index+1:end)=[];
    end    
end
end

function plotNodes(nodes,connections,N)
plot(nodes(:,1),nodes(:,2),'.','MarkerSize',14,'Color','k')
hold on
for i=1:N
    points=nodes(connections(:,i)==1,:);
    for j=1:size(points,1)
        plot([nodes(i,1) points(j,1)],[nodes(i,2) points(j,2)],'Color','k')
    end
end
end

function pathLength = ComputePathLength(path,distance)
pathLength=0;
 for i=1:size(path,2)-1
     pathLength=pathLength+distance(path(i),path(i+1));
 end
end