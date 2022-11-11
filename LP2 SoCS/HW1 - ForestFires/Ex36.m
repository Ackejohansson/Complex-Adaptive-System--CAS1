%% 36
clf, clc
N=256;
p=0.01;
f=0.2;
T = 10000;

[fireSizes, forestSizes] = SimulateForestFire(N,p,f,T);
n = (1:size(fireSizes,2))/size(fireSizes,2);
sortedFireSizes = sort(fireSizes, 'descend');
%%
% Settings for alpha
alpha = 1.16;

clf, clc
loglog(sortedFireSizes/N^2,n,'b')
hold on


x=linspace(1/N^2, 1,N^2);
a = (x.^(1-alpha));
a=a./a(1);
plot(x,a,'r')