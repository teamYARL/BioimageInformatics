function [ output_args ] = accuracyofsubpixel( im ,listmax )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% this is part 3.3
% figure out accuracy and precision by
%   overlay result from 3.2 with SyntheticImg from 3.1
%   find distance difference between their maxima

% Assuming original image's centerX and centerY is already in the .mat to compare
% Generate coordinates for SyntheticImg

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

[result, num, centerX, centerY] = interp(newlocalmax,I, bgMean);
disp('Done: interptation');
disp('Done: gaussian fitting');

figure('Name', 'Sub-pixel Center'),
imshow(I,[])
hold on

plot(centerX, centerY,'green+');

disp('FINISHED!')


nummax=length(listmax)  % Is listmax == list of maxima's coordinates?
for i=1:nummax
    for j=1
end

end

