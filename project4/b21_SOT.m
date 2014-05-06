% Clean up MATLAB environment before starting
clc, close all


%===============================================================================
% Settings
%===============================================================================
<<<<<<< Updated upstream

%numOfHistograms = 2;
=======
numOfHistograms = 3;

filename = '60x_02.tif';
%filename = 'Blue0001.tif';
>>>>>>> Stashed changes


%===============================================================================
% SOT (OtsuThresholdSegmentation)
%===============================================================================
% load image and get the size of this image
<<<<<<< Updated upstream
%filename = 'Blue0001.tif';
%filename = 'image01.tiff';
filename = '60x_02.tif';
=======
>>>>>>> Stashed changes
Img = double(imread(filename));
maxintensity=max(Img(:))
imgSize = size(Img);
% show original image
figure('Name','Original image'); imagesc(Img); colormap gray; axis off; axis equal;

for i=2:(maxintensity-2)/10:maxintensity
    numOfHistograms = round(i)
    % in order to use matitk, we have to use 3D data
    % so we first build a 3D volume of two layers, and each layer
    % contains the original image
    D = zeros(imgSize(1),imgSize(2),2);
    D(1:imgSize(1),1:imgSize(2),1) = Img(1:imgSize(1),1:imgSize(2));
    D(1:imgSize(1),1:imgSize(2),2) = Img(1:imgSize(1),1:imgSize(2));

<<<<<<< Updated upstream
    % implement segmentation using Otsu's method
    %b = matitk('SOT',[max(D(:))], double(D));
    b = matitk('SOT',[numOfHistograms], double(D));
    figure('Name','SOT segmented image'); imagesc(squeeze(b(:,:,1))); colormap gray; axis off; axis equal;
end
=======
% implement segmentation using Otsu's method
%segmentedImage = matitk('SOT', [max(D(:))], double(D));
segmentedImage = matitk('SOT', [numOfHistograms], double(D));
figure('Name','SOT segmented image')
imagesc(squeeze(segmentedImage(:,:,1)))
colormap gray; axis off; axis equal;
>>>>>>> Stashed changes
