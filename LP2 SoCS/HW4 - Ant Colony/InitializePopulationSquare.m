function [nodes,M,D,W,tau] = InitializePopulationSquare(N,tau0)
M = zeros(N);
D = inf(N);
numberOfPoints = 6;

% Initialize Nodes
[row,col] = ind2sub([numberOfPoints numberOfPoints],1:numberOfPoints^2);
nodes = [row',col'];



% Initalize connection matrix
DT = delaunay(nodes);
triplot(delaunayTriangulation(nodes))

for i = 1:length(DT)
    combinations = nchoosek(DT(i,:),2);
    combinations(2,:) =[];
    index = sub2ind([N N],combinations(:,1),combinations(:,2));
    indexFlip = sub2ind([N N],combinations(:,2),combinations(:,1));
    
    M(index) = 1;
    M(indexFlip) = 1; 
    p1 = nodes(DT(i,1),:);
    p2 = nodes(DT(i,2),:);
    p3 = nodes(DT(i,3),:);
    
    distance = [pdist([p1;p2]),pdist([p2;p3])];
    D(index) = distance;
    D(indexFlip) = distance;
end


nodes = nodes + (2*rand(numberOfPoints^2,2)-1)/5;






% Initialize distance and weight-matrix
D(1:N+1:end) = inf;
W = 1./D;

% Init PheromoneLevels tau
tau = zeros(N);
tau(M>0)=tau0;
end