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

%% Might work with this vectorized also
%function x = DecodeChromosome(chromosome, numberOfVariables, maximumVariableValue)
%    k = length(chromosome) / numberOfVariables;
%    bits = reshape(chromosome, k, numberOfVariables)';
%    powers = 2.^(-1:-1:-k);
%    x = -maximumVariableValue + 2 * maximumVariableValue * sum(bits .* powers, 2) ./ (1 - 2^(-k));
%end
