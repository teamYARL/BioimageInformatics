% Clean up MATLAB environment before starting
clc, close all


%===============================================================================
% Settings
%   Adjust position of variable `max_numOfx` on line 45, setting inside the loop
%===============================================================================
max_propagationScaling = 10;
max_curvatureScaling = 10;
max_setMaximumRMSError = 5;
max_setNumberOfIterations = 10;

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
for propagationScaling = 1:max_propagationScaling
    for curvatureScaling = 1:max_curvatureScaling
        for setMaximumRMSError = 1:max_setMaximumRMSError
            for setNumberOfIterations = 1:max_setNumberOfIterations
                settings = [propagationScaling curvatureScaling setMaximumRMSError setNumberOfIterations];
                parameter_name = [int2str(propagationScaling), '-', int2str(curvatureScaling), '-', int2str(setMaximumRMSError), '-', int2str(setNumberOfIterations)];
                segmentedImage = matitk('SSDLS', settings, uint8(D), uint8(gD), []);
                %figure('Name','SSDLS segmented image')
                h = imagesc(squeeze(segmentedImage(:,:,1))); colormap gray; axis off; axis equal;
                saveas(h, ['results_partB_SSDLS', filesep, name_out, '_SSDLS_', parameter_name], 'png')
            end
        end
    end
end
