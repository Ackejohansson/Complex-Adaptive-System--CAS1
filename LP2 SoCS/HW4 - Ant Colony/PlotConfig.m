function PlotConfig(nodes,shortestPath,startNode,endNode)
clf
hold on
DT = delaunayTriangulation(nodes);
triplot(DT)
plot(nodes(startNode,1),nodes(startNode,2),'o',"MarkerEdgeColor",'g','MarkerSize',14)
plot(nodes(endNode,1), nodes(endNode,2),'o',"MarkerEdgeColor",'r','MarkerSize',14)

if ~isempty(shortestPath)
    P=shortestPath;
    for j=1:length(P)-1
        plot([nodes(P(j),1) nodes(P(j+1),1)],[nodes(P(j),2) nodes(P(j+1),2)],"Color", [1,0,0])
    end
    drawnow
    hold off
end
end