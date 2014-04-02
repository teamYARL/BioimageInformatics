function [ resultset,number,centerX, centerY] = interp( localmax, I, bg )

resultset = [];

%vector to store the x coordinate of the center 
centerX = [];
%vector to store the y coordinate of the center
centerY = [];

tmp = size(localmax);
rol = tmp(1);
col = tmp(2);

X=[];
Y=[];
Z=[];

num = 0;

for i = 1 : rol
    for j = 1 : col
        if (localmax(i,j) == 1) 
            X = [X j];
            Y = [Y i];
            Z = [Z I(i,j)];
            num = num+1;
        end
    end
end

%disp(X);
%disp(Y);
%disp(Z);

number = num;

for k = 1 : num
    
    disp('entering loop');
    disp(k);
    
     [XI,YI] = meshgrid(X(k)-0.4:0.2:X(k)+0.4, Y(k)-0.4:0.2:Y(k)+0.4);
     
     
     
     XX=[];
     YY=[];
     ZZ=zeros(3);
     
     XX = [X(k)-1,X(k),X(k)+1];
     YY = [Y(k)-1,Y(k),Y(k)+1];
     for i = -1:1:1
         for j = -1:1:1
             ZZ(i+2,j+2) = I(Y(k)+i, X(k)+j) - bg;
         end
     end
     
     zi = interp2(XX,YY,ZZ,XI,YI,'cubic');
     %disp(XI(1,:));
     %disp(YI(:,1));
     %disp(zi);
     
     result = gaussianfit(1:5,1:5,zi);
     %disp(X(k)-0.4);
     %disp(Y(k)-0.4);
     
     result(3) = (X(k)-0.4+(result(3)-1)*0.2); % the absolute x-coordinate of the center
     result(4) = (Y(k)-0.4+(result(4)-1)*0.2); % the absolute y-coordinate of teh center
     %resultset is the vector of results, for each result, result(3)=x0, result(4)=y0 
     resultset = [resultset result'];
     disp(result);
     
     centerX = [centerX result(3)];
     centerY = [centerY result(4)];
end
