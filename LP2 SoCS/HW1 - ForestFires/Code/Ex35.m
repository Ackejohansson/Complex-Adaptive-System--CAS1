%% 35
clf, clc, clear

% Settings
N=128;
T = 1e5;
p=0.01;
f=0.2;

% Forest with fires
[fireSizes, forestSizes] = SimulateForestFire(N,p,f,T);

% Forest with randomly placed trees
randomFireSizes=[];
for i = 1:length(forestSizes)
    randomForest=zeros(N,N);
    while sum(sum(randomForest)) < forestSizes(i)
        randomForest(randi(N), randi(N)) = 1;
    end

    noFire = true;
    while noFire
           index=[randi(N),randi(N)];
           m = index(1);
           n = index(2);
           if randomForest(m,n)==1
                randomForest(m,n)=-1;
                counter = 0;
                [randomForest, counter] = CheckNeighbours(randomForest,index,N,counter);
                randomFireSizes(end+1) = counter;
                noFire=false;
           end
    end
end
n = (1:size(fireSizes,2))/size(fireSizes,2);
sortedRandomFireSizes = sort(randomFireSizes, 'descend');
sortedFireSizes = sort(fireSizes, 'descend');   
%% Make plot
clf

loglog(sortedFireSizes/N^2,n,'b')
hold on
loglog(sortedRandomFireSizes/N^2,n,'r')
xlabel("n/N^2")
ylabel("C(n)")
legend("Forest grown with fires","Forest grown randomly")
hold off