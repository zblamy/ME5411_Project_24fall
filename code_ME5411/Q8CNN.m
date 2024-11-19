%% course ME5411 Q8-1
clc
clear
close all;
%% test input image
% img = imread('sample.png');
% input images are 128*128 uint8
%% input dataset
trainDir = './dataset/train';
testDir = './dataset/test';
trainData = imageDatastore(trainDir, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
testData = imageDatastore(testDir, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
%% test
numTrain = numel(trainData.Files);
trainLabel = zeros(numTrain, 1);
for i = 1:numel(trainData.Files)
    img = readimage(trainData, i);
    trainLabel(i) = trainData.Labels(i);
end
%% Define CNN network
layers = [
imageInputLayer([128 128 1]) % set the input size

convolution2dLayer(3, 16, 'Padding', 'same') % 3*3 kernel
batchNormalizationLayer
reluLayer

maxPooling2dLayer(2, 'Stride', 2)

convolution2dLayer(3, 32, 'Padding', 'same') % 3*3 kernel
batchNormalizationLayer
reluLayer

maxPooling2dLayer(2, 'Stride', 2)

convolution2dLayer(3, 64, 'Padding', 'same') % 3*3 kernel
batchNormalizationLayer
reluLayer

maxPooling2dLayer(2, 'Stride', 2)

convolution2dLayer(3, 128, 'Padding', 'same') % 3*3 kernel
batchNormalizationLayer
reluLayer

maxPooling2dLayer(2, 'Stride', 2)

convolution2dLayer(3, 128, 'Padding', 'same') % 3*3 kernel
batchNormalizationLayer
reluLayer

maxPooling2dLayer(2, 'Stride', 2)

convolution2dLayer(3, 128, 'Padding', 'same') % 3*3 kernel
batchNormalizationLayer
reluLayer

maxPooling2dLayer(2, 'Stride', 2)


convolution2dLayer(3, 128, 'Padding', 'same') % 3*3 kernel
batchNormalizationLayer
reluLayer

maxPooling2dLayer(2, 'Stride', 2)

convolution2dLayer(3, 256, 'Padding', 'same') % 3*3 kernel
batchNormalizationLayer
reluLayer

fullyConnectedLayer(numel(unique(trainData.Labels)))
softmaxLayer
classificationLayer];
%% Set training options
options = trainingOptions('adam', ...
    'ExecutionEnvironment','gpu', ...
    'MiniBatchSize', 256, ...
    'MaxEpochs', 10, ...
    'InitialLearnRate', 5e-3, ...
    'Shuffle', 'every-epoch', ...
    'ValidationData', testData, ...
    'ValidationFrequency', 10, ...
    'ValidationPatience', 5, ... % when loss doesn't decrease for 5 epoches, stop training     
    'Verbose', false, ...
    'Plots', 'training-progress');
%% Train CNN
disp("Start training...");
net = trainNetwork(trainData, layers, options);

%% Evaluate on test data
disp("Start testing data...");
predict = classify(net, testData);
testLabel = testData.Labels;
accuracy = sum(predict == testLabel) / numel(testLabel);
fprintf('CNN accuracy on test data is: %.2f%%\n', accuracy * 100);

%% save the net
save('CNN_test.mat', 'net', 'trainData', 'options');