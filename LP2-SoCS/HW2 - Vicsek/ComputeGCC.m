function c = ComputeGCC(population,R,M)
N=length(population);
area = zeros(N,1);
[V,indexEdge] = voronoin(M);
for i=1:N
    P = V(indexEdge{i},:);
    [~, area(i)] = convhull(P(:,1),P(:,2));
end
c = mean(area < pi*R^2);
end