% Clean up MATLAB environment before starting
clc, close all


%===============================================================================
% Settings
%===============================================================================
propagationScaling = 2;
curvatureScaling = 1;
setMaximumRMSError = 5;
setNumberOfIterations = 2;

%propagationScaling = 1.4;
%curvatureScaling = 1;
%setMaximumRMSError = 2;
%setNumberOfIterations = 20;

settings = [propagationScaling curvatureScaling setMaximumRMSError setNumberOfIterations];

filename = '60x_02.tif';
%filename = 'Blue0001.tif';


%===============================================================================
% SSDLS (ShapeDetectionLevelSetFilter)
%===============================================================================
% load image and get the size of this image
Img = double(imread(filename));
imgSize = size(Img);

% show original image
figure('Name','Original image'); imagesc(Img); colormap gray; axis off; axis equal;

% in order to use matitk, we have to use 3D data
% so we first build a 3D volume of two layers, and each layer
% contains the original image
D = zeros(imgSize(1),imgSize(2),2);
D(1:imgSize(1),1:imgSize(2),1) = Img(1:imgSize(1),1:imgSize(2));
D(1:imgSize(1),1:imgSize(2),2) = Img(1:imgSize(1),1:imgSize(2));

% for SSDLS, it requires a gradient of the image
gD = gradient(D);

% implement segmentation using SSDLS
segmentedImage = matitk('SSDLS', [1.4 1 2 20], uint8(D), uint8(gD), []);
figure('Name','SSDLS segmented image')
imagesc(squeeze(segmentedImage(:,:,1)))
colormap gray; axis off; axis equal;
