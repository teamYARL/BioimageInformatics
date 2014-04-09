% Project Assignment #3
%===============================================================================
% B.2 : Crop background and save cropped image sequentially witout compression
%===============================================================================
% User's image location settings
inputDir1 = 'microscope_char';
inputDir2 = 'DrosophilaVesicleTransport';
filename = 'APPYFPX_Lgt_a07r10s01_001.tif';
outputDir = 'CroppedImages_2';

imagePath = [inputDir1, filesep, inputDir2, filesep, filename];     % Cross-platform format
I = imread(imagePath);
figure('Name', 'Please select the background of this image to be saved'), imshow(I, [])

rect = getrect();
croppedRegion = imcrop(I, rect);
close;

% Create directory if doesn't exist
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

structOfImages = dir([inputDir1, filesep, inputDir2, filesep, '*.tif']);
for i = 1:length(structOfImages)
    filename = structOfImages(i).name;
    filenameOut = ['cropped_', filename];
    filePathOut = [outputDir, filesep, filenameOut];

    imagePath = [inputDir1, filesep, inputDir2, filesep, filename];
    I = imread(imagePath);
    croppedRegion = imcrop(I, rect);
    imwrite(croppedRegion, filePathOut, 'tiff', 'Compression','none');
end
