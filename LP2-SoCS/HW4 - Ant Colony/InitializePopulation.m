function [nodes,M,D,W,tau] = InitializePopulation(N,tau0)
M = zeros(N);
D = inf(N);

% Initialize Nodes
nodes = datasample(RandStream('mlfg6331_64'),1:N^2,N,'Replace',false);
[row,col] = ind2sub([N N],nodes);
nodes = [row',col'];

% Initalize connection matrix
DT = delaunay(nodes);
for i = 1:length(DT)
    combinations = nchoosek(DT(i,:),2);
    index = sub2ind([N N],combinations(:,1),combinations(:,2));
    indexFlip = sub2ind([N N],combinations(:,2),combinations(:,1));
    
    M(index) = 1;
    M(indexFlip) = 1; 
    p1 = nodes(DT(i,1),:);
    p2 = nodes(DT(i,2),:);
    p3 = nodes(DT(i,3),:);
    
    distance = [pdist([p1;p2]), pdist([p1;p3]), pdist([p2;p3])];
    D(index) = distance;
    D(indexFlip) = distance;
end
M(1:N+1:end) = 0;

% Initialize distance and weight-matrix
D(1:N+1:end) = inf;
W = 1./D;

% Init PheromoneLevels tau
tau = zeros(N);
tau(M>0)=tau0;
end