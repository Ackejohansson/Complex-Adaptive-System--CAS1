function x = DecodeChromosome(chromosome,numberOfVariables,maximumVariableValue)
a = maximumVariableValue;
k = fix(length(chromosome)/numberOfVariables) ;
x = zeros(1,numberOfVariables);

    for j = 1:numberOfVariables
        for i = 1:k
            x(j) = x(j) + (2^(-i))*chromosome(i+(j-1)*k);
        end
        x(j) = -a + 2*a*x(j)/(1-2^(-k));
    end
end

