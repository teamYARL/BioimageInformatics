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

% Get X, Y for original image
[originalImgCoord_X, originalImgCoord_Y] = accuracyofsubpixel(I);

% Get X, Y for synthetic image
syntheticImg = generatesyntheticimg(I, masksize, imagePath);
[syntheticImgCoord_X, syntheticImgCoord_Y] = accuracyofsubpixel(syntheticImg);

size_original = size(originalImgCoord_X);
size_synthetic = size(syntheticImgCoord_X);
count_original = size_original(2);
count_synthetic = size_synthetic(2);

countDifference =  count_original - count_synthetic;
