%% 11.1
clc, clf, clear
% Population settings
N = 1000;
L = 100;
t=1;

% Disease settings
gamma = 0.01;
d = 0.8;
beta = 0.6;

% Initialize population
I = logical([]);
S=logical([]);
R=logical([]);
agents = zeros(N,3);
agents(:,1:2) = randi(L,N,2);
agents(1:10,3) = -1;

while sum(agents(:,3)==-1)>0
    agents = Move(agents,d,L);
    agents = Infect(agents,beta);
    agents = Recover(agents,gamma);
    
    I(:,end+1) = agents(:,3) == -1;
    S(:,end+1) = agents(:,3) == 0;
    R(:,end+1) = agents(:,3) == 1;
    
    DrawPlot(agents,L,I,S,R)
end

% Compute evolution
Iev = sum(I,1);
Sev = sum(S,1);
Rev = sum(R,1);

% Plot evolution
figure(2)
plot(1:length(Iev),Sev,'b')
hold on
plot(1:length(Iev),Iev,'r')
plot(1:length(Iev),Rev,'g')
axis([0 length(Iev) 0 N])
xlabel("t")
ylabel("Number of agents")
legend("S","I","R")
title("Time evolution of disease")
