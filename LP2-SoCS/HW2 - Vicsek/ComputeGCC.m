function c = ComputeGCC(population,R,M)
N=length(population);
A = pi*R^2;
[V,indexEdge] = voronoin(M);
area = zeros(N,1);
for i=1:N
    P = V(indexEdge{i},:);
    [~, area(i)] = convhull(P(:,1),P(:,2));
end
c = sum(area < A)/N;
end