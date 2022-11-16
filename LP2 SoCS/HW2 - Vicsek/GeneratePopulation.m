function [population] = GeneratePopulation(a,b,N)
theta = zeros(N,1);
for i = 1:N
    theta(i) = rand*2*pi;
end
population = [a,b,theta];
end