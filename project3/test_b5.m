% Project Assignment #3
%===============================================================================
% B.5 extra-credit : Implement a non-iterative directional anisotropic filter
%===============================================================================
%close all, clc

%===============================================================================
% Settings

% Degrees to use for answering question B.5:
%   30, 60, 90, 120, 150
angle = 30;   %phi

% For isotropic case, `sig_lat = sig_long`
sig_long = 10;  % Sigma for longitudinal direction
sig_lat = 5;    % Sigma for lateral direction
%===============================================================================

% User's image location settings
inputDir1 = 'curve_detection_images';
filename = 'curv_det_01.tif';

imagePath = [inputDir1, filesep, filename];     % Cross-platform format
I = imread(imagePath);

filteredImage = b5_directionalanisotropicfilter(I, sig_long, sig_lat, angle);
disp('Finished: B.5')
