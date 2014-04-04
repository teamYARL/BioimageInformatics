% Project Assignment #3
%===============================================================================
% C.1 : Implementation of the Steger's algorithm
%===============================================================================
close all%, clc

%===============================================================================
% Settings
width = 14;        % find out why this in particular: width = ceil(3 * sigma
sigma = 4.62;      % sigma >= width / sqrt(3) ~= 4.61880 if w=8

% for smoothing
%k = 100;
%l = 0.25;
%===============================================================================

% User's image location settings
inputDir1 = 'curve_detection_images';
filename = 'curv_det_01.tif';

imagePath = [inputDir1, filesep, filename];     % Cross-platform format
I = imread(imagePath);
figure('Name','Original Image'), imshow(I, [])

curveDetectImage = I;
%curveDetectImage = b5_directionalanisotropicfilter(curveDetectImage, k, l);
% ordering of imshow() changed to compensate for xstarmatrix() plotting behavior
figure('Name','C.1 : Curve Detection'), imshow(curveDetectImage, [])
curveDetectImage = xstarmatrix_general(curveDetectImage, width, sigma);
disp('Finished')
