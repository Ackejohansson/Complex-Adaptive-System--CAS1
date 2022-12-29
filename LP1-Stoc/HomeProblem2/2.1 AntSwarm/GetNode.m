function nextNode = GetNode(path, i, pheromoneLevel, visibility, alpha, beta)
nNodes = size(visibility,1);
P = zeros(nNodes,1);

% Create probability vector
for j = 1:nNodes
    if ~ismember(j,path)
        P(j) = (pheromoneLevel(j,path(i)).^alpha .* visibility(j,path(i)).^beta);
    end
end
P = P / sum(P);

% Choose nextNode w. RWS 
Psum = 0;
r = rand;
for k = 1:nNodes
    Psum = Psum + P(k);
    if r <= Psum
        nextNode = k;
        return
    end
end     
end