function w = TrainMap(w, x, sigma, nNeurons, eta)
    i0 = GetWinningNeuron(w,x);
    dw = zeros(size(w));

    for i = 1:nNeurons
        for j = 1:nNeurons
            for k = 1:4
                dw(i,j,k) = eta * NeighbourhoodFunction(i0,i,j,sigma)*(x(k)-w(i,j,(k)));
            end
        end
    end
    w = w + dw;
end