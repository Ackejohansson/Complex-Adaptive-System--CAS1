function [pathLength, indexShortestPath] = ComputePathLength(simplifiedPath,distance)
nrPaths = size(simplifiedPath,1);
pathLength=zeros(nrPaths,1);

for i = 1:nrPaths
    tmpSimplifiedPath = nonzeros(simplifiedPath(i,:))';
    for j=1:size(tmpSimplifiedPath,2)-1
        pathLength(i) = pathLength(i) + distance(simplifiedPath(i,j),simplifiedPath(i,j+1));
    end
end
if ~isempty(pathLength)
    [~,indexShortestPath] = min(pathLength);
end
end