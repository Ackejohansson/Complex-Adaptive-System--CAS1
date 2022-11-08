%% 3.3
clc, clf, clear
N=16;
alpha = 1.5;
n = linspace(1,N^2,N^2);
p=1./n.^alpha;
a=sum(p);
for k = 1:N^2
   c(k) = sum(p(k:end))/a;
end
loglog(n/N^2,c,'o')



%% 3.3 Test performance
clc, clf
N=106;
alpha = 1.18;
n = linspace(1,N^2,N^2);

c = n.^1/((1-alpha))
loglog(n/N^2,c,'o')

