function [forest, counter]=CheckNeighbours(forest,index,N,counter)
i = index(1);
j = index(2);
counter = counter+1;
% hold on
% fill([0 1 1 0]+i-1, [0 0 1 1]+j-1, 'r')
% hold off
% drawnow;

if i-1>0 && forest(i-1,j)==1
    forest(i-1,j)=-1;
    [forest, counter]=CheckNeighbours(forest, [i-1,j],N,counter);
end

if i+1<=N && forest(i+1,j)==1
    forest(i+1,j)=-1;
    [forest, counter]=CheckNeighbours(forest, [i+1,j],N,counter);
end

if j-1>0 && forest(i,j-1)==1
    forest(i,j-1)=-1;
    [forest, counter]=CheckNeighbours(forest, [i,j-1],N,counter);
end

if j+1<=N && forest(i,j+1)==1
    forest(i,j+1)=-1;
    [forest, counter]=CheckNeighbours(forest, [i,j+1],N,counter);
end

% Periodic timetables
if i-1<=0 && forest(N,j)==1
    forest(N,j)=-1;
    [forest, counter]=CheckNeighbours(forest, [N,j],N,counter);
end

if i+1>=N && forest(1,j)==1
    forest(1,j)=-1;
    [forest, counter]=CheckNeighbours(forest, [1,j],N,counter);
end

if j-1<=0 && forest(i,N)==1
    forest(i,N)=-1;
    [forest, counter]=CheckNeighbours(forest, [i,N],N,counter);
end

if j+1>N && forest(i,1)==1
    forest(i,1)=-1;
    [forest, counter]=CheckNeighbours(forest, [i,1],N,counter);
end
% hold on
% fill([0 1 1 0]+i-1, [0 0 1 1]+j-1,'w','Edgecolor', 'black')
% drawnow;
% hold off
end