function [ mask ] = getguasskernalmask( sig )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

sizeparameter=ceil(3*sig);
sig
3*sig
ceil(3*sig)
sp=sizeparameter

mask=zeros(2*sp+1,2*sp+1);

for i = -sp:sp
    for j= -sp:sp
        mask(i+sp+1,j+sp+1)=exp(-(i^2+j^2)/(2*(sig)^2));
    end
end
 mask = mask/(sum(sum(mask)));
end

