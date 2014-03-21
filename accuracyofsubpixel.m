function [ Xcoordinate, Ycoordinate ] = accuracyofsubpixel( I )
%UNTITLED Summary of this function goes here
%   input:
%       I is matrix
%   output:
%       mean is double/float
%       sd is double/float

%===============================================================================
% this is part 3.3 along with part33.m
%===============================================================================
% figure out accuracy and precision by
%   overlay result from 3.2 with SyntheticImg from 3.1
%   find distance difference between their maxima

% Generate coordinates for SyntheticImg
I = double(I);
[bgMean, bgSD] = getbackgroundinfo_inputIsMatrix(I);
disp('Done: getbackgroundinfo')

gaussMask = getguasskernalmask(1.18);
disp('Done: getguasskernalmask')

I2 = conv2(double(I), gaussMask, 'same');
disp('Done: conv2 Image with gaussMask')

[localMax, localMin] = detectlocalmaxmin(I2, 5);
disp('Done: detectlocalmaxmin')

di=size(I2);
ro=di(1);
co=di(2);


[ newlocalmax ] = tTest(I2, localMax, localMin, bgSD, 4.0 );  % Q = 4.0
disp('Done: T-test Filtering of maxima')

[result, num, centerX, centerY] = interp(newlocalmax,I, bgMean);
disp('Done: interptation');
disp('Done: gaussian fitting');

figure('Name', 'Sub-pixel Center'),
imshow(I,[])
hold on

plot(centerX, centerY,'green+');
disp('FINISHED!')

Xcoordinate = centerX;
Ycoordinate = centerY;

end

