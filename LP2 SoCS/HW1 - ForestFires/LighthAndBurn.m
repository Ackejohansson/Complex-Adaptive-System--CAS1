function [fireSizes, forestSizes, forest] = LighthAndBurn(f,forest,fireSizes,forestSizes,N)
    if rand<f
       index=[randi(N),randi(N)];
       m = index(1);
       n = index(2);

       if forest(m,n)==1
            forestSizes(end+1) = sum(sum(forest));
            forest(m,n)=-1;
            counter = 0;
            [forest, counter] = CheckNeighboursList(forest,index,N,counter);
            fireSizes(end+1) = counter;
       end
   end
end