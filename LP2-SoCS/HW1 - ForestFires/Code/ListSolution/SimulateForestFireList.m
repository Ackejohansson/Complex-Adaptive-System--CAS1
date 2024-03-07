function [fireSizes, forestSizes] = SimulateForestFireList(N,p,f,T)
fireSizes=[];
forestSizes=[];
forest = zeros(N,N);
for t=0:T
   for i=1:N
       for j=1:N
          if rand<p
              forest(i,j)=1;
               hold on
               fill([0 1 1 0]+i-1, [0 0 1 1]+j-1, 'g')
              hold off
          end
       end
   end
% pause(0.2)
[fireSizes, forestSizes, forest, fire] = LightAndBurnList(f,forest,fireSizes,forestSizes,N);
forest(forest == -1)=0;

%For drawing 
if fire
    [a,b] = find(forest == -1);
    hold on
    for k = 1:length(a)
        fill([0 1 1 0] + a(k)-1, [0 0 1 1] + b(k)-1, 'r')
    end
    drawnow;
    pause(0.5) 
    for k = 1:length(a)
        forest(a(k),b(k))=0;
        fill([0 1 1 0]+a(k)-1, [0 0 1 1]+b(k)-1, 'w')
    end
    drawnow;
    pause(0.3) 
end
end
end