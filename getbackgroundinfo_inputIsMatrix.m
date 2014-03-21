function [ bg_mean, bg_SD ] = getbackgroundinfo_inputIsMatrix( I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
close all
figure('Name', 'Please select background of this image'), imshow(I,[])
disp('Please select image background')

rec = getrect;
background = imcrop(I,rec);
bg_mean = mean2(background);
bg_SD = std2(background);

end
