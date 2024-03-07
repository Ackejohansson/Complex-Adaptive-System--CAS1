function x = DecodeChromosome(chromosome,variableRange)
nGenes = size(chromosome,2);
nHalf = fix(nGenes/2);
x = zeros(1,2);

for j = 1:nHalf
    x(1) = x(1) + chromosome(j)*2^(-j);
end
x(1) = -variableRange + 2*variableRange*x(1)/(1 - 2^(-nHalf));

for j = 1:nHalf
    x(2) = x(2) + chromosome(j+nHalf)*2^(-j);
end
x(2) = -variableRange + 2*variableRange*x(2)/(1 - 2^(-nHalf));

end