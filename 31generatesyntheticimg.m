function [ synthetic_img ] = 31generatesyntheticimg( im, masksize )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   Usage: im = image matrix
%          masksize = number (`3` for 3x3 mask)
%   e.g.: im = [1 2 255; 2 3 2; 240 2 1]
%         masksize = 3

I = imread(im);
I = double(I);     %double as recommended by Prof Yang

I2 = conv2(double(I), gaussMask, 'same');   % check conv2 vs filter2
disp('Done: conv2 Image with gaussMask')
% Comparing the gaussMark with sig=1 vs. sig=10 vs. sig=100, there is no
%   change in the number of local maxima or local minima or triangles.

[ localmax, localmin ] = detectlocalmaxmin( I2, masksize )
disp('Done: detectlocalmaxmin')

% TO DO: display synthetic img
synthetic_img = localmax;

% TO DO: simulate actual image noise by adding white background noise
% use `getbackgroundinfo
background_noise = 0; % something similar to localmin

