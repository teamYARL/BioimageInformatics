%===============================================================================
% Settings
%   Adjust position of variable `max_numOfx` on line 45, setting inside the loop
%===============================================================================
max_propagationScaling = 5;
max_curvatureScaling = 5;
max_setMaximumRMSError = 5;
max_setNumberOfIterations = 10;

% User's image location settings
inputDir1 = 'Mito_GFP_a01';
filename = 'MitoGFP_LgtGal4_a01r01s02001.tif';
outputDir = 'results_b22_SSDLS_segmented_Images'

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
    filenameOut = ['SSDLS_SEG_', filename];
    filePathOut = [outputDir, filesep, filenameOut];

    imagePath = [inputDir1, filesep, filename];
    Img = double(imread(imagePath));
    imgSize = size(Img);
    % in order to use matitk, we have to use 3D data
    % so we first build a 3D volume of two layers, and each layer
    % contains the original image
    D = zeros(imgSize(1),imgSize(2),2);
    D(1:imgSize(1),1:imgSize(2),1) = Img(1:imgSize(1),1:imgSize(2));
    D(1:imgSize(1),1:imgSize(2),2) = Img(1:imgSize(1),1:imgSize(2));

    % implement segmentation
    settings = [propagationScaling curvatureScaling setMaximumRMSError setNumberOfIterations];
    b = matitk('SSDLS', settings, uint8(D), uint8(gradient(D)), []);
    imwrite(squeeze(b(:,:,1)), filePathOut, 'tiff', 'Compression','none');
end
