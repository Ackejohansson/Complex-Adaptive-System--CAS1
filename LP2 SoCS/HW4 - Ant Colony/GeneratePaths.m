function paths = GeneratePaths(nrAnts,maxNrSteps,alpha,beta,W,tau,startNode,endNode)

currentNode=ones(nrAnts,1)*startNode;

everyPath = zeros(nrAnts,maxNrSteps);
everyPath(:,1)=currentNode;
paths=[];

for i=2:maxNrSteps
    nextNode = zeros(size(everyPath,1),1);
    for j=1:size(everyPath,1)
        nextNode(j,1)=NextNode(currentNode(j),alpha,beta,W,tau);
    end
    everyPath(:,i)=nextNode;
    currentNode=nextNode;
    
    index=currentNode(:)==endNode;
    %TODO: Loopa över alla som kommit till sista noden?
    if sum(index)>0
        paths=[paths; everyPath(index,:)];
        everyPath(index,:) = [];
        currentNode(index) = [];
    end   
end