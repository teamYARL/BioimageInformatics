function [ syntheticImg ] = generatesyntheticimg( im, masksize,imagePath )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   Usage: im = image matrix
%          masksize = number (`3` for 3x3 mask)
%   e.g.: im = [1 2 255; 2 3 2; 240 2 1]
%         masksize = 3

% Output not needed?
%[bgMean, bgSD] = getbackgroundinfo(imagePath)

I = double(im);     % Making sure matrix values are double

gaussMask = getguasskernalmask(masksize);

I2=conv2(I,gaussMask, 'same');
disp('Done: conv2 Image with gaussMask')
figure('Name', 'Convolved original image with Gaussian'), imshow(I2,[]);
[ localmax, localmin ] = detectlocalmaxmin( I2, masksize );
disp('Done: detectlocalmaxmin')

% testing
%testBeforeLoop = localmax;
%figure('Name', 'testing to see what comes before loop'), imshow(testBeforeLoop, [])
% testing end

sizeSynMax = size(localmax);
for i = 1:sizeSynMax(1)
    for j = 1:sizeSynMax(2)
        if localmax(i,j) == 1
            localmax(i,j) = I(i,j);
        end
    end
end

% testing
%testBeforeConv = localmax;
%figure('Name', 'testing to see what comes before conv2'), imshow(testBeforeConv, [])
% testing end

localmaxConvolved = conv2(localmax,gaussMask, 'same');
figure('Name', 'Convolved local max'), imshow( localmaxConvolved , [])

syntheticImg = localmaxConvolved;

end
