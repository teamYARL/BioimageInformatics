function [ ave ] = trianglemean( x,y,DT,X,Y,im )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

minindex=0
minEUD=100000
numtri=size(DT)
numtri=numtri(2)
for i =1:numtri
    col=DT(:,i);
    EUDsum=0
    for j=1:3
        position=col(j)
        xcoor=X(position)
        ycoor=Y(position)
        EUDsum=EUDsum+(x-xcoor)^2+(y-ycoor)^2
    end
    if EUDsum<minEUD
       minEUD=EUDsum;
       minindex=i;
    end
end

best=DT(:,minindex);
su=0;
for j=1:3
    position=best(j)
    xcoor=X(position)
    ycoor=Y(position)
    su=su+im(xcoor,ycoor)
end

ave=su/3

end

