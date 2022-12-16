function [xList, yList] = CreateHenonMap(a,b,nrOfInitConditions,nrOfIterations,transient)
% Pretty ugly to have 3 variables
% x0 holds initialcondition, x used to generate traj, xList hold all traj
x0 = linspace(-0.1, 0.1, nrOfInitConditions);
y0 = linspace(-0.1, 0.1, nrOfInitConditions);
% x = zeros(1, nrOfIterations);
% y = zeros(1, nrOfIterations);
xList = zeros(nrOfInitConditions, nrOfIterations);
yList = zeros(nrOfInitConditions, nrOfIterations);
    for i=1:nrOfInitConditions
        xList(i,1) = x0(i);
        yList(i,1) = y0(i);
        for j=1:nrOfIterations-1
            xList(i, j+1) = yList(i,j) + 1 - a * xList(i,j)^2;
            yList(i, j+1) = b*xList(i,j);
        end
    end
xList(:,1:transient) = [];
yList(:,1:transient) = [];
end