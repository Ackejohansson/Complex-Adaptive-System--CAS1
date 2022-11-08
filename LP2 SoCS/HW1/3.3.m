%% 3.3
clc, clf
N=100;
alpha = 1.18;
n = linspace(1,N^2,N^2);

p=1./n.^alpha;
a=sum(p);


for k = 1:N^2
   c(k) = sum(p(k:end))/a;
end
loglog(n/N^2,c,'o')

%% 3.3 TEST HIGH PERFORMANCE
clc, clf
N=10;
alpha = 1.18;
n = linspace(1,N^2,N^2);
p=1./n.^alpha;
a=sum(p);

for k = 1:N^2
   c(k) = sum(p(k:end))/a;
end
loglog(n/N^2,c,'o')

%% 3.3 TEST HIGH PERFORMANCE
clc, clf
N=10;
alpha = 1.18;
n = linspace(1,N^2,N^2);
p=1./n.^alpha;
a=sum(p);

for k = 1:N^2
   c(k) = sum(p(k:end))/a;
end
loglog(n/N^2,c,'o')
