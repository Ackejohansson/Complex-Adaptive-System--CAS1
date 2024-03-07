function PlotConfig(nodes,shortestPath,startNode,endNode)
clf
figure(1)
hold on
DT = delaunayTriangulation(nodes);
triplot(DT,'.-','MarkerSize',14,'Color',[0,0,0,0.5])
plot(nodes(startNode,1),nodes(startNode,2),'o',"MarkerEdgeColor",'g','MarkerSize',14)
plot(nodes(endNode,1), nodes(endNode,2),'o',"MarkerEdgeColor",'r','MarkerSize',14)

if ~isempty(shortestPath)
    P=shortestPath;
    for j=1:length(P)-1
        plot([nodes(P(j),1) nodes(P(j+1),1)],[nodes(P(j),2) nodes(P(j+1),2)],"Color", [0,0,0],'LineWidth',4)
    end
    drawnow
    hold off
end
end