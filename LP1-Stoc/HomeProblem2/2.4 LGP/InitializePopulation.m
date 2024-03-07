function population = InitializePopulation(populationSize, nRegisters, nVariables, nOperators, nInstructions)
    chromoLength = randi([nInstructions,nInstructions*4]);
    population = [];
    for i = 1:populationSize
        chromosome = zeros(1, chromoLength);
        for j = 1:4:chromoLength
            operator = randi(nOperators);
            destination = randi(nVariables);
            operand1 = randi(nRegisters);
            operand2 = randi(nRegisters);
            chromosome(j:j+3) = [operator destination operand1 operand2];
        end
        population = [population; struct('Chromosome', chromosome)];
    end
end