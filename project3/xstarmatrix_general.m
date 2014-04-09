% H is the output of hessianmatrix function
% E is the output of eigenmatrix function
function [ Xstar ] = xstarmatrix_general(img, w, sigma)
H = hessianmatrix(img, w, sigma);
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


for i = 1:m
    for j = 1:n
        f = zeros(2,1);
        f(1,1) = FX(i,j);
        f(2,1) = FY(i,j);

        eigenvector = E{i,j};
        % traverse eigenvector
        N = zeros(1,2);
        N(1,1) = eigenvector(1);
        N(1,2) = eigenvector(2);
        % h is the hessian matrix for each pixel
        h = H{i,j};
        % first and second directional derivative
        r1 = N*f;
        r2 = N*h*eigenvector;

        x = -r1/r2;
        % xstar matrix
        Xstar(i,j) = x;

        % this step is to check whether xstar is within [-0.5,0.5]
        if ((-0.5<=x && x<=0.5)==1 && (eigNoiseMatrix(i,j) ~= 1) && (r2>.1))
            plot(j,i,'red');
        end
    end
end


hold off
