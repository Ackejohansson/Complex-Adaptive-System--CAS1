%%
clear all
clc, clf

muValues = [0 1 10 100 1000];
%muValues = 1:1000;

eta = 0.0001;
xStart =  [1,2];
gradientTolerance = 1E-6;

for i = 1:length(muValues)
 mu = muValues(i);
 x(i,:) = RunGradientDescent(xStart,mu,eta,gradientTolerance);
 sprintf('x(1) = %3f, x(2) = %3f mu = %d',x(1),x(2),mu)
end

hold on
plot(muValues,x(:,1))
plot(muValues,x(:,2))
legend({'x_1','x_2'},'Location','southwest')
hold off