%clear all, close all

imagePath = '2\images\001_a5_002_t001.tif';    % Path format in Windows
%imagePath = '2/images/001_a5_002_t001.tif';     % Path format in OSX/Linux
I = imread(imagePath);

[bgMean, bgSD] = getbackgroundinfo(imagePath);
disp('Done: getbackgroundinfo')

gaussMask = getguasskernalmask(1.18);
disp('Done: getguasskernalmask')

I2 = conv2(double(I), gaussMask, 'same');       % To Do: change I to double(I) in all functions
disp('Done: conv2 Image with gaussMask')
% Comparing the gaussMark with sig=1 vs. sig=10 vs. sig=100, there is no
%   change in the number of local maxima or local minima or triangles.

figure, imshow(I2,[])

[localMax, localMin] = detectlocalmaxmin(I2, 5);
disp('Done: detectlocalmaxmin')

mapplotontoimage( I,0,0,localMax,'o','MarkerEdgeColor','green' )
%imshow(localMax,[])

mapplotontoimage( I,0,0,localMin,'o','MarkerEdgeColor','green' )
%imshow(localMin,[])


[DT,x,y] = triangulationproject(localMin);
disp('Done: triangulationproject')

figure, triplot(DT)

[ newlocalmax ] = tTest(I2, localMax, localMin, bgSD, 10 );
disp('Done: T-test Filtering of maxima')

mapplotontoimage( I,0,0,newlocalmax,'o','MarkerEdgeColor','green' )
%imshow(newlocalmax,[])
%hold off



disp('FINISHED!')



