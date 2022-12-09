%% Self organising map
clc, clf, clear
% Initialize
iris = csvread('iris-data.csv');
iris = iris / max(iris,[],'all');
iris_labels = csvread('iris-labels.csv');

w = rand([40,40,4]);
wUntrained = w;
nInputs = size(iris,1);
nEpochs = 100;
nNeurons = 40;

eta0 = 0.1;
dEta = 0.01;
sigma0 = 10;
dSigma = 0.05;

% Training
for epoch = 1:nEpochs 
    sigma = sigma0*exp(-dSigma*epoch);
    eta   = eta0*exp(-dEta*epoch);
    for inputs = 1:nInputs
        x = iris(randi(nInputs),:);
        w = TrainMap(w, x, sigma, nNeurons, eta);
    end
end


% Get position with untrained and trained weights
unTrainedPposition = zeros(nInputs,2);
position = zeros(nInputs,2);
for k = 1:nInputs
    unTrainedPposition(k,:) = GetWinningNeuron(wUntrained, iris(k,:));
    position(k,:) = GetWinningNeuron(w, iris(k,:));
end

% Plot with untrained- and trained-weights
hold on
figure(1);
gscatter(unTrainedPposition(:,1),unTrainedPposition(:,2), iris_labels)
legend('Setosa','Versicolour','Virginica','location','northeast')
title('Scatter graph for untrained weights')

figure(2);
gscatter(position(:,1),position(:,2),iris_labels)
legend('Setosa','Versicolour','Virginica','location','northeast')
title('Scatter graph for trained weights')
hold off