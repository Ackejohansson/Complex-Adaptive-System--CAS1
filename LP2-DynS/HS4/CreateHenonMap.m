function [xList, yList] = CreateHenonMap(a,b,nrOfInitConditions,nrOfIterations,transient)
x0 = linspace(-0.1, 0.1, nrOfInitConditions);
y0 = linspace(-0.1, 0.1, nrOfInitConditions);
x = zeros(1, nrOfIterations);
y = zeros(1, nrOfIterations);
xList = zeros(nrOfInitConditions, nrOfIterations-transient);
yList = zeros(nrOfInitConditions, nrOfIterations-transient);
    for i=1:nrOfInitConditions
        x(1) = x0(i);
        y(1) = y0(i);
        for j=1:nrOfIterations-1
            x(j+1) = y(j) + 1 - a * x(j)^2;
            y(j+1) = b*x(j);
        end
        xList(i,:) = x(transient+1:end);
        yList(i,:) = y(transient+1:end);
    end
end