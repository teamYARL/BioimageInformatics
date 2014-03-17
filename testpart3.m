clear all, close all

%imagePath = '2\images\001_a5_002_t001.tif';    % Path format in Windows
imagePath = '2/images/001_a5_002_t001.tif';     % Path format in OSX/Linux
I = imread(imagePath);
%I = double(I);

%[bgMean, bgSD] = getbackgroundinfo(imagePath);
%disp('Done: getbackgroundinfo')

syntheticImg = generatesyntheticimg(I, 10);
% Result:
%   masksize = 3;   too much dots
%   masksize = 100; 1 dot in localmin figure
%   masksize = 10;  localmax figure looks off, localmin showing fluorophore locations (with a little bit of noise)
%       TO DO: check function that generated localmax and localmin

% Display original image for comparison ( mainly for testing )
figure, imshow(I,[])

disp('FINISHED!')
