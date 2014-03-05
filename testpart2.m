clear all, close all
imagePath = '2\images\\001_a5_002_t001.tif';
I = imread(imagePath);
[bgMean, bgSD] = getbackgroundinfo(imagePath);
gaussMask = getguasskernalmask(10);
I2 = conv2(I, gaussMask, 'same');
[localMax, localMin] = detectlocalmaxmin(imagePath, 3);
DT = triangulationproject(localMin);