clear all, close all

%imagePath = '2\images\001_a5_002_t001.tif'; % Path format in Windows
imagePath = '2/images/001_a5_002_t001.tif'; % Path format in OSX/Linux
I = imread(imagePath);

[bgMean, bgSD] = getbackgroundinfo(imagePath);
disp('Done: getbackgroundinfo')

gaussMask = getguasskernalmask(1.18);
disp('Done: getguasskernalmask')

I2 = conv2(double(I), gaussMask, 'same'); % To Do: change I to double(I) in all functions
disp('Done: conv2 Image with gaussMask')
% Comparing the gaussMark with sig=1 vs. sig=10 vs. sig=100, there is no
% change in the number of local maxima or local minima or triangles.

figure('Name', 'Convolved original image with Gaussian (blur)'), imshow(I2,[])

[localMax, localMin] = detectlocalmaxmin(I2, 5);
disp('Done: detectlocalmaxmin')

di=size(I2);
ro=di(1);
co=di(2);

figure('Name', 'Local Maxima'),
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
plot (y,x,'o','MarkerEdgeColor','red')
%imshow(localMax,[])
hold off

figure('Name', 'Local Minima'),
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

figure('Name', 'Triangulation of Local Minima'), triplot(DT)

[ newlocalmax ] = tTest(I2, localMax, localMin, bgSD, 4.0 );  % Q = 4.0
disp('Done: T-test Filtering of maxima')

figure('Name', 't-test Filtered Local Maxima'),
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
plot(Y, X,'red+');

%imshow(newlocalmax,[])
%hold off



%mark the new localmaxs



[result, num, centerX, centerY] = interp(newlocalmax,I, bgMean);

disp('Done: interptation');
%disp(XX);
%disp(YY);
%disp(ZZ);

%disp('size(XX):');
%disp(num);
%for i =1: num
    %disp(i);
    %disp(XX);
   % tmp = ZZ(:,[1+5*(i-1),2+5*(i-1),3+5*(i-1),4+5*(i-1),5+5*(i-1)]);
  %  result = gaussianfit(XX([1+5*(i-1),2+5*(i-1),3+5*(i-1),4+5*(i-1),5+5*(i-1)],:),YY([1+5*(i-1),2+5*(i-1),3+5*(i-1),4+5*(i-1),5+5*(i-1)],:),tmp);
 %   disp(result);
%end

disp('Done: gaussian fitting');

figure('Name', 'Sub-pixel Center'),
imshow(I,[])
hold on

plot(centerX, centerY,'green+');


%imshow(I);
disp('FINISHED!')
