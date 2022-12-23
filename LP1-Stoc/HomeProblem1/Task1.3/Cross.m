function newIndividuals = Cross(individual1, individual2)
nGenes = size(individual1,2);
newIndividuals = zeros(2, nGenes);

crossoverPoint = randi(nGenes-1);
crossover = 1:nGenes <= crossoverPoint;
newIndividuals(1,:) = [individual1(crossover), individual2(~crossover)];
newIndividuals(2,:) = [individual2(crossover), individual1(~crossover)];
end