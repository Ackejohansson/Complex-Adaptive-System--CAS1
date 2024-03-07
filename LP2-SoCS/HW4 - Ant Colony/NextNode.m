function node=NextNode(currentNode,alpha,beta,weights,pheromones)
probability=pheromones(:,currentNode).^alpha.*(weights(:,currentNode).^beta);
[~,node]=max(probability);

probability = probability/sum(probability);
probabilitySum = 0;
r = rand;

for i=1:length(probability)
    probabilitySum = probabilitySum + probability(i);
    if r < probabilitySum
        node = i;
        return;
    end      
end
end