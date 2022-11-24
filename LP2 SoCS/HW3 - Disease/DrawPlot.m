function DrawPlot(agents,L,I,S,R)
clf
plot(agents(I(:,end),1),agents(I(:,end),2),'r.')
hold on
plot(agents(S(:,end),1),agents(S(:,end),2),'b.')
plot(agents(R(:,end),1),agents(R(:,end),2),'g.')
axis([0 L 0 L])
drawnow;
end