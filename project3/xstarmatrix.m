% H is the output of hessianmatrix function
% E is the output of eigenmatrix function
function [ Xstar ] = xstarmatrix(img)
H = hessianmatrix(img,14,4.62);
[E,eigNoiseMatrix] = eigenmatrix(H);
img=double(img);
% get size of H
[m,n] = size(img);
Xstar = zeros(m,n);

[FX,FY] = gradient(img);


% create a whole black image with same size to check marked xstar
I = zeros(m,n);
imshow(I,[])


hold on

r2val=[]
for i = 1:m
    for j = 1:n
        f = zeros(2,1);
        f(1,1) = FX(i,j);
        f(2,1) = FY(i,j);
       
        eigenvector = E{i,j};
        % disp('first');
        % disp(eigenvector);
        N = zeros(1,2);
        N(1,1) = eigenvector(1);
        N(1,2) = eigenvector(2);
        
        h = H{i,j};
        r1 = N*f;
        % disp(tempr2);
        % disp('second');
        % disp(eigenvector);
        r2 = N*h*eigenvector;

        x = -r1/r2;
        Xstar(i,j) = x;
        
        r2val=[r2val,r2];
        
        % this step is to check whether xstar is within [-0.5,0.5]
        if ((-0.5<=x && x<=0.5)==1 && (eigNoiseMatrix(i,j) ~= 1) && r2>.09)
            plot(j,i,'red');
        end
    end
end
r2val
mean(r2val)


