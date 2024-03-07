%% RunFFNNOptimization.m
% Settings
clear all
clc
deltaTime = 0.1;

% Constants to TruckModel
M = 2000;
tau = 30;
ch = 40;
g = 9.82;
cb = 3000;
Tamb = 283;

% Constants
velMin = 1;
xStart = 0;
gearStart = 7;
TbStart = 500;
nHidden =  5;
maxValue = struct('alpha', 10, 'breakTemperature', 750, 'velocity', 25, 'w',5, 'gear', 10,'position',1000);

alpha = 5;%GetSlopeAngle(xStart, iSlope, iDataSet);
breakTemperature = TbStart;
breakPressure = 0;
gear = 7;
velocity = velMin;

[velocity, breakTemperature] = TruckModel(alpha, breakTemperature, breakPressure, gear, velocity, deltaTime,maxValue,M,tau,ch,g,cb,Tamb);

%%%%%%%%%%%%%%%%%%%%%%%%
nGeneration = 5000;
populationSize = 100;
nIn = 3;
nHidden = 5;
nOut = 2;
nGenes = nHidden*(nIn+1)+nOut*(nHidden+1);
iDataSet = 2;
tournamentSize = 5;                
tournamentProbability = 0.75;
crossoverProbability = 0.8;
mutationProbability = 0.02;
maximumFitnessTrain  = [0];

population = InitializePopulation(populationSize,nGenes);
for generation = 1:nGeneration
    fitnessList = zeros(1,populationSize);
    for i = 1:populationSize
        chromosome = population(i,:);
        [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, maxValue);
        fitnessList(i) = EvaluateIndividual(breakTemperature, gear, velocity, deltaTime,M,tau,ch,g,Tamb, nIn, iDataSet, maxValue, wIH,wHO,cb, velMin);
        if (fitnessList(i) > maximumFitnessTrain(end) ) 
            maximumFitnessTrain(end+1) = fitnessList(i);
            iBestWeightsTrain = i;
            chromosome = EncodeNetwork(wIH, wHO, maxValue);
            bestVariableValues = chromosome;
        end
    end

    temporaryPopulation = population;  
    for i = 1:2:populationSize
        i1 = TournamentSelect(fitnessList,tournamentProbability,tournamentSize);
        i2 = TournamentSelect(fitnessList,tournamentProbability,tournamentSize);
        if (rand < crossoverProbability) 
            newIndividualPair = Cross(population(i1,:), population(i2,:));
            temporaryPopulation(i,:) = newIndividualPair(1,:);
            temporaryPopulation(i+1,:) = newIndividualPair(2,:);
        else
            temporaryPopulation(i,:) = population(i1,:);
            temporaryPopulation(i+1,:) = population(i2,:);     
        end
    end
    temporaryPopulation(1,:) = population(iBestWeightsTrain,:);

    for i = 2:populationSize
        tempIndividual = Mutate(temporaryPopulation(i,:),mutationProbability);
        temporaryPopulation(i,:) = tempIndividual;
    end
    population = temporaryPopulation;
end