%% HW1 - One step error
clc, clear all;
P = [12, 24, 48, 70, 100, 120];
N = 120;
trials = 1e5;
errors = zeros(length(P),1);
possibleValues = [-1,1];

for k=1:length(P)
    for i = 1:trials
        s = possibleValues(randi(length(possibleValues), P(k), N));
        w = 1/N * (s') * s;
        w(1:1+size(w,1):end) = 0;
        
        m = randi(N);
        randomPattern = randi(P(k));
    
        x = s(randomPattern,:);
        b = w(m,:) * x';
        if b == 0
            sNext = 1;
        else
            sNext = sign(b);
        end
    
        if sNext ~= x(m)
            errors(k,1) = errors(k,1) + 1;
        end
    end
end
