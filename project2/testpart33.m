% use Accuracy = mean( distanceDifference:LIST )
% use Precision = SD( distanceDiffence:LIST )
%===============================================================================
% Ignore this:
% Accuracy
%   = (TruePositive + TrueNegative) / (Postives + Negatives)
%
% Precision
%   = (TruePositive) / (TruePositive + FalsePositive)
%===============================================================================
% 1. Get (centerX, centerY) for original image
% 2. Get (centerX, centerY) for synthetic image
% 3. (Calculate difference and count?)
% 4. Calculate mean and SD for both
%===============================================================================
clear all, close all, clc

%imagePath = '2\images\001_a5_002_t001.tif';    % Path format in Windows
imagePath = '2/images/001_a5_002_t001.tif';     % Path format in OSX/Linux
masksize = 5;

I = imread(imagePath);
I = double(I);



%===============================================================================
% Get X, Y coordinates for original and synthetic images
%===============================================================================
[originalImgCoord_X, originalImgCoord_Y] = accuracyofsubpixel(I);

syntheticImg = generatesyntheticimg(I, masksize, imagePath);
[syntheticImgCoord_X, syntheticImgCoord_Y] = accuracyofsubpixel(syntheticImg);



%===============================================================================
% count
%===============================================================================
size_original = size(originalImgCoord_X);
size_synthetic = size(syntheticImgCoord_X);
count_original = size_original(2);
count_synthetic = size_synthetic(2);

countDifference =  count_original - count_synthetic;



%===============================================================================
% Turn X,Y vectors to coordinate system; (X, Y)
%===============================================================================
originalImgCoord = [];
for i=1:count_original
    originalImgCoord = [originalImgCoord ; [originalImgCoord_X(i), originalImgCoord_Y(i)] ];
end

syntheticImgCoord = [];
for i=1:count_synthetic
    syntheticImgCoord = [syntheticImgCoord ; [syntheticImgCoord_X(i), syntheticImgCoord_Y(i)] ];
end



%===============================================================================
% Calculate mean and SD
%===============================================================================
originalMean = mean(originalImgCoord);
originalSD = std(originalImgCoord);
syntheticMean = mean(syntheticImgCoord);
syntheticSD = std(syntheticImgCoord);

fprintf('Original image mean coordinates are:\n (%f, %f)\n', originalMean(1), originalMean(2) )
fprintf('The standard deviation of the coordinates are:\n (%f, %f)\n', originalSD(1), originalSD(2) )

fprintf('Synthetic image mean coordinates are:\n (%f, %f)\n', syntheticMean(1), syntheticMean(2) )
fprintf('The standard deviation of the coordinates are:\n (%f, %f)\n', syntheticSD(1), syntheticSD(2) )

% Calculate accuracy and precision
accuracy = (originalMean - syntheticMean) ./ syntheticMean * 100;    % in percentage
precision = (originalSD - syntheticSD) ./ syntheticSD * 100;         % in percentage
fprintf('\n')
fprintf('The accuracy of the original image from ground truth is:\n (%f%%, %f%%)\n', accuracy(1), accuracy(2) ) 
fprintf('The precision of the original image from ground truth is:\n (%f%%, %f%%)\n', precision(1), precision(2) ) 



%===============================================================================
% Ignore: Following is not needed
% Nearest-neighbor to get distance difference between originalImg vs. syntheticImg
%   1. for each center in originalImg (has less centers), find nearest center in syntheticImg (has more centers) (output: list)
%   2. calculate the distance (input: list; output: list)
%   3. calculate mean and SD of the distances (input: list; output: [mean, SD]
%===============================================================================
% check tutorial on how to do:
%   http://www.mathworks.com/help/stats/knnsearch.html
%   TO DO: figure out how to use n and d, or need to use another algo instead
%[n,d]=knnsearch(originalImgCoord, syntheticImgCoord, 'k',10, 'distance','minkowski', 'p',5);
