function fireSizes = SimulateForestFire(N,p,f,T)

fireSizes=[];
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
   
   if rand<f
       index=[randi(N),randi(N)];
       m = index(1);
       n = index(2);
       if forest(m,n)==1
            forest(m,n)=-1;
            counter = 0;
            [forest, counter] = CheckNeighbours(forest,index,N,counter);
            fireSizes(end+1) = counter;
       end
   end
   %drawnow;
   forest(forest == -1)=0;
end

end