% Project Assignment #3
%===============================================================================
% B.5 : Implement a non-iterative directional anisotropic filter
%===============================================================================
close all, clc

%===============================================================================
% Settings
%old
%kappa = 100;
%lambda = 0.25;

% For isotropic case, `sig_lat = sig_long`
sig_long = 10;  % Sigma for longitudinal direction
sig_lat = 5;    % Sigma for lateral direction

% Degrees to use for answering question B.5:
%   30, 60, 90, 120, 150
angle = 30;   %phi
%===============================================================================

% User's image location settings
inputDir1 = 'curve_detection_images';
%inputDir2 = 'DrosophilaVesicleTransport';
filename = 'curv_det_01.tif';

%imagePath = [inputDir1, filesep, inputDir2, filesep, filename];     % Cross-platform format
imagePath = [inputDir1, filesep, filename];     % Cross-platform format
I = imread(imagePath);
figure('Name','Original Image'), imshow(I, [])

filteredImage = b5_directionalanisotropicfilter(I, sig_long, sig_lat, angle);
disp('Finished: B.5')
%filteredImage = b5_directionalanisotropicfilter(I, kappa, lambda);
% imshow() is inside the b5_directionalanisotropicfilter() function
