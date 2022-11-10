%% ex 3.4
clf, clc
N=16;
p=0.01;
f=0.2;
T = 5000;
fireSizes = SimulateForestFire(N,p,f,T);



hax=gca;
hax.XTick=0:1:N;
hax.YTick=0:1:N;
hax.GridAlpha = 1;
axis square

sortedFireSizes = sort(fireSizes, 'descend');
n = (1:size(fireSizes,2))/size(fireSizes,2);

loglog(sortedFireSizes/N^2,n,'o')



git