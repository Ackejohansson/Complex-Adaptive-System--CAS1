function [nodes,connections,distance, weights,pheromones]=InitializePopulationSquare(N,startNode,endNode)
figure(1)
[row,col]=ind2sub([sqrt(N) sqrt(N)],1:N);
nodes=[row' col']+(2*rand(N,2)-1)/5;
plot(nodes(:,1),nodes(:,2),'.','MarkerSize',14,'Color','k'); hold on

connections=zeros(N);
distance=inf(N);

for j=0:sqrt(N)-1
    for i=1:sqrt(N)
        index = j*sqrt(N) + i;
        iNodeUp = (j+1)*sqrt(N) + i;
        iNodeRight = index + 1;
        if i ~= sqrt(N)
            connections(index,iNodeRight) = 1;
            connections(iNodeRight, index) = 1;
            plot([nodes(index,1) nodes(iNodeRight,1)],[nodes(index,2) nodes(iNodeRight,2)],'Color','k')
            
            dist=sqrt((nodes(index,1)-nodes(iNodeRight,1)).^2+(nodes(index,2)-nodes(iNodeRight,2)).^2);
            distance(index,iNodeRight) = dist;
            distance(iNodeRight, index) = dist;
        end
        
        if j ~= sqrt(N)-1
            connections(index,iNodeUp) = 1;
            connections(iNodeUp, index) = 1;
            plot([nodes(index,1) nodes(iNodeUp,1)],[nodes(index,2) nodes(iNodeUp,2)],'Color','k')
            dist=sqrt((nodes(index,1)-nodes(iNodeRight,1)).^2+(nodes(index,2)-nodes(iNodeRight,2)).^2);
            distance(index,iNodeUp) = dist;
            distance(iNodeUp, index) = dist;
        end
    end    
end
plot(nodes(startNode,1),nodes(startNode,2),'o',"MarkerEdgeColor",'g','MarkerSize',14)
plot(nodes(endNode,1), nodes(endNode,2),'o',"MarkerEdgeColor",'r','MarkerSize',14)

weights=1./distance;
pheromones=connections;
end