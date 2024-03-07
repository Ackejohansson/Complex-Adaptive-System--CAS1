function mutatedChromosome = Mutate(chromosome, mutationProbability) 
nGenes = size(chromosome,2);
mutatedChromosome = chromosome;

mutate = rand(1,nGenes) < mutationProbability;
mutatedChromosome(mutate) = double(~mutatedChromosome(mutate));
end