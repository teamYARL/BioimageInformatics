%clear all, close all

%imagePath = '2\images\001_a5_002_t001.tif';    % Path format in Windows
imagePath = '2/images/001_a5_002_t001.tif';     % Path format in OSX/Linux
I = imread(imagePath);

[bgMean, bgSD] = getbackgroundinfo(imagePath);
disp('Done: getbackgroundinfo')

gaussMask = getguasskernalmask(1.18);
disp('Done: getguasskernalmask')

I2 = conv2(double(I), gaussMask, 'same');
figure('Name', 'Convolved original image with gaussMask (blur)'), imshow(I2, [])

% Detect localmaxmin with masksize=5
[localMax, localMin] = detectlocalmaxmin(I2, 5);
disp('Done: detectlocalmaxmin')

%mapplotontoimage( I,0,0,localMax,'o','MarkerEdgeColor','green' )
%imshow(localMax,[])


di=size(I2);
ro=di(1);
co=di(2);

figure('Name', 'Maxima'), 
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



figure('Name', 'Minima'), 
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




[DT,x,y] = triangulationproject(localMin);
figure('Name', 'Triangulation of minima'), triplot(DT)



[ newlocalmax ] = tTest(I2, localMax, localMin, bgSD, 10 );
disp('Done: T-test Filtering of maxima')

%mapplotontoimage( I,0,0,newlocalmax,'o','MarkerEdgeColor','green' )

figure('Name', 't-test filtered maxima'),
imshow(I,[])
hold on
X=[];
Y=[];
for i =1:ro
    for j=1:co
        if newlocalmax(i,j)==1
            X=[X,i];
            Y=[Y,j];
        end
    end
end
plot(Y, X, 'o', 'MarkerEdgeColor','green');

%imshow(newlocalmax,[])
%hold off

disp('FINISHED!')
