function iSelectedIndividual = TournamentSelect(fitnessList, tournamentProb, tournamentSize)
    populationSize = length(fitnessList);
    fitness = zeros(tournamentSize,2);
    
    for i = 1:tournamentSize
        iTmp = 1 + fix(rand*populationSize);
        fitness(i,:) = [fitnessList(iTmp), iTmp];
    end
    fitness = sortrows(fitness);
    
    iSelectedIndividual = 0; 
    while iSelectedIndividual == 0 
        if rand<tournamentProb
            iSelectedIndividual = fitness(end,2);
        else
            fitness = fitness(1:end-1,:);
            if size(fitness,1) == 1 
                iSelectedIndividual = fitness(1,2);  
            end
        end
    end
end
