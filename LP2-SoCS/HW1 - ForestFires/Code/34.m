%% ex 3.4
clf, clc, clear
p=0.01;
f=0.2;
T = 100000;

N=16;
[fireSizes16, forestSizes] = SimulateForestFire(N,p,f,T);
n16 = (1:size(fireSizes16,2))/size(fireSizes16,2);
sortedFireSizes16 = sort(fireSizes16, 'descend');

N=256;
[fireSizes256, forestSizes] = SimulateForestFire(N,p,f,T);
n256 = (1:size(fireSizes256,2))/size(fireSizes256,2);
sortedFireSizes256 = sort(fireSizes256, 'descend');

%%
clf
N=16;
subplot(1,2,1);
loglog(sortedFireSizes16/N^2,n16)
ylabel('C(n)')
xlabel('n/N^2')
title('N=16')

N=256;
subplot(1,2,2);
loglog(sortedFireSizes256/N^2,n256)
xlabel('n/N^2')
title('N=256')