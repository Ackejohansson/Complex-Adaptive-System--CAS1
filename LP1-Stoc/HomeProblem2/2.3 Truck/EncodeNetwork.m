function chromosome = EncodeNetwork(wIH, wHO, maxValue)
    wIHreshaped = reshape(wIH', [1,size(wIH,1)*size(wIH,2)]);
    wHOreshaped = reshape(wHO', [1,size(wHO,1)*size(wHO,2)]);
    chromosome = [wIHreshaped wHOreshaped]./maxValue.w; 
end