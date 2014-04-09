% Project Assignment #3
%===============================================================================
% C.2 (Extra credit) : joining the dots
%   Assumes "curveBinary" variable from `test_c1` is not cleared
%===============================================================================
%close all, clc

%===============================================================================
% User's image location settings
%===============================================================================
inputDir1 = 'curve_detection_images';
filename = 'curv_det_01.tif';

imagePath = [inputDir1, filesep, filename];     % Cross-platform format
I = imread(imagePath);
figure('Name','Original Image'), imshow(I, [])


%===============================================================================
% Implement our own Region Growth method
%===============================================================================
%seedRegion = getrect();
%xmin = seedRegion(1);
%ymin = seedRegion(2);
%width = seedRegion(3);
%height = seedRegion(4);
%curveBinaryROI = curveBinary(ymin:ymin+height, xmin:xmin+width);
%figure('Name','seedROI'), imshow(curveBinaryROI, [])

%[IDX, C] = kmeans(curveBinaryROI, 1);


%===============================================================================
% Trying out another pixel joining method
%===============================================================================
% Assume test_c1 ran and generated curveDetectImage
%joinedDotsImage = c2_plot_method(curveDetectImage);
%figure('Name','C.2 : joined dots'), imshow(joinedDotsImage, [])


%===============================================================================
% Using reference Region Growth method
%===============================================================================
%joinedDotsImage = c2_reference_regiongrowing(curveBinary, xmin:xmin+width, ymin:ymin+height, width*height);
%joinedDotsImage = c2_reference_segCroissRegion(0,curveBinary,6,95); %(6,95) = pixelSeed
%joinedDotsImage = c2_reference_regiongrowing(curveBinary, 6, 95, 2);   % 10 pixel join


%%Bad seed example. Pixel joining text area only (upper left corner area).
%joinedDotsImage = c2_reference_regiongrowing(curveDetectImage, 6, 95, 20);   % 10 pixel join

%%This gets fuzzy path; require result from test_c1.m
%%  This reference region growth code is by D. Kroon from University of Twente
joinedDotsImage = c2_reference_regiongrowing(curveDetectImage, 131, 760, 128);
figure('Name','C.2 : Pixel joining via region growth'), imshow(joinedDotsImage, [])


%===============================================================================
% Built-in method
%===============================================================================
% Assume test_c1 ran and generated curveDetectImage
%joinedDotsImage = c2_plot_method(curveDetectImage);
%figure('Name','C.2 : joined dots'), imshow(joinedDotsImage, [])

[Xstar_coord, Xstar_mag] = binary_of_xstar(I, width, sigma);
disp('Finished')
