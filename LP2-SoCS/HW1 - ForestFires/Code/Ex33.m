%% 3.3
clf, clc, clear
alpha=1.18;
N=16;
r=linspace(0.1,10,10000);
p=r.^(-alpha);

plot(r,p)
ylabel('p(n)')
xlabel('n')
title('Power-law probability distribution')