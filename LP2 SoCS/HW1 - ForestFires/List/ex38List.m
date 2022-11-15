%% 38
clf, clc, clear
%N = 1024;
T = 1e5;
b = 2200;
p=0.01;
f=0.2;
alpha=[];
allaN = [512,1024];
for o = 1:2
N=allaN(o);
for j=1:10
[fireSizes, forestSizes] = SimulateForestFireList(N,p,f,T);

sortedFireSizes = sort(fireSizes, 'descend')./N^2;
n = (1:size(fireSizes,2))/size(fireSizes,2);

%
% clf
index = sortedFireSizes < 0.20;
x = sortedFireSizes(index);
y = n(index);
x = x(b:end);
y = y(b:end);
c = polyfit(log10(x),log10(y),1);
alpha(j)=1-c(1);
end
if N == 1024
    medel1024 = mean(alpha)
end
if N == 512
    meedeel512 = mean(alpha)
end
end
%%
clc
N = [16, 32, 64, 128, 256];
%alpha = [1.2441, 1.2123, 1.1900  ,1.1706];
alpha = [1.2449, 1.2125, 1.1901, 1.1769, 1.1706];

plot(1./N, log(alpha),'r')
