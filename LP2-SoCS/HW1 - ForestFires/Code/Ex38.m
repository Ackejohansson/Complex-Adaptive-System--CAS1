%% ex 3.8
clf, clc, clear
N = 64;
T = 1e6;
b = 2200;

p=0.01;
f=0.2;
alpha=[];

for j=1:10
[fireSizes, forestSizes] = SimulateForestFire(N,p,f,T);

sortedFireSizes = sort(fireSizes, 'descend')./N^2;
n = (1:size(fireSizes,2))/size(fireSizes,2);

% clf
index = sortedFireSizes < 0.20;
x = sortedFireSizes(index);
y = n(index);
x = x(b:end);
y = y(b:end);
c = polyfit(log10(x),log10(y),1);
alpha(j)=1-c(1);
end
medel = mean(alpha)
%% Infoga medel
clc
N = [16, 32, 64, 128, 256];
alpha = [1.2449, 1.2125, 1.1901, 1.1769, 1.1706];
plot(1./N, alpha,'r')

%%
alpha=[1.24397710444642,1.21789044034107,1.18826438354351,1.17789151213903,1.16859806492203]
allN=[16,32,64,128,256];
plot(1./allN,alpha)