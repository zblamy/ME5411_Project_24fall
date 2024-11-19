%% course ME5411 Q8-2
clc;
clear;
close all;
%% parameters setting
trainDir = './dataset/train';
testDir = './dataset/test';
HOGsize = [8, 8];  % HOG feature cell size
SVMkernel = 'linear';  % SVM kernel

%% input dataset
trainData = imageDatastore(trainDir, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
testData = imageDatastore(testDir, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

%% calculate sizes
numTrain = numel(trainData.Files);
numTest = numel(testData.Files);
% use sample to know feature dimension
img_sample = readimage(trainData, 1);
feature_sample = extractHOGFeatures(img_sample, 'CellSize', HOGsize);
num_feature = length(feature_sample);

%% extract HOG features of training set
trainFeature = zeros(numTrain, num_feature);
trainLabel = zeros(numTrain, 1);

disp('Start extracting HOG features from training data...');

for i = 1:numTrain
    img = readimage(trainData, i);
    trainFeature(i, :) = extractHOGFeatures(img, 'CellSize', HOGsize); % extract features
    trainLabel(i) = trainData.Labels(i);
end

%% train SVM
disp('Start training the SVM model...');
SVMModel = fitcecoc(trainFeature, trainLabel, 'Learners', templateSVM('KernelFunction', SVMkernel), 'Coding', 'onevsall');

%% extract HOG features of testing set
testFeature = zeros(numTest, num_feature);
testLabel = zeros(numTest, 1);

disp('Start extracting HOG features from test data...');

for i = 1:numel(testData.Files)
    img = readimage(testData, i);
    testFeature(i, :) = extractHOGFeatures(img, 'CellSize', HOGsize);
    testLabel(i) = testData.Labels(i);
end

%% valuation
disp('Evaluating the model...');
Predict = predict(SVMModel, testFeature);

% calculate accuracy
accuracy = sum(Predict == testLabel) / numel(testLabel);
fprintf('SVM Accuracy on test data is: %.2f%%\n', accuracy * 100);
%% save the model
save('SVM_test.mat', 'SVMModel', 'trainFeature', 'trainLabel');
labelmap = unique(trainData.Labels); % save label map
save('labelmap_test.mat', 'labelmap');