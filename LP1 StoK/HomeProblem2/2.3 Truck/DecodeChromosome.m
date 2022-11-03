function [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, maxValue)
    wIH = reshape(chromosome(1:nHidden*(nIn+1)),[nIn+1],nHidden)' *maxValue.w;
    wHO = reshape(chromosome(nHidden*(nIn+1)+1:end), [nHidden+1, nOut])'*maxValue.w;
end
