%% 11.1
clc, clf, clear
% Population settings
N = 1000;
L = 100;

% S 0
% I -1 
% R 1

% Disease settings
recoveryRate = 0.01;
movementProb = 0.8;
infectionRate = 0.6;
deathProb = 0.01;
initI = 0.01;
suseptableProb = 0.01;

% Initialize population
I = [];
S=[];
R=[];
D=[];
agents = zeros(N,3);
agents(:,1:2) = randi(L,N,2);
agents(1:N*initI,3) = -1;

while sum(agents(:,3)==-1)>0
    agents = Move(agents,movementProb,L);
    agents = Infect(agents,infectionRate);
    agents = Die(agents, deathProb);
    agents = Recover(agents,recoveryRate);
    agents = FromRtoS(agents,suseptableProb);
    
    [Svec,Ivec,Rvec] = DrawPlot(agents,L);
 
    S(1,end+1) = sum(Svec);
    I(1,end+1) = sum(Ivec);
    R(1,end+1) = sum(Rvec);
    D(1,end+1) = N-(S(end)+I(end)+R(end));   
end

% Plot evolution
clf
t = 1:length(Iev);
figure()
plot(t,S,'b')
hold on
plot(t,I,'r')
plot(t,R,'g')
plot(t,D,'black')
axis([0 length(Iev) 0 N])
xlabel("t")
ylabel("Number of agents")
legend("S","I","R","D")
title("Time evolution of disease")
