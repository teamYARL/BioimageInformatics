% Project Assignment #3
%===============================================================================
% C.1 : Implementation of the Steger's algorithm
%===============================================================================
close all%, clc

% for smoothing
%k = 100;
%l = 0.25;
%===============================================================================

% User's image location settings
inputDir1 = 'curve_detection_images';
filename = 'curv_det_01.tif';

imagePath = [inputDir1, filesep, filename];     % Cross-platform format
img = imread(imagePath);


%===============================================================================
% Settings
sigma = ApplyStegersAlgor(img);   % calculate sigma by obtaining line width
width = ceil(3*sigma);   % get the range for convolve


curveDetectImage = I;

%curveDetectImage = b5_directionalanisotropicfilter(curveDetectImage, k, l);
% ordering of imshow() changed to compensate for xstarmatrix() plotting behavior
figure('Name','C.1 : Curve Detection'), imshow(curveDetectImage, [])
curveDetectImage = xstarmatrix_general(curveDetectImage, width, sigma);
disp('Finished')
