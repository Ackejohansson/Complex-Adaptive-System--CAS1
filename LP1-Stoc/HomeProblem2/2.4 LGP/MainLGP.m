%%
clc, clear all
constants = [-1, 3, 1];
nConstants=length(constants);
nVariables = 7;

nRegisters = nVariables+nConstants;
nOperators = 4; % + - * /
nInstructions = 5;

Generation = 0;
populationSize = 200;
tournamentProbability = 0.75;
crossoverProbability = 0.2;
mutationProbability = 0.04;
tournamentSize = 7;

population = InitializePopulation(populationSize, nRegisters, nVariables, nOperators, nInstructions);
maximumFitness = 0.0;
f = LoadFunctionData;

while maximumFitness < 10000 || Generation > 30000
    fitnessList = zeros(1,populationSize);
    for i = 1:populationSize
        chromosome = population(i).Chromosome;
        [fitnessList(i),funcEstimate] = EvaluateIndividual(chromosome,nVariables,constants);
        if (fitnessList(i) > maximumFitness)
            bestIndividual = population(i,:);
            iBestIndividual = i;
            maximumFitness = fitnessList(i);
            
            hold off
            plot(f(:,1), f(:,2))
            title(("The fitness: " + maximumFitness + " of the estimated function"),'interpreter','latex')
            hold on
            plot(f(:,1),funcEstimate)
            drawnow;  
        end
    end

    tempPopulation = population;
    for i = 1:2:populationSize
        i1 = TournamentSelect(fitnessList, tournamentProbability, tournamentSize);
        i2 = TournamentSelect(fitnessList, tournamentProbability, tournamentSize);
        
        chromo1 = population(i1,:);
        chromo2 = population(i2,:);
        if (rand < crossoverProbability)
            newChromoPair = Cross(chromo1,chromo2,nOperators);
            tempPopulation(i,:) = newChromoPair(1,:);
            tempPopulation(i+1,:) = newChromoPair(2,:);
        else
            tempPopulation(i,:) = chromo1;
            tempPopulation(i+1,:) = chromo2;
        end
    end

    
    tempPopulation(1,:) = population(iBestIndividual,:);
    for i = 2:populationSize
        tempPopulation(i).Chromosome = Mutate(tempPopulation(i).Chromosome, ...
                         mutationProbability, nVariables, nOperators, nRegisters);
    end
    population = tempPopulation;
    Generation = Generation + 1
end