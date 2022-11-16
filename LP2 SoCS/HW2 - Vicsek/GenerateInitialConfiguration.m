function [C, a,b] = GenerateInitialConfiguration(N,L)
    C = zeros(L,L);
    while sum(sum(C)) < N
        C(randi(numel(C))) = 1;
    end
    [a,b] = find(C==1);
end