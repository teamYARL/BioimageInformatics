% Clean up MATLAB environment before starting
clc, close all


%===============================================================================
% Settings
%===============================================================================
max_numOfHistograms = 20;

%filename = '60x_02.tif';
filename = 'Blue0001.tif';

% Name for saving
%name_out = '60x_02';
name_out = 'Blue0001';


%===============================================================================
% SOT (OtsuThresholdSegmentation)
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

% implement segmentation using Otsu's method
%segmentedImage = matitk('SOT', [max(D(:))], double(D));
for numOfHistograms = 1:max_numOfHistograms
    segmentedImage = matitk('SOT', [numOfHistograms], double(D));
    %figure('Name','SOT segmented image')
    h = imagesc(squeeze(segmentedImage(:,:,1))); colormap gray; axis off; axis equal;
    saveas(h, ['results_partB_SOT', filesep, name_out, '_SOT_', int2str(numOfHistograms)], 'png')
end
