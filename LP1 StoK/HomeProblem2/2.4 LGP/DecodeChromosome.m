function estimatedFuncValue = DecodeChromosome(chromosome,registers)
for i = 1:4:length(chromosome)
    operator = chromosome(i);
    destination = chromosome(i+1);
    operand1 = chromosome(i+2);
    operand2 = chromosome(i+3);
    
    op1 = registers(operand1);
    op2= registers(operand2);
    switch operator
        case 1 
            registers(destination) = op1 + op2;
        case 2 
            registers(destination) = op1 - op2;
        case 3 
            registers(destination) = op1 * op2;
        case 4 
            if op2 == 0
                registers(destination) = op1*1e7;
            else
                registers(destination) = op1/op2;
            end
        otherwise
            error('Operator range exceeded')
    end
end
    estimatedFuncValue = registers(1);
end