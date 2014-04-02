clear all, close all

%imagePath = '2\images\001_a5_002_t001.tif';    % Path format in Windows
imagePath = '2/images/001_a5_002_t001.tif';     % Path format in OSX/Linux
I = imread(imagePath);
%I = double(I);

%testing for comparison
figure('Name', 'Original image'), imshow(I,[])

syntheticImg = generatesyntheticimg(I, 3,imagePath);
figure('Name', 'Synthetic image as ground truth'), imshow(syntheticImg, [])



%[bgMean, bgSD] = getbackgroundinfo(imagePath);
%disp('Done: getbackgroundinfo')

gaussMask = getguasskernalmask(1.18);
disp('Done: getguasskernalmask')

I2 = conv2(double(I), gaussMask, 'same');
disp('Done: conv2 Image with gaussMask')

[localMax, localMin] = detectlocalmaxmin(imagePath, 3);

[resultset, number] = interp( localMax, I2 );

disp('FINISHED!')
