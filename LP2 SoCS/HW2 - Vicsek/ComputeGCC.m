function c = ComputeGCC(population,R)
N=length(population);
counter=0;

dt = delaunayTriangulation(population(:,1),population(:,2));
[V,indexEdge] = voronoiDiagram(dt); % E contains edges index
for i=1:N
P = V(indexEdge{i},:);
if sum(sum(isinf(P)))
    continue;
end
[~, area] = convhull(P(:,1),P(:,2));

if area < pi*R^2
   counter = counter+1; 
end
c = counter/N;
end