%% ex 3.4
clf, clc
N=10;
p=0.01;
f=0.2;
T = 5000;
alpha = 1.18;
[fireSizes, forestSizes] = SimulateForestFire(N,p,f,T);

sortedFireSizes = sort(fireSizes, 'descend');
n = (1:size(fireSizes,2))/size(fireSizes,2);
%%


% TODO FIT LINE 
clf

beta = 1-alpha;

loglog(n,sortedFireSizes/N^2)
hold on

%loglog(n,exp(n))
%
%hold off

