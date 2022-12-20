%% Main
%
clc, clf, clear
% Population settings
N = 1000;
L = 100;

% Disease settings
infectionRate = 0.6;   % beta

% 11.1
initI = 0.01;
movementProb = 0.8;     % d
recoveryRate = 0.02;    % gamma

% 11.2
deathProb = 0.0001;   % mu

%11.3
suseptableProb = 0.01; % alpha

%Initialize population
I = [];
S=[];
R=[];
D=[];
agents = zeros(N,3);
agents(:,1:2) = randi(L,N,2);
agents(1:N*initI,3) = -1;

while sum(agents(:,3)==-1)>0
    tic
    agents = Move(agents,movementProb,L);
    agents = Infect(agents,infectionRate);
    agents = Die(agents, deathProb);
    agents = Recover(agents,recoveryRate);
    agents = FromRtoS(agents,suseptableProb);
    
    s = agents(:,3) == 0;
    i = agents(:,3) == -1;
    r = agents(:,3) == 1;
    
    DrawPlot(agents,L,s,i,r);
 
    S(1,end+1) = sum(s);
    I(1,end+1) = sum(i);
    R(1,end+1) = sum(r);
    D(1,end+1) = N-(S(end)+I(end)+R(end));  
    toc
end

%% Plot evolution
clf
t = 1:length(I);
figure(2)
plot(t,S,'b')
hold on
plot(t,I,'r')
plot(t,R,'g')
plot(t,D,'black')
axis([0 length(I) 0 N])
xlabel("t")
ylabel("Number of agents")
legend("S","I","R","D")
title("Time evolution of disease")

