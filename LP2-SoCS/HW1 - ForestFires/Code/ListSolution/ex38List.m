%% 38
clf, clc, clear
%N = 1024;
T = 1e5;
b = 1;
p=0.01;
f=0.2;
alpha=[];
N=64;
for j=1:10
[fireSizes, forestSizes] = SimulateForestFireList(N,p,f,T);

sortedFireSizes = sort(fireSizes, 'descend')./N^2;
n = (1:size(fireSizes,2))/size(fireSizes,2);

index = sortedFireSizes < 0.20;
x = sortedFireSizes(index);
y = n(index);
x = x(b:end);
y = y(b:end);
c = polyfit(log10(x),log10(y),1);
alpha(j)=1-c(1);
end

meedeel = mean(alpha)
%%
clc
N = [16, 32, 64, 128, 256, 512];
%alpha = [1.2441, 1.2123, 1.1900  ,1.1706];

alpha = [1.2449, 1.2125, 1.1901, 1.1769, 1.1706, 1.1561];
alpha = [1.3698, 1.2934, 1.2423, 1.1769, 1.1706, 1.1561];
alpha = [1.3698, 1.2934, 1.1901, 1.1769, 1.1706, 1.1561];
alpha = [1.2449, 1.2125, 1.1901, 1.1769, 1.1706, 1.1561];

plot(1./N, alpha,'o')
