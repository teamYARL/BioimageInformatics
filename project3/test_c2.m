% Project Assignment #3
%===============================================================================
% C.2 (Extra credit) : Pixel joining
%===============================================================================
%close all, clc

%===============================================================================
% Assumes result from `test_c1` is not cleared

% Settings
%width = 14;
%sigma = 4.62;      % sigma >= width / sqrt(3) ~= 4.61880 if w=8

% for smoothing
%k = 100;
%l = 0.25;
%===============================================================================

%% User's image location settings
%inputDir1 = 'curve_detection_images';
%filename = 'curv_det_01.tif';
%
%imagePath = [inputDir1, filesep, filename];     % Cross-platform format
%I = imread(imagePath);
%figure('Name','Original Image'), imshow(I, [])
%
%===============================================================================
% Diffusion method
%===============================================================================
%curveDetectImage = I;
%%curveDetectImage = b5_directionalanisotropicfilter(curveDetectImage, k, l);
%% ordering of imshow() changed to compensate for xstarmatrix() plotting behavior
%figure('Name','C.1 : Curve Detection'), imshow(curveDetectImage, [])
%[curveDetectImage, curveBinary] = xstarmatrix_general(curveDetectImage, width, sigma);
%===============================================================================

%figure('Name','curveBinary'), imshow(curveBinary, [])


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


%%Bad seed. Pixel joining text area only (upper left corner area).
%joinedDotsImage = c2_reference_regiongrowing(curveDetectImage, 6, 95, 20);   % 10 pixel join

%%This gets fuzzy path; require result from test_c1.m
%%  This reference region growth code is by D. Kroon from University of Twente
joinedDotsImage = c2_reference_regiongrowing(curveDetectImage, 131, 760, 128);   % 10 pixel join
figure('Name','C.2 : joined dots via region growth'), imshow(joinedDotsImage, [])

disp('Finished')
