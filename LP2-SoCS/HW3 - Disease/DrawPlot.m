function DrawPlot(agents,L,S,I,R)    
clf
plot(agents(I,1),agents(I,2),'r.','MarkerSize',10)
hold on
plot(agents(S,1),agents(S,2),'b.','MarkerSize',10)
plot(agents(R,1),agents(R,2),'g.','MarkerSize',10)
axis([0 L 0 L])
drawnow;
end