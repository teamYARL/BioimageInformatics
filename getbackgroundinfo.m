function [ mean,standarddeviation ] = getbackgroundinfo( im )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
I=imread(im)
imshow(I,[])
rec=getrect
background=imcrop(I,rec)
ds=size(background)
mean=sum(sum(background))/(ds(1)*ds(2))
standarddeviation=std2(background)

end

