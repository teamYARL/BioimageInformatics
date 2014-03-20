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

di=size(I2)
ro=di(1)
co=di(2)

figure, 
imshow(I,[])
x=[];
y=[];
for i =1:ro
    for j=1:co
        if localMax(i,j)==1
            x=[x,i];
            y=[y,j];
        end
    end
end

hold on
plot (y,x,'o','MarkerEdgeColor','green')
%imshow(localMax,[])
hold off

figure, 
imshow(I,[])
x=[];
y=[];
for i =1:ro
    for j=1:co
        if localMin(i,j)==1
            x=[x,i];
            y=[y,j];
        end
    end
end
hold on
plot (y,x,'o','MarkerEdgeColor','green')
%imshow(localMin,[])
hold off

[DT,x,y] = triangulationproject(localMin);
disp('Done: triangulationproject')

figure, triplot(DT)

[ newlocalmax ] = tTest(I2, localMax, localMin, bgSD, 3 );
disp('Done: T-test Filtering of maxima')

figure,
imshow(I,[])
hold on
X=[];
Y=[];
for i =1:ro
    for j=1:co
        if newlocalmax(i,j)==1
            X=[X,i]
            Y=[Y,j]
        end
    end
end
plot(Y, X, 'o', 'MarkerEdgeColor','green');

%imshow(newlocalmax,[])
%hold off



disp('FINISHED!')



