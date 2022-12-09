function wOUT = TrainReservoirComputer(wIN,w,neurons,k, x)
    r = zeros(neurons,length(x));
    for t = 1:length(x)-1
        r(:,t+1) = tanh(w*r(:,t) + wIN*x(:,t));
    end
    
    if 0 == det((r*r' + k*eye(neurons)))
        disp("Matriz is singular. Problem is unstable")
    end
    
    wOUT = x*r.' *inv((r*r' + k*eye(neurons)));
end