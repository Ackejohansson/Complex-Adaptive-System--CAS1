function DrawPlot(agents,L)    
clf
gscatter(agents(:,1),agents(:,2), agents(:,3),['r'; 'b'; 'g'])
legend(gca,'off');
axis([0 L 0 L])
drawnow;
end