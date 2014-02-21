function [ mask ] = getguasskernalmask( sig )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

mask=zeros(2*ceil(3*sig)+1,2*ceil(3*sig)+1)

for i = -ceil(3*sig):ceil(3*sig)
    for j= -ceil(3*sig):ceil(3*sig)
        mask(i+ceil(3*sig)+1,j+ceil(3*sig)+1)=exp(-(i^2+j^2)/(2*(sig)^2))
    end
end
 mask = mask/(sum(sum(mask)))
end

