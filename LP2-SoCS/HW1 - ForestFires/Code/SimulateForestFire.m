function [fireSizes, forestSizes] = SimulateForestFire(N,p,f,T)
fireSizes=[];
forestSizes=[];
forest = zeros(N,N);
for t=0:T
   for i=1:N
       for j=1:N
          if rand<p
              forest(i,j)=1;
              %hold on
              %fill([0 1 1 0]+i-1, [0 0 1 1]+j-1, 'g')
              %hold off
          end
       end
   end
   
[fireSizes, forestSizes, forest] = LighthAndBurn(f,forest,fireSizes,forestSizes,N);
   %drawnow;
   forest(forest == -1)=0;
end
end