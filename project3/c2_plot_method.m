function [ joinedDotsImage ] = c2_plot_method( im )
%   binImage = binary version of processes image (dots)

% Convert binaryImage to plot form (as 2-column matrix)

% prewitt, sobel, canny
joinedDotsImage = edge(im, 'canny');
