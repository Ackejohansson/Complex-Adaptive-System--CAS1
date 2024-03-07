function [H, nTot] = CreateHistogram(epsilon, xList, yList)
xEdges = min(xList,[], 'all'):epsilon:max(xList,[],'all');
yEdges = min(yList,[], 'all'):epsilon:max(yList,[],'all');
[H, ~, ~]=histcounts2(xList,yList,xEdges,yEdges);
nTot= sum(sum(H));
end