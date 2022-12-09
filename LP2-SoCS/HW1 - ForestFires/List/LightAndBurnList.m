function [fireSizes, forestSizes, forest, fire] = LightAndBurnList(f,forest,fireSizes,forestSizes,N)
     fire = false;
    if rand<f
       index=[randi(N),randi(N)];
       m = index(1);
       n = index(2);

       if forest(m,n)==1
%            fill([0 1 1 0]+m-1, [0 0 1 1]+n-1, 'y')
%            drawnow;
%            pause(0.2)
            fire = true;
            forestSizes(end+1) = sum(sum(forest));
            forest(m,n)=-1;            
            counter = 0;
            [forest, counter]=CheckNeighboursList(forest,index,N,counter);
            fireSizes(end+1) = counter;
       end
   end
end