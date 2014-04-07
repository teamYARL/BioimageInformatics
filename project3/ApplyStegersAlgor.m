% to get the sigma for gaussian function
% img is the input image
function [ sigma ] = ApplyStegersAlgor(img)

I=double(img);
figure('Name', 'Please select the region with the thickest line in this image.') 
imshow(I, [])

rect = getrect();
croppedRegion = imcrop(I, rect);


figure('Name', 'Please select the tight square around the widest curve in this image.') 
imshow(croppedRegion, [])

data = [];
% crop the line width for 3 times and calculate the average 
for i = 1:3
    rect = getrect();
    area = imcrop(croppedRegion, rect);
    s = size(area);
    data = [data s(1)];
end

% get the average of line width
width=mean(data)
% get sigma
sigma=width/sqrt(3)

fixedmask=getguasskernalmask(sigma);
% size(fixedmask)
I2 = conv2(I,fixedmask, 'same');   

imshow(I2, [])