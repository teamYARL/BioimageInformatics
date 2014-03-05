function [DT] = triangulationproject(localmin)  

% get the size of matrix of local mininum
a = size(localmin);
rol = a(1);
col = a(2);
% number of local minimum in the matrix
num = sum(sum(localmin));
% column vector for x coordinates for local minimum
x=zeros(num,1);
% column vector for y coordinates for local minimum
y=zeros(num,1);

% index for x and y vector
index = 1;
for i = 1 : rol
    for j = 1 : col
        if (localmin(i,j)==1) 
            x(index)=i;
            y(index)=j;
            index = index+1;
        end
    end
end

DT = delaunayTriangulation(x,y);
figure
triplot(DT)
