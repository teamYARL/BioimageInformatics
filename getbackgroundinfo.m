function [ mean,standarddeviation ] = getbackgroundinfo( im )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
close all
I=imread(im);
figure, imshow(I,[])
disp('Please select image background')
rec=getrect;
background=imcrop(I,rec);
mean=mean2(background);
standarddeviation=std2(background);

end

