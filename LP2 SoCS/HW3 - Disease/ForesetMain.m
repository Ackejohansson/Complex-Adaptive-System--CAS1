%% 11.1
clc, clf, clear
% Population settings
N = 300;
L = 20;

% Disease settings
gamma = 0.10;
d = 0.8;
beta = 0.5;

% Initialize population
agents = zeros(N,3);
agents(:,1:2) = randi(L,N,2);
agents(1:10,3) = -1;

while sum(agents(:,3)==-1)>0
    agents = Move(agents,d,L);
    agents = Infect(agents,beta);
    agents = Recover(agents,gamma);
    DrawPlot(agents,L)
    
    % add sum of S, I and R
end