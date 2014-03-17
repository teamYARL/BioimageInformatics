clear all, close all

imagePath = '2/images/001_a5_002_t001.tif';    % Path format in Windows
%imagePath = '2/images/001_a5_002_t001.tif';     % Path format in OSX/Linux
I = imread(imagePath);

[bgMean, bgSD] = getbackgroundinfo(imagePath);
disp('Done: getbackgroundinfo')

gaussMask = getguasskernalmask(100);
disp('Done: getguasskernalmask')

I2 = conv2(double(I), gaussMask, 'same');       % To Do: change I to double(I) in all functions
disp('Done: conv2 Image with gaussMask')
% Comparing the gaussMark with sig=1 vs. sig=10 vs. sig=100, there is no
%   change in the number of local maxima or local minima or triangles.

[localMax, localMin] = detectlocalmaxmin(imagePath, 3);
disp('Done: detectlocalmaxmin')

%DT = triangulationproject(localMin);
%disp('Done: triangulationproject')



[newlocalMax] = tTest(I,localMax,bgMean,bgSD,10.0);  %set Q = 10.0
disp('Done: t test')

%mark the new localmaxs
imshow(I);
hold on;

tmp = size(newlocalMax);
rol = tmp(1);
col = tmp(2);

x=[];
y=[];
%xx=[];
%yy=[];
for i = 1 : rol
    for j = 1 : col
        if (newlocalMax(i,j) == 1) 
           x=[x i];
           y=[y j]; 
        end
       % if (localMin(i,j) == 1)
       %    xx=[xx i];
        %   yy=[yy j];
        %end
    end
end
plot(y,x,'o','MarkerFaceColor','green','MarkerEdgeColor','green','MarkerSize',5);
%plot(yy,xx,'o','MarkerFaceColor','red','MarkerEdgeColor','red','MarkerSize',1);



%imshow(I);
disp('FINISHED!')
