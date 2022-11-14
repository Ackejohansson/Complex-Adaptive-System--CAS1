%% ex 3.4
clf, clc, clear
N=16;
p=0.01;
f=0.2;
T = 5000;


[fireSizes, forestSizes] = SimulateForestFire(N,p,f,T);

n = (1:size(fireSizes,2))/size(fireSizes,2);
sortedFireSizes = sort(fireSizes, 'descend');
loglog(sortedFireSizes/N^2,n,'b')
hold on
