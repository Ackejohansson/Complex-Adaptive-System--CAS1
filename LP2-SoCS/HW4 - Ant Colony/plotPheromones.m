function plotPheromones(nodes,pheromones,startNode,endNode)
clf
hold on
DT = delaunayTriangulation(nodes);
triplot(DT,'.-','MarkerSize',14,'Color',[0,0,0,0.5])
plot(nodes(startNode,1),nodes(startNode,2),'o',"MarkerEdgeColor",'g','MarkerSize',14)
plot(nodes(endNode,1), nodes(endNode,2),'o',"MarkerEdgeColor",'r','MarkerSize',14)

for i=1:size(pheromones,1)
    for j=i:size(pheromones,2)
        if pheromones(i,j)>0
            plot([nodes(i,1) nodes(j,1)],[nodes(i,2) nodes(j,2)],"Color", [1,0,0],'LineWidth',5*pheromones(i,j))
        end
    end
end
drawnow;
end