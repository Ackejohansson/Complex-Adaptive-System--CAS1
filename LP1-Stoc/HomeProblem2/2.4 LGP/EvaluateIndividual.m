function [fitness,estimatedFuncValue] = EvaluateIndividual(chromosome,nVariables,constants)
functionData = LoadFunctionData;
estimatedFuncValue = zeros(1,length(functionData));

for i = 1:length(functionData)
    registers = [zeros(1, nVariables) constants];
    registers(1) = functionData(i,1);
    estimatedFuncValue(i) = DecodeChromosome(chromosome,registers);
end
sumDiffTmp = sum((estimatedFuncValue'-functionData(:,2)).^2);
error = sqrt(1/length(functionData).*sumDiffTmp);
fitness = 1/error;
end 