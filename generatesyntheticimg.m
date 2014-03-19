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
figure,imshow(I2,[])

I3=conv2(gaussMask, im);
figure,imshow(I3,[])
I4= filter2(im, gaussMask);
figure,imshow(I4,[])
[ localmax, localmin ] = detectlocalmaxmin_inputMatrix( I2, masksize );
disp('Done: detectlocalmaxmin')

% Display synthetic img
%intI = int8(localmax);
syntheticImgMax = mat2gray( localmax );
syntheticImgMin = mat2gray( localmin );
figure, imshow( syntheticImgMax )
figure, imshow( syntheticImgMin )

syntheticImg = syntheticImgMin;%WHY why is this the synthetic image!?!?!?! Its wrong
syntheticImg = syntheticImgMax;
figure
% Overlay synthetic image on first image
green = cat(3, zeros(size(I)), ones(size(I)), zeros(size(I)));
hold on
%set(imshow, 'AlphaData', syntheticImg)
h = imshow(green,'AlphaData', syntheticImg);
hold off
%set(h)
%set(h, 'AlphaData')
%set(h, 'AlphaData', syntheticImg)

% TO DO: simulate actual image noise by adding white background noise
% use `getbackgroundinfo

%this is all wrong why did you do this?!?!?!?!?
%bgVar = bgSD^2;
%bgMean = bgMean;
%sum_bg = bgVar + bgMean;    % for normalizing 
%normalized_bgMean = bgMean/sum_bg
%normalized_bgVar = bgVar/sum_bg

%allWhiteImg = ones(size(syntheticImgMax));
%noiseIm=imnoise(syntheticImgMax,'gaussian',normalized_bgMean, normalized_bgVar);
noiseIm=imnoise(syntheticImg,'gaussian',bgMean,bgSD);
%noiseIm=imcomplement( noiseIm );
%noiseIm=imnoise(syntheticImgMax,'poisson'); %,bgMean,bgSD);

%figure;
imshow(noiseIm,[])
disp('Done: showing noiseIm (synthetic image)')
syntheticImg=noiseIm;


