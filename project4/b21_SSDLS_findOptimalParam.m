% Clean up MATLAB environment before starting
clc, close all


%===============================================================================
% Settings
%   Adjust position of variable `max_numOfx` on line 45, setting inside the loop
%===============================================================================
parameter_name = 'propagationScaling';
max_numOfx = 10;

propagationScaling = 1.4;
curvatureScaling = 1;
setMaximumRMSError = 2;
setNumberOfIterations = 20;

filename = '60x_02.tif';
%filename = 'Blue0001.tif';

% Name for saving
name_out = '60x_02';
%name_out = 'Blue0001';


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
for numOfx = 1:max_numOfx
    settings = [max_numOfx curvatureScaling setMaximumRMSError setNumberOfIterations];
    %settings = [propagationScaling curvatureScaling setMaximumRMSError setNumberOfIterations];
    segmentedImage = matitk('SSDLS', settings, uint8(D), uint8(gD), []);
    %figure('Name','SSDLS segmented image')
    h = imagesc(squeeze(segmentedImage(:,:,1))); colormap gray; axis off; axis equal;
    saveas(h, ['results_partB_SSDLS', filesep, name_out, '_SSDLS_', parameter_name, int2str(numOfx)], 'png')
end
