function [ filteredImage ] = b5_directionalanisotropicfilter( im, kappa, lambda )
%B.5 (extra credit): Implementation of a directional anisotropic filter
%   (non-iterative form)
%   from the paper "Fast anisotropic Gaussian filtering" by Geusebroek, et al
%   Result should: smooth signal, preserve edges, enhance edge contrast
%
%   im: image
%   kappa: conduction coefficient (20-100)
%   lambda: max value of 0.25 for stability
%
%Code References:
%   mathworks.com/matlabcentral/fileexchange/31204-anisodiff-in-matlab/content/anisodiff.m
%   mathworks.com/matlabcentral/fileexchange/14995-anisotropic-diffusion-perona-malik/content/anisodiff_Perona-Malik/anisodiff2D.m

I = double(im);
[rows, cols] = size(I);
filteredImage = I;

% init filteredImageOperation with padding
filteredImageOperation = zeros(rows+2, cols+2);
filteredImageOperation(2:rows+1, 2:cols+1) = filteredImage;

% Differences
diffN = filteredImageOperation(1:rows, 2:cols+1) - filteredImage;
diffS = filteredImageOperation(3:rows+2, 2:cols+1) - filteredImage;
diffE = filteredImageOperation(2:rows+1, 3:cols+2) - filteredImage;
diffW = filteredImageOperation(2:rows+1, 1:cols) - filteredImage;

% Convolution Filter
% Sheared filter
% Filtered and interpolated

% Conduction
conductionN = 1 ./ (1 + (diffN/kappa).^2);
conductionS = 1 ./ (1 + (diffS/kappa).^2);
conductionE = 1 ./ (1 + (diffE/kappa).^2);
conductionW = 1 ./ (1 + (diffW/kappa).^2);

% Apply four-point-template
filteredImage = filteredImage + lambda*(conductionN.*diffN + conductionS.*diffS + conductionE.*diffE + conductionW.*diffW);

figure('Name','Directional Anisotropic Filtered Image'),
imshow(filteredImage, [])

end
