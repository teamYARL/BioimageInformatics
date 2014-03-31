% Project Assignment #3
%===============================================================================
% B.5 : Implement a non-iterative directional anisotropic filter
%===============================================================================
close all, clc

%Settings
kappa = 20;
lambda = 0.25;

% User's image location settings
inputDir1 = 'imagesfromproj1';
%inputDir2 = 'DrosophilaVesicleTransport';
filename = 'image01.tiff';

%imagePath = [inputDir1, filesep, inputDir2, filesep, filename];     % Cross-platform format
imagePath = [inputDir1, filesep, filename];     % Cross-platform format
I = imread(imagePath);
figure('Name','Original Image'), imshow(I, [])

filteredImage = b5_directionalanisotropicfilter(I, kappa, lambda);
% imshow() is inside the b5_directionalanisotropicfilter() function
