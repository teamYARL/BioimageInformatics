function [ detectionMean, detectionSD ] = part33(masksize, imagePath )
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
I = imread(imagePath);
syntheticImg = generatesyntheticimg(I, masksize, imagePath);
[syntheticImgCoord_X, syntheticImgCoord_Y] = accuracyofsubpixel(syntheticImg);


end
