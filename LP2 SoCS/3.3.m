%% 3.3
clc, clf
N=1e2;
alpha = 1.15;
n = linspace(0,N^2,N^2);
r = linspace(0,1,N^2);

C = n.^((1-alpha));
loglog(r,C)
