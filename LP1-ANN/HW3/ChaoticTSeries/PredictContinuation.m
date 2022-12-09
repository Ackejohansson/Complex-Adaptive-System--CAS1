function O = PredictContinuation(wIN, w, wOUT,T,N,neurons,x)
    r = zeros(neurons,1);
    for t = 1:length(x)
        r = tanh(w*r + wIN*x(:,t));
    end
    
    O = zeros(N,T);
    for t = 1:T
       O(:,t) = wOUT*r;
       r = tanh(w*r + wIN * O(:,t));
    end
end