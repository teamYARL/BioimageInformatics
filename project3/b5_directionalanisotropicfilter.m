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
%   canny edge detector from lecture 14's class demo (edge_demo.m)

mask_size_x = 10;
mask_size_y = mask_size_x;

phi_rad = phi * pi / 180;   % convert to phi in radians
% equation 11 from paper
sig2_u = sig_long^2;    % for x convolution
sig2_v = sig_lat^2;     % for y convolution

top = sig2_v*cos(phi_rad)^2 + sig2_u*sin(phi_rad)^2;
bottom = (sig2_u - sig2_v) * cos(phi_rad) * sin(phi_rad);
tanphi = top / bottom;

I = double(im);
[rows, cols] = size(I);
filteredImage = I;      % initialize end result

% x-direction
%filtered_x = filter_aniso(x, y, sig_lat)
filter_x = d2dgauss(mask_size_x, sig_long, mask_size_y, sig_lat, 0);
Ix = conv2(I, filter_x, 'same');
%figure('Name','x-direction'), imshow(Ix, [])

% t-direction
%filtered_t = filter_aniso(x, y, tanphi)
filter_t = d2dgauss(mask_size_x, sig_long, mask_size_y, sig_lat, phi_rad);
It = conv2(I, filter_t, 'same');
figure('Name','t-direction'), imshow(It, [])

% Combining x and t directional derivatives (norm)
%   method in combining taken from lecture 14's canny edge detection
norm = sqrt(Ix.*Ix + It.*It);
figure('Name','Combined x and t'), imshow(norm, [])


%figure('Name','Directional Anisotropic Filtered Image'),
%imshow(filteredImage, [])

end


% Directional 2D gauss from lecture 14 with modifications
%%%%%%% The functions used in the main.m file %%%%%%%
% Function "d2dgauss.m":
% This function returns a 2D edge detector (first order derivative
% of 2D Gaussian function) with size n1*n2; theta is the angle that
% the detector rotated counter clockwise; and sigma1 and sigma2 are the
% standard deviation of the gaussian functions.
function h = modX_d2dgauss(n1,sigma1,n2,sigma2,theta)
r=[cos(theta)  sin(theta);  %changed
  -sin(theta)  cos(theta)];
for i = 1 : n2 
    for j = 1 : n1
        x = j-(n1+1)/2;     %changed
        y = i;              %changed
        u = r * [x ; y];
        h(i,j) = gauss(u(1),sigma1)*dgauss(u(2),sigma2);     %changed
    end
end
h = h / sqrt(sum(sum(abs(h).*abs(h))));
end

function h = mod_d2dgauss(n1,sigma1,n2,sigma2,theta)
r=[cos(theta)  sin(theta);
  -sin(theta)  cos(theta)];

sig2_u = sigma1^2;    % for x convolution
sig2_v = sigma2^2;    % for y convolution

top = sig2_v*cos(theta)^2 + sig2_u*sin(theta)^2;
bottom = (sig2_u - sig2_v) * cos(theta) * sin(theta);
tantheta = top / bottom;

for i = 1 : n2 
    for j = 1 : n1
        x = j/tantheta-(n1+1)/2; %different from paper
        y = i-(n2+1)/2;
        u = r * [x ; y];
        h(i,j) = gauss(u(1),sigma1)*dgauss(u(2),sigma2);
    end
end
h = h / sqrt(sum(sum(abs(h).*abs(h))));
end

function h = d2dgauss(n1,sigma1,n2,sigma2,theta)
r=[cos(theta)  sin(theta);
  -sin(theta)  cos(theta)];
for i = 1 : n2 
    for j = 1 : n1
        x = j-(n1+1)/2; %different from paper
        y = i-(n2+1)/2;
        u = r * [x ; y];
        h(i,j) = gauss(u(1),sigma1)*dgauss(u(2),sigma2);
    end
end
h = h / sqrt(sum(sum(abs(h).*abs(h))));
end

% Function "gauss.m":
function y = gauss(x,std)
y = exp(-x^2/(2*std^2)) / (std*sqrt(2*pi));
end

% Function "dgauss.m"(first order derivative of gauss function):
function y = dgauss(x,std)
y = -x * gauss(x,std) / std^2;
end
%%%%%%%%%%%%%% end of the functions %%%%%%%%%%%%%
