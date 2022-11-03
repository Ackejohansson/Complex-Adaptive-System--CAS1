function mutatedIndividual = Mutate(individual, mutationProbability)
    nGenes = size(individual,2);
    mutatedIndividual = individual;
    for i = 1:nGenes
        if rand < mutationProbability
            mutatedIndividual(i) = 1 - individual(i);
        end
    end
end