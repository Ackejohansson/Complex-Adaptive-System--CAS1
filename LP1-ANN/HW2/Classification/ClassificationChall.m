%% Classification problem, train net
clc

% Load data
testSet = LoadMNIST2(); 
[xTrain, tTrain, xValid, tValid, xTest, tTest] = LoadMNIST(3);

% Train net. Model/net provided from Mathworks
figure;
perm = randperm(10000,20);  
for i = 1:20
    subplot(4,5,i);
    imshow(testSet(:,:,:,perm(i)));
end

layers = [
    imageInputLayer([28 28 1])
    
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',30, ...
    'Shuffle','every-epoch', ...
    'ValidationData',{xValid, tValid}, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress', ...
    'ValidationPatience', 5);

net = trainNetwork(xTrain,tTrain,layers,options);
%% Run tests on trained net
% Val accuracy
YPred = classify(net,xValid);
YValidation = tValid;
Validaccuracy = sum(YPred == YValidation)/numel(YValidation);

% Test accuracy
YPred = classify(net,xTest);
YTest = tTest;
Testaccuracy = sum(YPred == YTest)/numel(YTest)


% FINAL TEST 
yPredFinal = double(string( classify(net,LoadMNIST2) ))
csvwrite('classifications.csv',yPredFinal);

