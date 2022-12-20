function [forest, counter]=CheckNeighboursList(forest,index,N,counter)
i = 1;
counter = counter + 1;
nList = zeros(N^2,2);
nList(i,:) = [index(1),index(2)];


while sum(sum(nList)) ~=0
m = nList(1,1);
n = nList(1,2);

if m-1>0 && forest(m-1,n)==1
    i=i+1;
    nList(i,:) = [m-1,n];
    forest(m-1,n)=-1;
    counter = counter + 1;
end

if m+1<=N && forest(m+1,n)==1
    i=i+1;
    nList(i,:) = [m+1,n];
    forest(m+1,n)=-1;
    counter = counter + 1;
end

if n-1>0 && forest(m,n-1)==1
    i=i+1;
    nList(i,:) = [m,n-1];
    forest(m,n-1)=-1;
    counter = counter + 1;
end

if n+1<=N && forest(m,n+1)==1
    i=i+1;
    nList(i,:) = [m,n+1];
    forest(m,n+1)=-1;
    counter = counter + 1;
end

%
% Periodic timetables
%

if m-1<=0 && forest(N,n)==1
    i=i+1;
    nList(i,:) = [N,n];
    counter = counter + 1;
    forest(N,n)=-1;
end

if m+1>N && forest(1,n)==1
    i=i+1;
    nList(i,:) = [1,n];
    counter = counter + 1;
    forest(1,n)=-1;
end

if n-1<=0 && forest(m,N)==1
    i=i+1;
    nList(i,:) = [m,N];
    counter = counter + 1;
    forest(m,N)=-1;
end

if n+1>N && forest(m,1)==1
    i=i+1;
    nList(i,:) = [m,1];
    counter = counter + 1;
    forest(m,1)=-1;
end

i=i-1;
nList = nList(2:end,:);
end
end