function newIndividuals = Cross(individual1, individual2,nOperators)

indi1 = individual1.Chromosome;
indi2 = individual2.Chromosome;

[cross1, cross2] = GenerateCrossoverPoints(indi1,nOperators);
[cross3, cross4] = GenerateCrossoverPoints(indi2,nOperators);

indi1Crossed = [indi1(1:cross1) indi2(cross3+1:cross4) indi1(cross2+1:end)]; 
indi2Crossed = [indi2(1:cross3) indi1(cross1+1:cross2) indi2(cross4+1:end)]; 

newIndividuals(1,:) = struct('Chromosome', indi1Crossed);
newIndividuals(2,:) = struct('Chromosome', indi2Crossed);

end
