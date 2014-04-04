% User's image location settings
inputDir1 = 'microscope_char';
inputDir2 = 'DrosophilaVesicleTransport';
filename = 'APPYFPX_Lgt_a07r10s01_001.tif';
outputDir = 'CroppedImages';

imagePath = ['microscope_char', filesep, 'DrosophilaVesicleTransport', filesep, 'APPYFPX_Lgt_a07r10s01_001.tif'];     % Cross-platform format
I = imread(imagePath);
I=double(I);
figure('Name', 'Please select the background of this image to be tested for background illumination uniformity');
imshow(I, []);

rect = getrect();
croppedRegion = imcrop(I, rect);
close;

% Create directory if doesn't exist
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

ID=[]
IU=[]

structOfImages = dir([inputDir1, filesep, inputDir2, filesep, '*.tif']);
for i = 1:length(structOfImages)
    i
    filename = structOfImages(i).name;
    %filenameOut = ['cropped_', filename];
    %filePathOut = [outputDir, filesep, filenameOut];

    imagePath = [inputDir1, filesep, inputDir2, filesep, filename];
    I = imread(imagePath);
    I=double(I);
    croppedRegion = imcrop(I, rect);
    %imwrite(croppedRegion, filePathOut, 'tiff', 'Compression','none');

    illuminationdifference=pairedregionilluminationdifferencecheker(croppedRegion)
    ID=[ID, illuminationdifference];
    illuminationuniformity=1-illuminationdifference
    IU=[IU, illuminationuniformity];

end

figure()
plot(1:length(structOfImages),ID)
figure()
plot(1:length(structOfImages),IU)

