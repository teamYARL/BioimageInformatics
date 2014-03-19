function [ resultset,number] = interp( localmax, I )

resultset = [];

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
            X = [X i];
            Y = [Y j];
            Z = [Z I(i,j)];
            num = num+1;
        end
    end
end

%disp(X);
%disp(Y);
%disp(Z);

number = num;


disp('entering loop');
for k = 1 : num
    
    
    %disp(k);
    
     [XI,YI] = meshgrid(X(k)-0.4:0.2:X(k)+0.4, Y(k)-0.4:0.2:Y(k)+0.4);
     
     
     
     XX=[];
     YY=[];
     ZZ=zeros(3);
     
     XX = [X(k)-1,X(k),X(k)+1];
     YY = [Y(k)-1,Y(k),Y(k)+1];
     for i = -1:1:1
         for j = -1:1:1
             ZZ(i+2,j+2) = I(X(k)+i, Y(k)+j);
         end
     end
     
     zi = interp2(XX,YY,ZZ,XI,YI,'cubic');
     %disp(XI(1,:));
     %disp(YI(:,1));
     %disp(zi);
     
     result = gaussianfit(XI(1,:),YI(:,1),zi);
     disp(X(k));
     disp(Y(k));
     tmp1 = result(3)
     tmp2 = result(4)
     result(3) = X(k)-0.4+tmp2*0.2
     result(4) = Y(k)-0.4+tmp1*0.2
     resultset = [resultset result'];
     %disp(result);
     
     
end