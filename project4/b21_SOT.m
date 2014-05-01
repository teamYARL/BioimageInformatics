% Clean up MATLAB environment before starting
clc, close all


%===============================================================================
% Settings
%===============================================================================
numOfHistograms = 2;


%===============================================================================
% SOT (OtsuThresholdSegmentation)
%===============================================================================
% load image and get the size of this image
%filename = 'Blue0001.tif';
filename = 'image01.tiff';
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

% implement segmentation using Otsu's method
%b = matitk('SOT',[max(D(:))], double(D));
b = matitk('SOT',[numOfHistograms], double(D));
figure('Name','SOT segmented image'); imagesc(squeeze(b(:,:,1))); colormap gray; axis off; axis equal;
