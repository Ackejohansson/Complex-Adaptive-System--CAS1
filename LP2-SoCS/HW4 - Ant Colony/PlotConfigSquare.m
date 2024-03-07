function PlotConfigSquare(nodes,N,shortestPath,startNode,endNode)
clf
plot(nodes(:,1),nodes(:,2),'.','MarkerSize',14,'Color','k'); hold on
plot(nodes(startNode,1),nodes(startNode,2),'o',"MarkerEdgeColor",'g','MarkerSize',14)
plot(nodes(endNode,1), nodes(endNode,2),'o',"MarkerEdgeColor",'r','MarkerSize',14)
xlim([0 sqrt(N)+1])
ylim([0 sqrt(N)+1])


for j=0:sqrt(N)-1
    for i=1:sqrt(N)
        index = j*sqrt(N) + i;
        iNodeUp = (j+1)*sqrt(N) + i;
        iNodeRight = index + 1;
         if i ~= sqrt(N)
             plot([nodes(index,1) nodes(iNodeRight,1)],[nodes(index,2) nodes(iNodeRight,2)],'Color','k')
         end
         if j ~= sqrt(N)-1
         plot([nodes(index,1) nodes(iNodeUp,1)],[nodes(index,2) nodes(iNodeUp,2)],'Color','k')
         end
    end
end
if ~isempty(shortestPath)
    P=shortestPath;
    for j=1:length(P)-1
        plot([nodes(P(j),1) nodes(P(j+1),1)],[nodes(P(j),2) nodes(P(j+1),2)],"Color", [0,0,0],'LineWidth',4)
    end
    drawnow
end
end
% clf
% figure(1)
% hold on
% DT = delaunayTriangulation(nodes);
% triplot(DT,'.-','MarkerSize',14,'Color',[0,0,0,0.5])%triplot(DT)
% plot(nodes(startNode,1),nodes(startNode,2),'o',"MarkerEdgeColor",'g','MarkerSize',14)
% plot(nodes(endNode,1), nodes(endNode,2),'o',"MarkerEdgeColor",'r','MarkerSize',14)
% 
% 
% end