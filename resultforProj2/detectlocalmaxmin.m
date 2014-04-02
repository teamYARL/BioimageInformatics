function [ localmax, localmin ] = detectlocalmaxmin( im, masksize )
%UNTITLED Summary of this function goes here
%   Usage: im = image path
%          masksize = number (`3` for 3x3 mask)
%   e.g.: im = '2/images/001.tif'
%         masksize = 3

%I = imread(im);
I = double(im);     %double as recommended by Prof Yang

dimensions = size(I);
minmap = zeros(dimensions);
maxmap = zeros(dimensions);

offset = floor(masksize/2);

for i = 1+offset:dimensions(1)-offset
    for j = 1+offset:dimensions(2)-offset
        submatrix = I(i-offset:i+offset, j-offset:j+offset);
        cpoint = I(i,j);
        submatrix = submatrix(:);
        if cpoint == max(submatrix)
            maxmap(i,j) = 1;
        end
        if cpoint == min(submatrix)
            minmap(i,j) = 1;
        end
    end
end

localmax = maxmap;
localmin = minmap;

end
