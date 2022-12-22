function iSelected = TournamentSelect(fitness, pTournament)
populationSize = size(fitness,1);
iTmp1 = randi(populationSize);
iTmp2 = randi(populationSize);

if fitness(iTmp1) > fitness(iTmp2) && rand < pTournament
        iSelected = iTmp1;
elseif fitness(iTmp1) < fitness(iTmp2) && rand > pTournament
    iSelected = iTmp1;
else
    iSelected = iTmp2;
end
end

            
           