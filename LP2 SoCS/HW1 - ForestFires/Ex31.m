%% Exercise 3.1
clf, clc
N=16;
p=0.01;
f=0.2;
T = 1e5;
figure(1)
plot([0:N; 0:N], [0:N; 0:N])
grid

hax=gca;
hax.XTick=0:1:N;
hax.YTick=0:1:N;
hax.GridAlpha = 1;
axis square

fireSizes = [];
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
   drawnow;
   forest(forest == -1)=0;
end

%%
clf, clc
fireSizes = FireSizes;
histogram(fireSizes)
ylabel('Number of fires')
xlabel('Size of fires')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%     %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [forest, counter]=CheckNeighbours(forest,index,N,counter)
i = index(1);
j = index(2);
counter = counter+1;
hold on
fill([0 1 1 0]+i-1, [0 0 1 1]+j-1, 'r')
hold off
drawnow;

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
hold on
fill([0 1 1 0]+i-1, [0 0 1 1]+j-1,'w','Edgecolor', 'black')
drawnow;
hold off
end