function [ Xstar_bin, Xstar_mag ] = xstarmatrix_general(img, w, sigma)
%Output
%   Xstar_bin is a (x,y) coordinates of x*
%   Xstar_mag is the magnitude of x*
% This function is used in question C.2

H = hessianmatrix(img, w, sigma);
[E,eigNoiseMatrix] = eigenmatrix(H);
img=double(img);
% get size of H
[m,n] = size(img);
Xstar = zeros(m,n);     % notation: zeros(col,row)

[FX,FY] = gradient(img);

Xstar_x = [1:n];
Xstar_x = Xstar_x';
Xstar_y = zeros(n,1);    % to be filled of height n within x* loop
% to be combined to Xstar_bin when exiting loop
Xstar_mag = zeros(n,1);  % magnitude of x* corresponding to Xstar_bin coordinates

% create a whole black image with same size to check marked xstar
I = zeros(m,n);
figure('Name','x*'), imshow(I,[])

hold on


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

        % this step is to check whether xstar is within [-0.5,0.5]
        if ((-0.5<=x && x<=0.5)==1 && (eigNoiseMatrix(i,j) ~= 1) && (r2>.1))
            plot(j,i,'red');
            Xstar_y(j) = i;
            Xstar_mag(j) = x;
        end
    end
end

hold off

Xstar_bin = [Xstar_x, Xstar_y];     % 2-column matrix (x,y)
figure('Name','x* bin'), plot(Xstar_bin(:,1), Xstar_bin(:,2), 'k.')
