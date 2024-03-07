function i0 = GetWinningNeuron(w, x)
    d = zeros(40);
    for k = 1:4
        d = d + sqrt((w(:,:,k) - x(k)).^2); 
    end
    minimum = min(min(d));
    [i,j]=find(d==minimum);
    i0 = [i,j];
end