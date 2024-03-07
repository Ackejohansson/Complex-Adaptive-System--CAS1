%% 11.1
clc, clf, clear
% Population settings
N = 1000;
L = 100;

% Disease settings
initI = 0.24; 
movementProb = 0.8; %d
nTrails = 5;
Ravg = zeros(nTrails,nTrails);

beta = linspace(0.05,1,nTrails);
for i=1:nTrails
infectionRate = beta(i)
gamma = linspace(infectionRate,infectionRate/100,nTrails);
for j=1:nTrails
    recoveryRate = gamma(j);
    R=zeros(1,1);
    for a=1:1
        t=0;
        agents = zeros(N,3);
        agents(:,1:2) = randi(L,N,2);
        agents(1:N*initI,3) = -1;

        while sum(agents(:,3)==-1)>0 && t<1500
            agents = Move(agents,movementProb,L);
            agents = Infect(agents,infectionRate);
            agents = Recover(agents,recoveryRate);
            t=t+1;
        end
        R(a) = sum(agents(:,3) == 1)+sum(agents(:,3) == -1);
    end
Ravg(j,i) = mean(R);
end
end
%%
heatmap(Ravg)
xlabel("\beta")
ylabel("\beta/\gamma")
%%
% Plot evolution
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

