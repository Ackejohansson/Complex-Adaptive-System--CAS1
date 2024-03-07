function y = EvaluateBestIndividual(chromosome,nVariables,constants)
    functionData = LoadFunctionData;
    estimatedFuncValue = zeros(1,length(functionData));
    for i = 1:length(functionData)
        registers = [zeros(1, nVariables) constants];
        registers(1) = functionData(i,1);
        estimatedFuncValue(i) = DecodeChromosome(chromosome,registers);
    end
    y = estimatedFuncValue;
end 