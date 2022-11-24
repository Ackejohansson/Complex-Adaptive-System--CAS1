function DrawPlot(agents,L)
I = agents(:,3) == -1;
S = agents(:,3) == 0;
R = agents(:,3) == 1;
clf
plot(agents(I,1),agents(I,2),'r.')
hold on
plot(agents(S,1),agents(S,2),'b.')
plot(agents(R,1),agents(R,2),'g.')
axis([0 L 0 L])
drawnow;
end