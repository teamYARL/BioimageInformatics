function test(filename, filePathOut)
%  This Matlab code demonstrates an edge-based active contour model as an application of 
%  the Distance Regularized Level Set Evolution (DRLSE) formulation in the following paper:
%
%  C. Li, C. Xu, C. Gui, M. D. Fox, "Distance Regularized Level Set Evolution and Its Application to Image Segmentation", 
%     IEEE Trans. Image Processing, vol. 19 (12), pp. 3243-3254, 2010.
%
% Author: Chunming Li, all rights reserved
% E-mail: lchunming@gmail.com   
%         li_chunming@hotmail.com 
% URL:  http://www.imagecomputing.org/~cmli/

%clear all;
%close all;

%Img = imread('twocells.bmp'); % real miscroscope image of cells

Img = imread(filename);

Img=double(Img(:,:,1));
%% parameter setting
timestep=5;  % time step
mu=0.2/timestep;  % coefficient of the distance regularization term R(phi)
iter_inner=5;
iter_outer=25;
lambda=5; % coefficient of the weighted length term L(phi)
alfa=1.5;  % coefficient of the weighted area term A(phi)
epsilon=1.5; % papramater that specifies the width of the DiracDelta function

sigma=1.5;     % scale parameter in Gaussian kernel
G=fspecial('gaussian',15,sigma);
Img_smooth=conv2(Img,G,'same');  % smooth image by Gaussiin convolution
[Ix,Iy]=gradient(Img_smooth);
f=Ix.^2+Iy.^2;
g=1./(1+f);  % edge indicator function.

% initialize LSF as binary step function
c0=2;
initialLSF=c0*ones(size(Img));
% generate the initial region R0 as a rectangle

initialLSF(80:95, 6:600)=-c0;  

%initialLSF(1:100,5:130)=-c0;     for Blue0001
%initialLSF(105:223,5:130)=-c0;
%initialLSF(1:110,140:295)=-c0;
%initialLSF(115:223,140:290)=-c0;
 
%initialLSF(100:105,145:153)=-c0;  for 60x
%initialLSF(100:105,165:173)=-c0;
%initialLSF(80:85,145:153)=-c0;
%initialLSF(80:85,165:173)=-c0;

%initialLSF(10:20,40:50)=-c0;      for 60x
%initialLSF(10:40,240:270)=-c0;
%initialLSF(145:175,40:70)=-c0;
%initialLSF(145:175,240:260)=-c0;

phi=initialLSF;

figure(1);
mesh(-phi);   % for a better view, the LSF is displayed upside down
hold on;  contour(phi, [0,0], 'r','LineWidth',2);
title('Initial level set function');
view([-80 35]);

figure(2);
imagesc(Img,[0, 255]); axis off; axis equal; colormap(gray); hold on;  contour(phi, [0,0], 'r');
title('Initial zero level contour');
pause(0.5);

potential=2;  
if potential ==1
    potentialFunction = 'single-well';  % use single well potential p1(s)=0.5*(s-1)^2, which is good for region-based model 
elseif potential == 2
    potentialFunction = 'double-well';  % use double-well potential in Eq. (16), which is good for both edge and region based models
else
    potentialFunction = 'double-well';  % default choice of potential function
end


% start level set evolution
for n=1:iter_outer
    phi = drlse_edge(phi, g, lambda, mu, alfa, epsilon, timestep, iter_inner, potentialFunction);
    if mod(n,2)==0
        figure(2);
        imagesc(Img,[0, 255]); axis off; axis equal; colormap(gray); hold on;  contour(phi, [0,0], 'r');
        
        %size(Img);
        %size(phi)
        
        %filenameOut = ['evolution_',num2str(n, '%03d\n'),'.tif'];
        %filePathOut = ['result', filesep, filenameOut];
        
        %if ~exist('result', 'dir')
         %   mkdir('result');
        %end
        
        %imwrite(phi, filePathOut, 'tif', 'Compression','none');
        if n == iter_outer
            imwrite(phi, filePathOut, 'tif', 'Compression','none');
        end
    end
end

% refine the zero level contour by further level set evolution with alfa=0
alfa=0;
iter_refine = 10;
phi = drlse_edge(phi, g, lambda, mu, alfa, epsilon, timestep, iter_inner, potentialFunction);

finalLSF=phi;
figure(2);
imagesc(Img,[0, 255]); axis off; axis equal; colormap(gray); hold on;  contour(phi, [0,0], 'r');
hold on;  contour(phi, [0,0], 'r');
str=['Final zero level contour, ', num2str(iter_outer*iter_inner+iter_refine), ' iterations'];
title(str);

pause(1);
figure;
mesh(-finalLSF); % for a better view, the LSF is displayed upside down
hold on;  contour(phi, [0,0], 'r','LineWidth',2);
str=['Final level set function, ', num2str(iter_outer*iter_inner+iter_refine), ' iterations'];
title(str);
axis on;



