%% 35

clf, clc
N=10;
p=0.01;
f=0.2;
T = 5000;
alpha = 1.18;
[fireSizes, forestSizes] = SimulateForestFire(N,p,f,T);

% generate forestSizes random trees and burn down random node. Record size.
randomForest=zeros(N,N)
for i = 1:length(forestSizes)
    while sum(sum(randomForest)) < forestSizes[i]
        randomForest(randi(N), randi(N)) = 1;
    end
end

f=1;
[fireSizesRandom, forestSizes, randomForest] = LighthAndBurn(f,randomForest,fireSizes,forestSizes,N)

sortedRandomFireSizes = sort(fireSizesRandom, 'descend');
n = (1:size(fireSizes,2))/size(fireSizes,2);
loglog(n,sortedRandomFireSizes/N^2)
