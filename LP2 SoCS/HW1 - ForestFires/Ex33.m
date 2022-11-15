%% 3.3
clf, clc, clear
alpha=1.18;
N=256;
r=linspace(1,N^2,10000);
p=r.^(-alpha);
p = p./((p(1)));

plot(log(r/N^2),log(p))
ylabel('log(p)')
xlabel('n/N^2')
title('Power-law probability distribution: p(n) \propto x^{-\alpha}')
