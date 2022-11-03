function mutatedIndividual = Mutate(individual,mutationProb, ...
             nVariables, nOperators, nRegisters)
    nGenes = size(individual,2);
    mutatedIndividual = individual;
    for i = 1:nGenes
        if rand < mutationProb
            switch rem(i,4)
                case 0
                    mutatedIndividual(i)=randi(nRegisters);
                case 1
                    mutatedIndividual(i)=randi(nOperators);
                case 2
                    mutatedIndividual(i)=randi(nVariables);
                case 3
                    mutatedIndividual(i)=randi(nRegisters);
            end
        end
    end
end
