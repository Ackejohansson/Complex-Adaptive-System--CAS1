%% ex 3.4
clf, clc
N=16;
p=0.01;
f=0.2;
T = 5000;
alpha = 1.18;
[fireSizes, forestSizes] = SimulateForestFire(N,p,f,T);

sortedFireSizes = sort(fireSizes, 'descend');
n = (1:size(fireSizes,2))/size(fireSizes,2);

% Plot
loglog(sortedFireSizes/N^2,n,'b')
xlabel("n/N^2")
ylabel("C(n)")
hold off