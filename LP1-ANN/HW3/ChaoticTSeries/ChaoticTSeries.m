%% Chaotic time series prediction
clc, clf
% Initialize
N = 3;
neurons = 500;
wIN = normrnd(0,sqrt(0.002),[neurons, N]);
w = normrnd(0,sqrt(0.004),[neurons, neurons]);
k = 0.01; 

wOUT = TrainReservoirComputer(wIN, w, neurons,k, csvread('training-set.csv'));

T = 500;
xP = csvread('test-set-9.csv');
O = PredictContinuation(wIN, w, wOUT, T, N, neurons, xP);
csvwrite('prediction.csv',O(2,:))

plot3(xP(1,:), xP(2,:), xP(3,:))
hold on
plot3(O(1,:), O(2,:), O(3,:))
hold off