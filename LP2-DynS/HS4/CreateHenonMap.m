function [xList, yList] = CreateHenonMap(a,b,nrOfInitConditions,nrOfIterations,transient)
% xList,yList hold all trajectories
xList = zeros(nrOfInitConditions, nrOfIterations);
yList = zeros(nrOfInitConditions, nrOfIterations);
xList(:,1) = linspace(-0.1, 0.1, nrOfInitConditions);
yList(:,1) = linspace(-0.1, 0.1, nrOfInitConditions);
for i = 1:nrOfInitConditions
    for j=1:nrOfIterations-1
        xList(i, j+1) = yList(i,j) + 1 - a * xList(i,j)^2;
        yList(i, j+1) = b*xList(i,j);
    end
end
xList(:,1:transient) = [];
yList(:,1:transient) = [];
end