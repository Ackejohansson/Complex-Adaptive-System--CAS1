function [forest, counter]=CheckNeighbourswList(forest,index,N,counter)
i = 1;
counter = counter + 1;
nList = zeros(N^2,2);
nList(i,:) = [index(1),index(2)];

% hold on
% fill([0 1 1 0]+i-1, [0 0 1 1]+j-1, 'r')
% hold off
% drawnow;


while sum(sum(nList)) ~=0
m = nList(1,1);
n = nList(1,2);

if m-1>0 && forest(m-1,n)==1
    i=i+1;
    nList(i,:) = [m-1,n];
    forest(m-1,n)=-1;
end

if m+1<=N && forest(m+1,n)==1
    i=i+1;
    nList(i,:) = [m+1,n];
    forest(m+1,n)=-1;
end

if n-1>0 && forest(m,n-1)==1
    i=i+1;
    nList(i,:) = [m,n-1];
    forest(m,n-1)=-1;
end

if n+1<=N && forest(m,n+1)==1
    i=i+1;
    nList(i,:) = [m,n+1];
    forest(m,n+1)=-1;
end

% hold on
% fill([0 1 1 0]+i-1, [0 0 1 1]+j-1,'w','Edgecolor', 'black')
% drawnow;
% hold off

i=i-1;
nList = nList(2:end,:);
end
end