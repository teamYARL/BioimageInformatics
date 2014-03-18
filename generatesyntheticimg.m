function [ syntheticImg ] = generatesyntheticimg( im, masksize,imagePath )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   Usage: im = image matrix
%          masksize = number (`3` for 3x3 mask)
%   e.g.: im = [1 2 255; 2 3 2; 240 2 1]
%         masksize = 3

[bgMean, bgSD] = getbackgroundinfo(imagePath)

I = double(im);     % Making sure matrix values are double

gaussMask = getguasskernalmask(masksize);

%I2 = conv2(I, gaussMask, 'same');   % check conv2 vs filter2
%disp('Done: conv2 Image with gaussMask')
I2 = filter2(gaussMask, im);
disp('Done: filter2 Image with gaussMask')

[ localmax, localmin ] = detectlocalmaxmin_inputMatrix( I2, masksize );
disp('Done: detectlocalmaxmin')

% Display synthetic img
%intI = int8(localmax);
syntheticImgMax = mat2gray( localmax );
syntheticImgMin = mat2gray( localmin );
figure, imshow( syntheticImgMax )
figure, imshow( syntheticImgMin )

syntheticImg = syntheticImgMin;
figure
% Overlay synthetic image on first image
green = cat(3, zeros(size(I)), ones(size(I)), zeros(size(I)));
hold on
%set(imshow, 'AlphaData', syntheticImg)
h = imshow(green)
hold off
set(h)
set(h, 'AlphaData')
set(h, 'AlphaData', syntheticImg)

% TO DO: simulate actual image noise by adding white background noise
% use `getbackgroundinfo

noiseIm=imnoise(syntheticImgMax,'gaussian',bgMean,bgSD);

%figure;
imshow(noiseIm,[])
syntheticImg=noiseIm;


