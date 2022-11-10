%% 3.3 Test performance
clc, clf
N=16;
alpha = 1.18;
x = linspace(1,N^2,N^2);
c = 1./(x.^(1-alpha));

r =linspace(1,0,N^2);
loglog(r,c,'o')


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
