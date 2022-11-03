function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
    nNodes = size(visibility,2);
    path = zeros(1, nNodes); 
    randomStart = randi([1 nNodes]);
    path(1) = randomStart;
    
    for i = 1:nNodes-1
        nextNode = GetNode(path, i, pheromoneLevel, visibility, alpha, beta);
        path(i+1) = nextNode;
    end
end


