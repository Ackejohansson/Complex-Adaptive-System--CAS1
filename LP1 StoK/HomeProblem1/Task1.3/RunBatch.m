%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numberOfRuns = 100;                % Do NOT change 
populationSize = 100;              % Do NOT change
maximumVariableValue = 5;          % Do NOT change (x_i in [-a,a], where a = maximumVariableValue)
numberOfGenes = 50;                % Do NOT change
numberOfVariables = 2;		       % Do NOT change
numberOfGenerations = 300;         % Do NOT change
tournamentSize = 2;                % Do NOT change
tournamentProbability = 0.75;      % Do NOT change
crossoverProbability = 0.8;        % Do NOT change


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Batch runs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mutationProbability = 0.02; 
%mutationProbability = [0, 0.005, 0.01, 0.015, 0.02, 0.025, 0.03, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]; %For all my mu's

maximumFitnessList002 = zeros(numberOfRuns,length(mutationProbability));
for j = 1:length(mutationProbability)
    sprintf('Mutation rate = %0.5f', mutationProbability(j))

    for i = 1:numberOfRuns 
        [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability(j), numberOfGenerations);
        sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
        maximumFitnessList002(i,j) = maximumFitness;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Summary of results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

average002 = mean(maximumFitnessList002());
median002 = median(maximumFitnessList002);
std002 = sqrt(var(maximumFitnessList002));
sprintf('PMut = 0.02: Median: %0.10f, Average: %0.10f, STD: %0.10f', median002, average002, std002)

%   Use multiple values for P to get a nice plot, else comment out
%hold on
%plot(mutationProbability,median002)
%plot([1/numberOfGenes,1/numberOfGenes],[0.992,1],'--')
%legend({'y = fitness(P_{mut})','y = 1/(#genes)'},'Location','southwest')
%hold off