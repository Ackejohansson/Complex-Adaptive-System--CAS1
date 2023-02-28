%% Main
clc, clf, clear, close

% Population settings
N = 1000;
L = 100;
percentageInitiallyInfected = 0.01;

% Initialize agents
agents = [randi(L,N,2), zeros(N,1)];
agents(1:N*percentageInitiallyInfected,3) = -1;

%%%%% Disease settings %%%%%%%%%
infectionRate = 0.6;   % beta

% 11.1
movementProb = 0.8;     % d
recoveryRate = 0.01;    % gamma

% 11.2
deathProb = 0.0001;   % mu

%11.3
suseptableProb = 0.02; % alpha

I = []; S=[]; R=[]; D=[];
while sum(agents(:,3)==-1)>0
    agents = Move(agents,movementProb,L);
    agents = Infect(agents,infectionRate);
    agents = Die(agents, deathProb);
    agents = Recover(agents,recoveryRate);
    agents = FromRtoS(agents,suseptableProb);

    DrawPlot(agents,L);
 
    S(1,end+1) = sum(agents(:,3) == 0);
    I(1,end+1) = sum(agents(:,3) == -1);
    R(1,end+1) = sum(agents(:,3) == 1);
    D(1,end+1) = N-(S(end)+I(end)+R(end));  
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

