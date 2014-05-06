% Project Assignment #3
%===============================================================================
% B.2 : Crop background and save cropped image sequentially witout compression
%===============================================================================
% User's image location settings
inputDir1 = 'Mito_GFP_a01';
%inputDir2 = 'DrosophilaVesicleTransport';
filename = 'MitoGFP_LgtGal4_a01r01s02001.tif';
outputDir = 'SOT_segmented_Images'

%imagePath = [inputDir1, filesep, inputDir2, filesep, filename];     % Cross-platform format
imagePath = [inputDir1, filesep, filename];     % Cross-platform format
I = imread(imagePath);
figure('Name', 'First image in Sequence to be segmented'), imshow(I, [])

% Create directory if doesn't exist
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

structOfImages = dir([inputDir1, filesep, '*.tif']);
for i = 1:length(structOfImages)
    filename = structOfImages(i).name;
    filenameOut = ['SOT_SEG_', filename];
    filePathOut = [outputDir, filesep, filenameOut];
    
    filenameOut
    
    imagePath = [inputDir1, filesep, filename];
    Img = double(imread(imagePath));
    %if i==1
        maxintensity=max(Img(:));
        numOfHistograms=maxintensity
        disp('ok!!!')
    %end
    imgSize = size(Img);
    % in order to use matitk, we have to use 3D data
    % so we first build a 3D volume of two layers, and each layer
    % contains the original image
    D = zeros(imgSize(1),imgSize(2),2);
    D(1:imgSize(1),1:imgSize(2),1) = Img(1:imgSize(1),1:imgSize(2));
    D(1:imgSize(1),1:imgSize(2),2) = Img(1:imgSize(1),1:imgSize(2));

    % implement segmentation using Otsu's method
    %b = matitk('SOT',[max(D(:))], double(D));
    b = matitk('SOT',[numOfHistograms], double(D));
    imwrite(squeeze(b(:,:,1)), filePathOut, 'tiff', 'Compression','none');
end
