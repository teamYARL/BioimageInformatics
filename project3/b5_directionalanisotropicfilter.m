function [ filteredImage ] = b5_directionalanisotropicfilter( im, sig_long, sig_lat, phi )
%B.5 (extra credit): Implementation of a directional anisotropic filter
%   (non-iterative form)
%   from the paper "Fast anisotropic Gaussian filtering" by Geusebroek, et al
%   Result should: smooth signal, preserve edges, enhance edge contrast
%
%   im: image
%   sig_long: sigma in the longitudinal direction (=10)
%   sig_lat: sigma in the lateral direction (=5)
%   phi: in degrees. filter angle (=30, 60, 90, 120, 150)
%
%Code Reference
%   anigauss{.c, .mexglx} from Steger, et al's paper


phi_rad = phi * pi / 180;   % phi in radians
% equation 11 from paper
sig2_u = sig_long^2;    % x convolution
sig2_v = sig_lat^2;     % y convolution

top = sig2_v*cos(phi_rad)^2 + sig2_u*sin(phi_rad)^2;
bottom = (sig2_u - sig2_v) * cos(phi_rad) * sin(phi_rad);
tanphi = top / bottom;

I = double(im);
[rows, cols] = size(I);
filteredImage = I;

filtered_x = filter_aniso(x, y, sig_lat)
filtered_y = filter_aniso(x, y, sig_long)
filtered_t = filter_aniso(x, y, tanphi)
filtered_derivative = filter_aniso(x, y, phi, order)

gaussMask_x = getguasskernalmask(sig_long);
gaussMask_y = getguasskernalmask(sig_lat);



%% init filteredImageOperation with padding
%filteredImageOperation = zeros(rows+2, cols+2);
%filteredImageOperation(2:rows+1, 2:cols+1) = filteredImage;
%
%% Differences
%diffN = filteredImageOperation(1:rows, 2:cols+1) - filteredImage;
%diffS = filteredImageOperation(3:rows+2, 2:cols+1) - filteredImage;
%diffE = filteredImageOperation(2:rows+1, 3:cols+2) - filteredImage;
%diffW = filteredImageOperation(2:rows+1, 1:cols) - filteredImage;
%
%% Convolution Filter
%% Sheared filter
%% Filtered and interpolated
%
%% Conduction
%conductionN = 1 ./ (1 + (diffN/kappa).^2);
%conductionS = 1 ./ (1 + (diffS/kappa).^2);
%conductionE = 1 ./ (1 + (diffE/kappa).^2);
%conductionW = 1 ./ (1 + (diffW/kappa).^2);
%
%% Apply four-point-template
%filteredImage = filteredImage + lambda*(conductionN.*diffN + conductionS.*diffS + conductionE.*diffE + conductionW.*diffW);

figure('Name','Directional Anisotropic Filtered Image'),
imshow(filteredImage, [])

end
