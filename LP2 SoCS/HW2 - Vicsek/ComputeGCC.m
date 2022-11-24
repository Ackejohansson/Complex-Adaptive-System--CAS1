function c = ComputeGCC(population,R,M)
N=length(population);
counter=0;
A = pi*R^2;
[V,indexEdge] = voronoin(M);
for i=1:N
    P = V(indexEdge{i},:);
    [~, area] = convhull(P(:,1),P(:,2));
    if area < A
       counter = counter+1; 
    end
end
c = counter/N;
end