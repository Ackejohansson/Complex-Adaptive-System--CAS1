function c = ComputeGCC(population,R,M)
N=length(population);
counter=0;
[V,indexEdge] = voronoin(M);
for i=1:N
    P = V(indexEdge{i},:);
    [~, area] = convhull(P(:,1),P(:,2));
    if area < pi*R^2
       counter = counter+1; 
    end
end
c = counter/N;
end