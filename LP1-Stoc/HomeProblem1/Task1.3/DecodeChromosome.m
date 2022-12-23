function x = DecodeChromosome(chromosome,numberOfVariables,maximumVariableValue)
k = fix(length(chromosome)/numberOfVariables) ;
x = zeros(1,numberOfVariables);

for j = 1:numberOfVariables
    for i = 1:k
        x(j) = x(j) + (2^(-i))*chromosome(i+(j-1)*k);
    end
    x(j) = -maximumVariableValue + 2*maximumVariableValue*x(j)/(1-2^(-k));
end
end