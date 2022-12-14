%% main
clc, clear all
clf
N=16;
p=0.01;
f=0.2;
T = 1e3;

figure(1)
plot([0:N; 0:N], [0:N; 0:N])
grid
hax=gca;
hax.XTick=0:1:N;
hax.YTick=0:1:N;
hax.GridAlpha = 1;

xlim([0 N])
ylim([0 N])
axis square

[fireSizes, forestSizes] = SimulateForestFireList(N,p,f,T)
%% 38


[fireSizes, forestSizes] = SimulateForestFireList(N,p,f,T)

sortedFireSizes = sort(fireSizes, 'descend');
n = (1:size(fireSizes,2))/size(fireSizes,2);

% Plot
loglog(sortedFireSizes/N^2,n,'b')
xlabel("n/N^2")
ylabel("C(n)")
hold off
%%

hold on
fill([0 1 1 0]+i-1, [0 0 1 1]+j-1, 'g')
hold off
hold on
fill([0 1 1 0]+m-1, [0 0 1 1]+n-1,'w','Edgecolor', 'black')
drawnow;
hold off
