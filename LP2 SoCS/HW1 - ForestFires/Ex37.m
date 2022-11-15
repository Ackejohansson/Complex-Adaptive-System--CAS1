%% ex 3.6
clf, clc
N=16;
p=0.01;
f=0.2;
T = 1e4;
[fireSizes, forestSizes] = SimulateForestFire(N,p,f,T);

sortedFireSizes = sort(fireSizes, 'descend')./N^2;
n = (1:size(fireSizes,2))/size(fireSizes,2);

%%
clf
loglog(sortedFireSizes,n,'b')
hold on
index = sortedFireSizes < 0.20;
x = sortedFireSizes(index);
y = n(index);

b = 2200;
x = x(b:end);
y = y(b:end);
c = polyfit(log10(x),log10(y),1);
beta = c(1);
alpha=1-beta

loglog(sortedFireSizes, 10^(c(2))*sortedFireSizes.^beta,'r')
xlabel("n/N^2")
ylabel("C(n)")
txtCurve = 'Simulation of forest fires';
txtFit = sprintf('Curve fitted: \\alpha = %.4f',alpha);
legend(txtCurve,txtFit, 'Location','west')
hold off

%Settings for alpha
clf
loglog(sortedFireSizes,n,'b')
hold on
N=300;
x=linspace(1/N^2, 1,N^2);
a = (x.^(1-alpha));
a=a./a(1);
plot(x,a,'r')
xlabel("n/N^2")
ylabel("C(n)")

txtCurve = 'Simulation of forest fires';
txtFit = sprintf('Power law distr. w. \\alpha = %.4f',alpha);
legend(txtCurve,txtFit, 'Location','west')
hold off
    
