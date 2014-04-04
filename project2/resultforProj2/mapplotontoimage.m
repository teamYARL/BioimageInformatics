function [ newimagehandle ] = mapplotontoimage( image,x,y, matrix,marker, colparam,color )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if x==0
    di=size(matrix);
    ro=di(1);
    co=di(2);
    figure,
    newimagehandle=imshow(image,[]);
    hold on
    X=[];
    Y=[];
    for i =1:ro
        for j=1:co
            if matrix(i,j)==1
                X=[X,i];
                Y=[Y,j];
            end
        end
    end
    plot (Y,X,marker,colparam,color)
    hold off
end
if matrix==0
    figure,
    newimagehandle=imshow(image,[]);
    hold on
    plot (y,x,marker,colparam,color)
    hold off
end


end

