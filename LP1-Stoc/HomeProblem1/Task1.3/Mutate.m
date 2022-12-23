function mutatedIndividual = Mutate(individual, mutationProbability)
nGenes = size(individual,2);
mutatedIndividual = individual;

mutate = rand(1,nGenes) < mutationProbability;
mutatedIndividual(mutate) = double(~mutatedIndividual(mutate));
end


