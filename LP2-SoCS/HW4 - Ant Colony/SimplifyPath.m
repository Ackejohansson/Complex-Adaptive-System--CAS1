function simplifiedPath = SimplifyPath(paths,maxNrSteps)

simplifiedPath = zeros(size(paths,1),maxNrSteps);
for i = 1:size(paths,1)
    tmpPath = nonzeros(paths(i,:))';
    newPath = [];%zeros(size(tmpPath,2),1)';
    for j = 1:size(tmpPath,2)
        index = find(newPath == paths(i,j));  
        if isempty(index)
            newPath = [newPath,tmpPath(j)];
            %newPath(j) = tmpPath(j);
        else
           newPath(index+1:end) = [];
        end
    end
    simplifiedPath(i,1:size(newPath,2)) = newPath;
end

end
