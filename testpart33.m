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
% Nearest-neighbor to get distance difference between originalImg vs. syntheticImg
%===============================================================================
% check tutorial on how to do:
%   http://www.mathworks.com/help/stats/knnsearch.html
%   TO DO: figure out how to use n and d, or need to use another algo instead
[n,d]=knnsearch(originalImgCoord, syntheticImgCoord, 'k',10, 'distance','minkowski', 'p',5);
