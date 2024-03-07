function [cross1, cross2] = GenerateCrossoverPoints(individual,nOperators)
    cross1 = nOperators * randi(length(individual)/nOperators);
    if cross1 == length(individual)
        cross2 = cross1;
    else
        cross2 = cross1 + nOperators*randi((length(individual)-cross1)/nOperators);
    end
end