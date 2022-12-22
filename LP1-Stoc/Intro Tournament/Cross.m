function newChromosomePair = Cross(chromosome1, chromosome2)
nGenes = size(chromosome1,2);
newChromosomePair = zeros(2, nGenes);

crossoverPoint = randi(nGenes-1);
crossover = 1:nGenes <= crossoverPoint;
newChromosomePair(1,:) = [chromosome1(crossover), chromosome2(~crossover)];
newChromosomePair(2,:) = [chromosome2(crossover), chromosome1(~crossover)];
end