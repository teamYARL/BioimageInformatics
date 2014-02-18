% Project Assignment 1, Question 3.2: crop image and save channel separately
%===============================================================================
clear, close all
fname = 'images/001_a5_002_t001.tif';
fname_out_without_extension = 'project02_image_cropped';

% Bypass write permission error by creating folder
path_out = 'temp';     % Folder/directory name
mkdir(path_out);        % Create directory; Needed for imwrite write permission.

% for forloop speedup
info = imfinfo(fname);      % Gives struct array with fields on all the images
num_images = numel(info);   % Number of elements

% Show image and manually crop
I = imread(fname);
figure, imshow(I, [])
fprintf('Please select a region of interest in the image.\n')
rect = getrect();

% Store cropped image
I_cropped = imcrop(I, rect);
fname_out = strcat('temp/',fname_out_without_extension,'.tiff')
imwrite(I_cropped, fname_out, 'tiff', 'Compression','none')
I_cropped_info = imfinfo(fname_out)


%for k = 1:num_images
%    A = imread(fname, k, 'Info', info);     % Speedup by passing info
%    A2 = imcrop(A, rect);
%    fname_out = strcat(fname_out_without_extension,int2str(k),'.tiff')
%    imwrite(A2, fname_out, 'tiff', 'Compression','none')
%end
%
%fprintf('There are %d channels in %s\n', num_images, fname)
%fprintf('The channels are saved as:\n')
%for k = 1:num_images
%    fprintf('  %s%d.tiff\n', fname_out_without_extension, k)
%end
