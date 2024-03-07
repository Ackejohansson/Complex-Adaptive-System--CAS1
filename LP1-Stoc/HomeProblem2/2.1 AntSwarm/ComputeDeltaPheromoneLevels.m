function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)
    nNodes = size(pathCollection, 2);
    nAnts = size(pathLengthCollection, 1);
    
    deltaPheromoneLevel = zeros(nNodes, nNodes);
    for i = 1:nAnts
        for j = 1:nNodes-1
            deltaPheromoneLevel( pathCollection(i,j+1),pathCollection(i,j) ) = deltaPheromoneLevel( ...
                pathCollection(i,j+1),pathCollection(i,j) ) + 1/pathLengthCollection(i);
        end
        first = pathCollection(i,end);
        second = pathCollection(i,1);
        deltaPheromoneLevel(first, second) = deltaPheromoneLevel(first, second) + 1/pathLengthCollection(i);
    end    
end